///|
/// # opcore/transform 变换与增强算子 / Transform & Augment Operators
///
/// 文本增强、图像/音频/视频变换。架构 §4.3.2 ⑦。
/// S1.1 填充：to_lowercase + to_uppercase + truncate（文本变换基礎）。
///
/// # Transform operators
///
/// Text/image/audio/video transform. See architecture §4.3.2 ⑦.

///|
/// 转小写 / Convert content to lowercase.
pub fn transform_to_lowercase(input : @dataobject.DataObject) -> @dataobject.DataObject {
  let lowered = String::from_array(
    input.content.to_array().map(fn(c) { c.to_ascii_lowercase() }),
  )
  @dataobject.make_dataobject_with_metadata(
    lowered,
    input.modality,
    input.schema,
    input.metadata,
  )
}

///|
/// 转大写 / Convert content to uppercase.
pub fn transform_to_uppercase(input : @dataobject.DataObject) -> @dataobject.DataObject {
  let uppered = String::from_array(
    input.content.to_array().map(fn(c) { c.to_ascii_uppercase() }),
  )
  @dataobject.make_dataobject_with_metadata(
    uppered,
    input.modality,
    input.schema,
    input.metadata,
  )
}

///|
/// 截断：保留前 max_len 字符 / Truncate to max_len characters.
pub fn transform_truncate(
  input : @dataobject.DataObject,
  max_len : Int32,
) -> @dataobject.DataObject {
  let truncated = if input.content.length() <= max_len {
    input.content
  } else {
    String::from_array(input.content.to_array()[0:max_len])
  }
  @dataobject.make_dataobject_with_metadata(
    truncated,
    input.modality,
    input.schema,
    input.metadata,
  )
}

///|
pub fn transform_transform_id() -> String {
  "opcore/transform"
}

// ============================================================
// S6.1 栅格条件分析 / Raster conditional analysis
// 对标 ArcGIS Pro: Con / Pick / Set Null / Reclassify / Slice / Lookup
// ============================================================

///|
/// 条件赋值 / Conditional assignment (Con).
///
/// 对标 ArcGIS Pro Con 工具。
/// 如果 condition 栅格值 > 0，取 true_raster 值，否则取 false_raster 值。
/// 退化安全：尺寸不匹配返回空栅格。
pub fn transform_transform_conditional(
  condition : @spatial.RasterGrid,
  true_raster : @spatial.RasterGrid,
  false_raster : @spatial.RasterGrid,
) -> @spatial.RasterGrid {
  let rows = @spatial.hydrology_raster_rows(condition)
  let cols = @spatial.hydrology_raster_cols(condition)
  if rows != @spatial.hydrology_raster_rows(true_raster) ||
    cols != @spatial.hydrology_raster_cols(true_raster) ||
    rows != @spatial.hydrology_raster_rows(false_raster) ||
    cols != @spatial.hydrology_raster_cols(false_raster) {
    @spatial.hydrology_make_raster([])
  } else {
    let result : Array[Array[Double]] = []
    for i in 0..<rows {
      let row : Array[Double] = []
      for j in 0..<cols {
        if @spatial.hydrology_raster_get(condition, i, j) > 0.0 {
          row.push(@spatial.hydrology_raster_get(true_raster, i, j))
        } else {
          row.push(@spatial.hydrology_raster_get(false_raster, i, j))
        }
      }
      result.push(row)
    }
    @spatial.hydrology_make_raster(result)
  }
}

///|
/// 位置选择 / Pick by position.
///
/// 对标 ArcGIS Pro Pick 工具。
/// 从 input_rasters 中按 position 栅格的值选择对应栅格的值。
/// 退化安全：位置越界或空数组返回空栅格。
pub fn transform_transform_pick(
  position : @spatial.RasterGrid,
  input_rasters : Array[@spatial.RasterGrid],
) -> @spatial.RasterGrid {
  let rows = @spatial.hydrology_raster_rows(position)
  let cols = @spatial.hydrology_raster_cols(position)
  if input_rasters.length() == 0 || rows == 0 || cols == 0 {
    @spatial.hydrology_make_raster([])
  } else {
    let result : Array[Array[Double]] = []
    for i in 0..<rows {
      let row : Array[Double] = []
      for j in 0..<cols {
        let idx = @spatial.hydrology_raster_get(position, i, j).to_int()
        if idx >= 0 &&
          idx < input_rasters.length() &&
          i < @spatial.hydrology_raster_rows(input_rasters[idx]) &&
          j < @spatial.hydrology_raster_cols(input_rasters[idx]) {
          row.push(@spatial.hydrology_raster_get(input_rasters[idx], i, j))
        } else {
          row.push(0.0)
        }
      }
      result.push(row)
    }
    @spatial.hydrology_make_raster(result)
  }
}

