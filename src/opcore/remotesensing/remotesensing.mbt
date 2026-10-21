///|
/// # opcore/remotesensing 遥感分析算子 / Remote Sensing Operators
///
/// 遥感分析算子契约 + 简化实现。架构 §4.3 opcore 扩展。
/// S9.6 新建：NDVI/NDWI/EVI/Classification/BandMath +15 fn。
/// 对标 ArcGIS Pro Image Analyst → Raster Functions 扩展。
///
/// # Remote sensing operators

///|
/// 多波段图像 / Multi-band image.
pub struct MultiBandImage {
  width : Int32
  height : Int32
  bands : Array[Array[Double]]
}

///|
/// 构造多波段图像 / Create multi-band image.
pub fn make_multiband(
  width : Int32,
  height : Int32,
  bands : Array[Array[Double]],
) -> MultiBandImage {
  { width, height, bands, }
}

///|
/// 波段数 / Band count.
pub fn band_count(img : MultiBandImage) -> Int32 {
  img.bands.length()
}

///|
/// 安全获取像素值 / Safe pixel access.
fn get_band_pixel(
  img : MultiBandImage,
  band : Int32,
  row : Int32,
  col : Int32,
) -> Double {
  if band < 0 || band >= img.bands.length() {
    return 0.0
  }
  if row < 0 || row >= img.height || col < 0 || col >= img.width {
    return 0.0
  }
  img.bands[band][row * img.width + col]
}

///===
/// 植被指数

///|
/// NDVI / Normalized Difference Vegetation Index.
/// NDVI = (NIR - Red) / (NIR + Red)
pub fn ndvi(
  img : MultiBandImage,
  nir_band : Int32,
  red_band : Int32,
) -> Array[Double] {
  let result : Array[Double] = []
  for r in 0..<img.height {
    for c in 0..<img.width {
      let nir = get_band_pixel(img, nir_band, r, c)
      let red = get_band_pixel(img, red_band, r, c)
      let denom = nir + red
      if denom == 0.0 {
        result.push(0.0)
      } else {
        result.push((nir - red) / denom)
      }
    }
  }
  result
}

///|
/// EVI / Enhanced Vegetation Index.
/// EVI = 2.5 * (NIR - Red) / (NIR + 6*Red - 7.5*Blue + 1)
pub fn evi(
  img : MultiBandImage,
  nir_band : Int32,
  red_band : Int32,
  blue_band : Int32,
) -> Array[Double] {
  let result : Array[Double] = []
  for r in 0..<img.height {
    for c in 0..<img.width {
      let nir = get_band_pixel(img, nir_band, r, c)
      let red = get_band_pixel(img, red_band, r, c)
      let blue = get_band_pixel(img, blue_band, r, c)
      let denom = nir + 6.0 * red - 7.5 * blue + 1.0
      if denom == 0.0 {
        result.push(0.0)
      } else {
        result.push(2.5 * (nir - red) / denom)
      }
    }
  }
  result
}

///|
/// SAVI / Soil-Adjusted Vegetation Index.
pub fn savi(
  img : MultiBandImage,
  nir_band : Int32,
  red_band : Int32,
  l : Double,
) -> Array[Double] {
  let result : Array[Double] = []
  for r in 0..<img.height {
    for c in 0..<img.width {
      let nir = get_band_pixel(img, nir_band, r, c)
      let red = get_band_pixel(img, red_band, r, c)
      let denom = nir + red + l
      if denom == 0.0 {
        result.push(0.0)
      } else {
        result.push((nir - red) / denom * (1.0 + l))
      }
    }
  }
  result
}

///===
/// 水体指数

///|
/// NDWI / Normalized Difference Water Index.
/// NDWI = (Green - NIR) / (Green + NIR)
pub fn ndwi(
  img : MultiBandImage,
  green_band : Int32,
  nir_band : Int32,
) -> Array[Double] {
  let result : Array[Double] = []
  for r in 0..<img.height {
    for c in 0..<img.width {
      let green = get_band_pixel(img, green_band, r, c)
      let nir = get_band_pixel(img, nir_band, r, c)
      let denom = green + nir
      if denom == 0.0 {
        result.push(0.0)
      } else {
        result.push((green - nir) / denom)
      }
    }
  }
  result
}