///|
/// 设空 / Set Null.
///
/// 对标 ArcGIS Pro Set Null 工具。
/// 将满足条件（值 > 0）的单元格设为 NoData（用 -9999 表示）。
/// 退化安全：空栅格返回空栅格。
pub fn transform_transform_set_null(
  condition : @spatial.RasterGrid,
  input_raster : @spatial.RasterGrid,
) -> @spatial.RasterGrid {
  let rows = @spatial.hydrology_raster_rows(condition)
  let cols = @spatial.hydrology_raster_cols(condition)
  if rows != @spatial.hydrology_raster_rows(input_raster) ||
    cols != @spatial.hydrology_raster_cols(input_raster) {
    @spatial.hydrology_make_raster([])
  } else {
    let result : Array[Array[Double]] = []
    for i in 0..<rows {
      let row : Array[Double] = []
      for j in 0..<cols {
        if @spatial.hydrology_raster_get(condition, i, j) > 0.0 {
          row.push(-9999.0)
        } else {
          row.push(@spatial.hydrology_raster_get(input_raster, i, j))
        }
      }
      result.push(row)
    }
    @spatial.hydrology_make_raster(result)
  }
}

///|
/// 重分类 / Reclassify.
///
/// 对标 ArcGIS Pro Reclassify 工具。
/// 按重分类映射表将值重新分类。映射表为 (old_min, old_max, new_value) 三元组数组。
/// 退化安全：无匹配范围返回原值。
pub fn transform_transform_reclassify(
  input_raster : @spatial.RasterGrid,
  remap : Array[(Double, Double, Double)],
) -> @spatial.RasterGrid {
  let rows = @spatial.hydrology_raster_rows(input_raster)
  let cols = @spatial.hydrology_raster_cols(input_raster)
  let result : Array[Array[Double]] = []
  for i in 0..<rows {
    let row : Array[Double] = []
    for j in 0..<cols {
      let v = @spatial.hydrology_raster_get(input_raster, i, j)
      let mut new_val = v
      for (lo, hi, nv) in remap {
        if v >= lo && v <= hi {
          new_val = nv
        }
      }
      row.push(new_val)
    }
    result.push(row)
  }
  @spatial.hydrology_make_raster(result)
}

///|
/// 切片 / Slice.
///
/// 对标 ArcGIS Pro Slice 工具。
/// 将值范围 [min, max] 等分成 n_slices 个等级，返回等级编号（1-based）。
/// 退化安全：n_slices <= 0 或值范围为 0 返回原栅格。
pub fn transform_transform_slice(
  input_raster : @spatial.RasterGrid,
  n_slices : Int32,
) -> @spatial.RasterGrid {
  let rows = @spatial.hydrology_raster_rows(input_raster)
  let cols = @spatial.hydrology_raster_cols(input_raster)
  if n_slices <= 0 || rows == 0 || cols == 0 {
    input_raster
  } else {
    let mut min_v = @spatial.hydrology_raster_get(input_raster, 0, 0)
    let mut max_v = min_v
    for i in 0..<rows {
      for j in 0..<cols {
        let v = @spatial.hydrology_raster_get(input_raster, i, j)
        if v < min_v {
          min_v = v
        }
        if v > max_v {
          max_v = v
        }
      }
    }
    let range = max_v - min_v
    if range == 0.0 {
      input_raster
    } else {
      let result : Array[Array[Double]] = []
      for i in 0..<rows {
        let row : Array[Double] = []
        for j in 0..<cols {
          let v = @spatial.hydrology_raster_get(input_raster, i, j)
          let raw_slice = ((v - min_v) / range * n_slices.to_double()).to_int() +
            1
          let slice = if raw_slice > n_slices { n_slices } else { raw_slice }
          row.push(slice.to_double())
        }
        result.push(row)
      }
      @spatial.hydrology_make_raster(result)
    }
  }
}

///|
/// 查找 / Lookup.
///
/// 对标 ArcGIS Pro Lookup 工具。
/// 按栅格值作为索引在查找表中找到新值。
/// 退化安全：索引越界返回 0.0。
pub fn transform_transform_lookup(
  input_raster : @spatial.RasterGrid,
  lookup_table : Array[Double],
) -> @spatial.RasterGrid {
  let rows = @spatial.hydrology_raster_rows(input_raster)
  let cols = @spatial.hydrology_raster_cols(input_raster)
  let result : Array[Array[Double]] = []
  for i in 0..<rows {
    let row : Array[Double] = []
    for j in 0..<cols {
      let idx = @spatial.hydrology_raster_get(input_raster, i, j).to_int()
      if idx >= 0 && idx < lookup_table.length() {
        row.push(lookup_table[idx])
      } else {
        row.push(0.0)
      }
    }
    result.push(row)
  }
  @spatial.hydrology_make_raster(result)
}