///|
/// MNDWI / Modified NDWI.
/// MNDWI = (Green - SWIR) / (Green + SWIR)
pub fn mndwi(
  img : MultiBandImage,
  green_band : Int32,
  swir_band : Int32,
) -> Array[Double] {
  let result : Array[Double] = []
  for r in 0..<img.height {
    for c in 0..<img.width {
      let green = get_band_pixel(img, green_band, r, c)
      let swir = get_band_pixel(img, swir_band, r, c)
      let denom = green + swir
      if denom == 0.0 {
        result.push(0.0)
      } else {
        result.push((green - swir) / denom)
      }
    }
  }
  result
}

///===
/// 建筑指数

///|
/// NDBI / Normalized Difference Built-up Index.
/// NDBI = (SWIR - NIR) / (SWIR + NIR)
pub fn ndbi(
  img : MultiBandImage,
  swir_band : Int32,
  nir_band : Int32,
) -> Array[Double] {
  let result : Array[Double] = []
  for r in 0..<img.height {
    for c in 0..<img.width {
      let swir = get_band_pixel(img, swir_band, r, c)
      let nir = get_band_pixel(img, nir_band, r, c)
      let denom = swir + nir
      if denom == 0.0 {
        result.push(0.0)
      } else {
        result.push((swir - nir) / denom)
      }
    }
  }
  result
}

///===
/// 波段运算

///|
/// 波段减法 / Band subtraction.
pub fn band_subtract(
  img : MultiBandImage,
  band1 : Int32,
  band2 : Int32,
) -> Array[Double] {
  let result : Array[Double] = []
  for r in 0..<img.height {
    for c in 0..<img.width {
      result.push(
        get_band_pixel(img, band1, r, c) - get_band_pixel(img, band2, r, c),
      )
    }
  }
  result
}

///|
/// 波段比值 / Band ratio.
pub fn band_ratio(
  img : MultiBandImage,
  band1 : Int32,
  band2 : Int32,
) -> Array[Double] {
  let result : Array[Double] = []
  for r in 0..<img.height {
    for c in 0..<img.width {
      let b1 = get_band_pixel(img, band1, r, c)
      let b2 = get_band_pixel(img, band2, r, c)
      if b2 == 0.0 {
        result.push(0.0)
      } else {
        result.push(b1 / b2)
      }
    }
  }
  result
}

///===
/// 分类

///|
/// 阈值分类 / Threshold classification.
pub fn threshold_classify(
  values : Array[Double],
  thresholds : Array[Double],
) -> Array[Int32] {
  let result : Array[Int32] = []
  for i in 0..<values.length() {
    let mut class_id = 0
    for j in 0..<thresholds.length() {
      if values[i] >= thresholds[j] {
        class_id = j + 1
      }
    }
    result.push(class_id)
  }
  result
}

///|
/// 监督分类（简化）/ Supervised classification (simplified, nearest mean).
pub fn supervised_classify(
  values : Array[Double],
  class_means : Array[(Int32, Double)],
) -> Array[Int32] {
  let result : Array[Int32] = []
  for i in 0..<values.length() {
    let mut best_class = 0
    let mut best_dist = 999999.0
    for j in 0..<class_means.length() {
      let (cls, mean) = class_means[j]
      let dist = (values[i] - mean) * (values[i] - mean)
      if dist < best_dist {
        best_dist = dist
        best_class = cls
      }
    }
    result.push(best_class)
  }
  result
}

///===
/// 统计

///|
/// 波段统计 / Band statistics (min, max, mean, std).
pub fn band_stats(
  img : MultiBandImage,
  band : Int32,
) -> (Double, Double, Double, Double) {
  if band < 0 || band >= img.bands.length() {
    return (0.0, 0.0, 0.0, 0.0)
  }
  let pixels = img.bands[band]
  let n = pixels.length()
  if n == 0 {
    return (0.0, 0.0, 0.0, 0.0)
  }
  let mut min_v = pixels[0]
  let mut max_v = pixels[0]
  let mut sum = 0.0
  for i in 0..<n {
    if pixels[i] < min_v {
      min_v = pixels[i]
    }
    if pixels[i] > max_v {
      max_v = pixels[i]
    }
    sum = sum + pixels[i]
  }
  let mean = sum / n.to_double()
  let mut variance = 0.0
  for i in 0..<n {
    let diff = pixels[i] - mean
    variance = variance + diff * diff
  }
  (min_v, max_v, mean, (variance / n.to_double()).sqrt())
}

///|
///===
/// ID
pub fn remotesensing_id() -> String {
  "opcore/remotesensing"
}
