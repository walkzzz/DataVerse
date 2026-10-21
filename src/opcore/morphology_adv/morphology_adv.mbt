///|
/// # opcore/morphology_adv 高级形态学算子 / Advanced Morphology Operators
///
/// 高级形态学算法集合：腐蚀/膨胀/开闭/骨架/距离变换/分水岭/重构/属性滤波/粒度等。
/// 纯 MoonBit 实现，无外部依赖。

/// 形态学图像 / Morphology image (binary/grayscale, Double data).
pub struct MorphImage {
  width : Int
  height : Int
  data : Array[Double]
} derive(Debug, Eq)

pub extend MorphImage with Eq::{equal, not_equal}
pub extend MorphImage with Debug::{to_repr}

/// 结构元素 / Structuring element.
pub struct StructElement {
  width : Int
  height : Int
  data : Array[Bool]
} derive(Debug, Eq)

pub extend StructElement with Eq::{equal, not_equal}
pub extend StructElement with Debug::{to_repr}

fn morph_empty(w : Int, h : Int) -> MorphImage {
  let n = w * h
  let data : Array[Double] = []
  for _ in 0..<n {
    data.push(0.0)
  }
  { width: w, height: h, data }
}

fn morph_pixel(img : MorphImage, x : Int, y : Int) -> Double {
  if x < 0 || x >= img.width || y < 0 || y >= img.height {
    return 0.0
  }
  let idx = y * img.width + x
  if idx < 0 || idx >= img.data.length() {
    return 0.0
  }
  img.data[idx]
}

fn morph_set_pixel(img : MorphImage, x : Int, y : Int, v : Double) -> Unit {
  if x < 0 || x >= img.width || y < 0 || y >= img.height {
    return
  }
  let idx = y * img.width + x
  if idx >= 0 && idx < img.data.length() {
    img.data[idx] = v
  }
}

fn morph_max(a : Double, b : Double) -> Double {
  if a > b {
    a
  } else {
    b
  }
}

fn morph_min(a : Double, b : Double) -> Double {
  if a < b {
    a
  } else {
    b
  }
}

/// 构造形态学图像 / Build morphology image.
pub fn make_morph_image(width : Int, height : Int, data : Array[Double]) -> MorphImage {
  { width, height, data }
}

/// 空形态学图像 / Empty morphology image.
pub fn morph_empty_image(width : Int, height : Int) -> MorphImage {
  morph_empty(width, height)
}

/// 克隆形态学图像 / Clone morphology image.
pub fn morph_clone(img : MorphImage) -> MorphImage {
  let data : Array[Double] = []
  for i in 0..<img.data.length() {
    data.push(img.data[i])
  }
  { width: img.width, height: img.height, data }
}

/// 构造结构元素 / Build structuring element.
pub fn morph_make_kernel(width : Int, height : Int, data : Array[Bool]) -> StructElement {
  { width, height, data }
}

/// 十字结构元素 / Cross structuring element.
pub fn morph_cross_kernel(size : Int) -> StructElement {
  let data : Array[Bool] = []
  let half = size / 2
  for y in 0..<size {
    for x in 0..<size {
      data.push(x == half || y == half)
    }
  }
  { width: size, height: size, data }
}

/// 方形结构元素 / Square structuring element.
pub fn morph_square_kernel(size : Int) -> StructElement {
  let data : Array[Bool] = []
  for _ in 0..<(size * size) {
    data.push(true)
  }
  { width: size, height: size, data }
}

/// 圆形结构元素 / Circle structuring element.
pub fn morph_circle_kernel(radius : Int) -> StructElement {
  let size = 2 * radius + 1
  let data : Array[Bool] = []
  for y in 0..<size {
    for x in 0..<size {
      let dx = x - radius
      let dy = y - radius
      data.push(dx * dx + dy * dy <= radius * radius)
    }
  }
  { width: size, height: size, data }
}

/// 高级腐蚀 / Advanced erosion.
pub fn morph_erode_adv(img : MorphImage, se : StructElement) -> MorphImage {
  let out = morph_empty(img.width, img.height)
  let half_w = se.width / 2
  let half_h = se.height / 2
  for y in 0..<img.height {
    for x in 0..<img.width {
      let mut min_v = 999999.0
      let mut found = false
      for sy in 0..<se.height {
        for sx in 0..<se.width {
          if !(se.data[sy * se.width + sx]) {
            continue
          }
          let v = morph_pixel(img, x + sx - half_w, y + sy - half_h)
          if v < min_v {
            min_v = v
            found = true
          }
        }
      }
      if found {
        morph_set_pixel(out, x, y, min_v)
      }
    }
  }
  out
}

/// 高级膨胀 / Advanced dilation.
pub fn morph_dilate_adv(img : MorphImage, se : StructElement) -> MorphImage {
  let out = morph_empty(img.width, img.height)
  let half_w = se.width / 2
  let half_h = se.height / 2
  for y in 0..<img.height {
    for x in 0..<img.width {
      let mut max_v = 0.0
      for sy in 0..<se.height {
        for sx in 0..<se.width {
          if !(se.data[sy * se.width + sx]) {
            continue
          }
          let v = morph_pixel(img, x + sx - half_w, y + sy - half_h)
          if v > max_v {
            max_v = v
          }
        }
      }
      morph_set_pixel(out, x, y, max_v)
    }
  }
  out
}

/// 高级开运算 / Advanced opening.
pub fn morph_open_adv(img : MorphImage, se : StructElement) -> MorphImage {
  let eroded = morph_erode_adv(img, se)
  morph_dilate_adv(eroded, se)
}

/// 高级闭运算 / Advanced closing.
pub fn morph_close_adv(img : MorphImage, se : StructElement) -> MorphImage {
  let dilated = morph_dilate_adv(img, se)
  morph_erode_adv(dilated, se)
}

/// 形态学梯度 / Morphological gradient.
pub fn morph_gradient(img : MorphImage, se : StructElement) -> MorphImage {
  let d = morph_dilate_adv(img, se)
  let e = morph_erode_adv(img, se)
  let out = morph_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      morph_set_pixel(out, x, y, morph_pixel(d, x, y) - morph_pixel(e, x, y))
    }
  }
  out
}

/// Top-hat 变换 / Top-hat transform.
pub fn morph_tophat(img : MorphImage, se : StructElement) -> MorphImage {
  let opened = morph_open_adv(img, se)
  let out = morph_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      morph_set_pixel(out, x, y, morph_pixel(img, x, y) - morph_pixel(opened, x, y))
    }
  }
  out
}

/// Black-hat 变换 / Black-hat transform.
pub fn morph_blackhat(img : MorphImage, se : StructElement) -> MorphImage {
  let closed = morph_close_adv(img, se)
  let out = morph_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      morph_set_pixel(out, x, y, morph_pixel(closed, x, y) - morph_pixel(img, x, y))
    }
  }
  out
}

/// 击中击不中变换 / Hit-or-miss transform.
pub fn morph_hit_miss(img : MorphImage, se_fg : StructElement, se_bg : StructElement) -> MorphImage {
  let eroded_fg = morph_erode_adv(img, se_fg)
  let inverted = morph_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      morph_set_pixel(inverted, x, y, 255.0 - morph_pixel(img, x, y))
    }
  }
  let eroded_bg = morph_erode_adv(inverted, se_bg)
  let out = morph_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      if morph_pixel(eroded_fg, x, y) > 0.0 && morph_pixel(eroded_bg, x, y) > 0.0 {
        morph_set_pixel(out, x, y, 255.0)
      }
    }
  }
  out
}

/// 细化 / Thinning.
pub fn morph_thinning(img : MorphImage, se : StructElement) -> MorphImage {
  let hmt = morph_hit_miss(img, se, se)
  let out = morph_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let v = morph_pixel(img, x, y) - morph_pixel(hmt, x, y)
      morph_set_pixel(out, x, y, morph_max(0.0, v))
    }
  }
  out
}

/// 粗化 / Thickening.
pub fn morph_thickening(img : MorphImage, se : StructElement) -> MorphImage {
  let hmt = morph_hit_miss(img, se, se)
  let out = morph_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let v = morph_pixel(img, x, y) + morph_pixel(hmt, x, y)
      morph_set_pixel(out, x, y, morph_min(255.0, v))
    }
  }
  out
}

/// 骨架提取 / Skeleton extraction.
pub fn morph_skeleton(img : MorphImage) -> MorphImage {
  let se = morph_cross_kernel(3)
  let result = morph_empty(img.width, img.height)
  let mut temp = morph_clone(img)
  let mut iter = 0
  while iter < 30 {
    iter = iter + 1
    let eroded = morph_erode_adv(temp, se)
    let opened = morph_open_adv(eroded, se)
    let mut has_diff = false
    for y in 0..<img.height {
      for x in 0..<img.width {
        let diff = morph_pixel(eroded, x, y) - morph_pixel(opened, x, y)
        if diff > 0.0 {
          morph_set_pixel(result, x, y, 255.0)
          has_diff = true
        }
      }
    }
    temp = eroded
    if !(has_diff) {
      break
    }
  }
  result
}

/// 距离变换 / Distance transform.
pub fn morph_distance_transform(img : MorphImage) -> MorphImage {
  let out = morph_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      if morph_pixel(img, x, y) > 0.0 {
        morph_set_pixel(out, x, y, 0.0)
      } else {
        morph_set_pixel(out, x, y, 999999.0)
      }
    }
  }
  let mut changed = true
  while changed {
    changed = false
    for y in 0..<img.height {
      for x in 0..<img.width {
        let cur = morph_pixel(out, x, y)
        let n1 = morph_pixel(out, x - 1, y) + 1.0
        let n2 = morph_pixel(out, x + 1, y) + 1.0
        let n3 = morph_pixel(out, x, y - 1) + 1.0
        let n4 = morph_pixel(out, x, y + 1) + 1.0
        let m = morph_min(morph_min(n1, n2), morph_min(n3, n4))
        if m < cur {
          morph_set_pixel(out, x, y, m)
          changed = true
        }
      }
    }
  }
  out
}

/// 中轴变换 / Medial axis transform.
pub fn morph_medial_axis(img : MorphImage) -> MorphImage {
  let dist = morph_distance_transform(img)
  let out = morph_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let d = morph_pixel(dist, x, y)
      if d == 0.0 {
        continue
      }
      let mut is_local_max = true
      for dy in -1..=1 {
        for dx in -1..=1 {
          if dx == 0 && dy == 0 {
            continue
          }
          if morph_pixel(dist, x + dx, y + dy) > d {
            is_local_max = false
          }
        }
      }
      if is_local_max {
        morph_set_pixel(out, x, y, d)
      }
    }
  }
  out
}

/// 形态学分水岭 / Morphological watershed.
pub fn morph_watershed_morph(img : MorphImage) -> MorphImage {
  let dist = morph_distance_transform(img)
  let out = morph_empty(img.width, img.height)
  let mut label = 1.0
  let visited : Array[Bool] = []
  for _ in 0..<(img.width * img.height) {
    visited.push(false)
  }
  for y in 0..<img.height {
    for x in 0..<img.width {
      let idx = y * img.width + x
      if visited[idx] || morph_pixel(dist, x, y) == 0.0 {
        continue
      }
      let mut is_seed = true
      for dy in -1..=1 {
        for dx in -1..=1 {
          if morph_pixel(dist, x + dx, y + dy) > morph_pixel(dist, x, y) {
            is_seed = false
          }
        }
      }
      if is_seed {
        let queue : Array[(Int, Int)] = []
        queue.push((x, y))
        visited[idx] = true
        while queue.length() > 0 {
          let (cx, cy) = queue[queue.length() - 1]
          ignore(          ignore(queue.remove(queue.length() - 1)))
          morph_set_pixel(out, cx, cy, label)
          for dy in -1..=1 {
            for dx in -1..=1 {
              if dx == 0 && dy == 0 {
                continue
              }
              let nx = cx + dx
              let ny = cy + dy
              if nx < 0 || nx >= img.width || ny < 0 || ny >= img.height {
                continue
              }
              let nidx = ny * img.width + nx
              if visited[nidx] || morph_pixel(dist, nx, ny) == 0.0 {
                continue
              }
              visited[nidx] = true
              queue.push((nx, ny))
            }
          }
        }
        label = label + 1.0
      }
    }
  }
  out
}

/// 测地重构 / Geodesic reconstruction.
pub fn morph_reconstruction(marker : MorphImage, mask : MorphImage) -> MorphImage {
  let out = morph_clone(marker)
  let mut changed = true
  let mut iter = 0
  while changed && iter < 100 {
    changed = false
    iter = iter + 1
    let se = morph_cross_kernel(3)
    let dilated = morph_dilate_adv(out, se)
    for y in 0..<out.height {
      for x in 0..<out.width {
        let v = morph_min(morph_pixel(dilated, x, y), morph_pixel(mask, x, y))
        if v > morph_pixel(out, x, y) {
          morph_set_pixel(out, x, y, v)
          changed = true
        }
      }
    }
  }
  out
}

/// 测地腐蚀 / Geodesic erosion.
pub fn morph_geodesic(marker : MorphImage, mask : MorphImage) -> MorphImage {
  let out = morph_clone(marker)
  let mut changed = true
  let mut iter = 0
  while changed && iter < 100 {
    changed = false
    iter = iter + 1
    let se = morph_cross_kernel(3)
    let eroded = morph_erode_adv(out, se)
    for y in 0..<out.height {
      for x in 0..<out.width {
        let v = morph_max(morph_pixel(eroded, x, y), morph_pixel(mask, x, y))
        if v < morph_pixel(out, x, y) {
          morph_set_pixel(out, x, y, v)
          changed = true
        }
      }
    }
  }
  out
}

/// 开重构 / Opening by reconstruction.
pub fn morph_opening_by_reconstruction(img : MorphImage, se : StructElement) -> MorphImage {
  let eroded = morph_erode_adv(img, se)
  morph_reconstruction(eroded, img)
}

/// 闭重构 / Closing by reconstruction.
pub fn morph_closing_by_reconstruction(img : MorphImage, se : StructElement) -> MorphImage {
  let dilated = morph_dilate_adv(img, se)
  let inverted_img = morph_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      morph_set_pixel(inverted_img, x, y, 255.0 - morph_pixel(img, x, y))
    }
  }
  let inverted_dilated = morph_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      morph_set_pixel(inverted_dilated, x, y, 255.0 - morph_pixel(dilated, x, y))
    }
  }
  let rec = morph_reconstruction(inverted_dilated, inverted_img)
  let out = morph_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      morph_set_pixel(out, x, y, 255.0 - morph_pixel(rec, x, y))
    }
  }
  out
}

/// 交替序贯滤波 / Alternating sequential filter.
pub fn morph_alternating_sequential_filter(img : MorphImage, max_size : Int) -> MorphImage {
  let mut out = morph_clone(img)
  for size in 1..=max_size {
    let se = morph_square_kernel(2 * size + 1)
    out = morph_open_adv(out, se)
    out = morph_close_adv(out, se)
  }
  out
}

/// 面积开 / Area opening.
pub fn morph_area_open(img : MorphImage, min_area : Int) -> MorphImage {
  let labels = morph_label_morph(img)
  let counts : Array[Int] = []
  for _ in 0..<(img.width * img.height + 1) {
    counts.push(0)
  }
  for y in 0..<img.height {
    for x in 0..<img.width {
      let l = morph_pixel(labels, x, y).to_int()
      if l >= 0 && l < counts.length() {
        counts[l] = counts[l] + 1
      }
    }
  }
  let out = morph_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let l = morph_pixel(labels, x, y).to_int()
      if l > 0 && l < counts.length() && counts[l] >= min_area {
        morph_set_pixel(out, x, y, morph_pixel(img, x, y))
      }
    }
  }
  out
}

/// 面积闭 / Area closing.
pub fn morph_area_close(img : MorphImage, min_area : Int) -> MorphImage {
  let inverted = morph_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      morph_set_pixel(inverted, x, y, 255.0 - morph_pixel(img, x, y))
    }
  }
  let opened = morph_area_open(inverted, min_area)
  let out = morph_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      morph_set_pixel(out, x, y, 255.0 - morph_pixel(opened, x, y))
    }
  }
  out
}

/// Max-tree / Max-tree.
pub fn morph_max_tree(img : MorphImage) -> Array[(Double, Int)] {
  let result : Array[(Double, Int)] = []
  let levels : Array[Double] = []
  for y in 0..<img.height {
    for x in 0..<img.width {
      let v = morph_pixel(img, x, y)
      let mut found = false
      for i in 0..<levels.length() {
        if levels[i] == v {
          found = true
        }
      }
      if !(found) {
        levels.push(v)
      }
    }
  }
  for i in 0..<levels.length() {
    let mut count = 0
    for y in 0..<img.height {
      for x in 0..<img.width {
        if morph_pixel(img, x, y) >= levels[i] {
          count = count + 1
        }
      }
    }
    result.push((levels[i], count))
  }
  result
}

/// Min-tree / Min-tree.
pub fn morph_min_tree(img : MorphImage) -> Array[(Double, Int)] {
  let result : Array[(Double, Int)] = []
  let levels : Array[Double] = []
  for y in 0..<img.height {
    for x in 0..<img.width {
      let v = morph_pixel(img, x, y)
      let mut found = false
      for i in 0..<levels.length() {
        if levels[i] == v {
          found = true
        }
      }
      if !(found) {
        levels.push(v)
      }
    }
  }
  for i in 0..<levels.length() {
    let mut count = 0
    for y in 0..<img.height {
      for x in 0..<img.width {
        if morph_pixel(img, x, y) <= levels[i] {
          count = count + 1
        }
      }
    }
    result.push((levels[i], count))
  }
  result
}

/// 属性滤波 / Attribute filter.
pub fn morph_attribute_filter(img : MorphImage, min_area : Int, is_opening : Bool) -> MorphImage {
  if is_opening {
    morph_area_open(img, min_area)
  } else {
    morph_area_close(img, min_area)
  }
}

/// 粒度分析 / Granulometry.
pub fn morph_granulometry(img : MorphImage, max_size : Int) -> Array[Double] {
  let result : Array[Double] = []
  let mut prev = morph_clone(img)
  for size in 1..=max_size {
    let se = morph_circle_kernel(size)
    let opened = morph_open_adv(prev, se)
    let mut diff = 0.0
    for y in 0..<img.height {
      for x in 0..<img.width {
        diff = diff + @_common.abs(morph_pixel(prev, x, y) - morph_pixel(opened, x, y))
      }
    }
    result.push(diff)
    prev = opened
  }
  result
}

/// 模式谱 / Pattern spectrum.
pub fn morph_pattern_spectrum(img : MorphImage, max_size : Int) -> Array[Double] {
  morph_granulometry(img, max_size)
}

/// 尺寸分布 / Size distribution.
pub fn morph_size_distribution(img : MorphImage, max_size : Int) -> Array[Double] {
  let result : Array[Double] = []
  let mut prev = morph_clone(img)
  for size in 1..=max_size {
    let se = morph_circle_kernel(size)
    let opened = morph_open_adv(prev, se)
    let mut volume = 0.0
    for y in 0..<img.height {
      for x in 0..<img.width {
        volume = volume + morph_pixel(opened, x, y)
      }
    }
    result.push(volume)
    prev = opened
  }
  result
}

/// 凸包形态学 / Convex hull morphology (simplified).
pub fn morph_convex_hull_morph(img : MorphImage) -> MorphImage {
  let out = morph_clone(img)
  let mut changed = true
  let mut iter = 0
  while changed && iter < 30 {
    changed = false
    iter = iter + 1
    let se = morph_square_kernel(3)
    let dilated = morph_dilate_adv(out, se)
    for y in 0..<img.height {
      for x in 0..<img.width {
        if morph_pixel(out, x, y) == 0.0 && morph_pixel(dilated, x, y) > 0.0 {
          let mut fill = true
          for dy in -1..=1 {
            for dx in -1..=1 {
              if dx == 0 && dy == 0 {
                continue
              }
              if morph_pixel(out, x + dx, y + dy) == 0.0 {
                fill = false
              }
            }
          }
          if fill {
            morph_set_pixel(out, x, y, 255.0)
            changed = true
          }
        }
      }
    }
  }
  out
}

/// 填充孔洞形态学 / Fill holes morphology.
pub fn morph_fill_holes_morph(img : MorphImage) -> MorphImage {
  let out = morph_clone(img)
  let visited : Array[Bool] = []
  for _ in 0..<(img.width * img.height) {
    visited.push(false)
  }
  let queue : Array[(Int, Int)] = []
  for x in 0..<img.width {
    if morph_pixel(img, x, 0) == 0.0 {
      queue.push((x, 0))
      visited[0 * img.width + x] = true
    }
    if morph_pixel(img, x, img.height - 1) == 0.0 {
      queue.push((x, img.height - 1))
      visited[(img.height - 1) * img.width + x] = true
    }
  }
  for y in 0..<img.height {
    if morph_pixel(img, 0, y) == 0.0 {
      queue.push((0, y))
      visited[y * img.width + 0] = true
    }
    if morph_pixel(img, img.width - 1, y) == 0.0 {
      queue.push((img.width - 1, y))
      visited[y * img.width + (img.width - 1)] = true
    }
  }
  while queue.length() > 0 {
    let (cx, cy) = queue[queue.length() - 1]
    ignore(          ignore(queue.remove(queue.length() - 1)))
    for dy in -1..=1 {
      for dx in -1..=1 {
        if dx == 0 && dy == 0 {
          continue
        }
        let nx = cx + dx
        let ny = cy + dy
        if nx < 0 || nx >= img.width || ny < 0 || ny >= img.height {
          continue
        }
        let nidx = ny * img.width + nx
        if visited[nidx] || morph_pixel(img, nx, ny) > 0.0 {
          continue
        }
        visited[nidx] = true
        queue.push((nx, ny))
      }
    }
  }
  for y in 0..<img.height {
    for x in 0..<img.width {
      let idx = y * img.width + x
      if !(visited[idx]) && morph_pixel(img, x, y) == 0.0 {
        morph_set_pixel(out, x, y, 255.0)
      }
    }
  }
  out
}

/// 标记连通区域 / Label connected components.
pub fn morph_label_morph(img : MorphImage) -> MorphImage {
  let out = morph_empty(img.width, img.height)
  let visited : Array[Bool] = []
  for _ in 0..<(img.width * img.height) {
    visited.push(false)
  }
  let mut label = 1.0
  for y in 0..<img.height {
    for x in 0..<img.width {
      let idx = y * img.width + x
      if visited[idx] || morph_pixel(img, x, y) == 0.0 {
        continue
      }
      let queue : Array[(Int, Int)] = []
      queue.push((x, y))
      visited[idx] = true
      while queue.length() > 0 {
        let (cx, cy) = queue[queue.length() - 1]
        ignore(          ignore(queue.remove(queue.length() - 1)))
        morph_set_pixel(out, cx, cy, label)
        for dy in -1..=1 {
          for dx in -1..=1 {
            if dx == 0 && dy == 0 {
              continue
            }
            let nx = cx + dx
            let ny = cy + dy
            if nx < 0 || nx >= img.width || ny < 0 || ny >= img.height {
              continue
            }
            let nidx = ny * img.width + nx
            if visited[nidx] || morph_pixel(img, nx, ny) == 0.0 {
              continue
            }
            visited[nidx] = true
            queue.push((nx, ny))
          }
        }
      }
      label = label + 1.0
    }
  }
  out
}

/// 连通组件 / Connected components.
pub fn morph_connected_components_morph(img : MorphImage) -> Int {
  let labels = morph_label_morph(img)
  let mut max_label = 0.0
  for y in 0..<labels.height {
    for x in 0..<labels.width {
      let l = morph_pixel(labels, x, y)
      if l > max_label {
        max_label = l
      }
    }
  }
  max_label.to_int()
}

/// 转字符串 / Convert to string.
pub fn morph_to_string(img : MorphImage) -> String {
  let mut s = "MorphImage(" + img.width.to_string() + "x" + img.height.to_string() + ")["
  let limit = if img.data.length() > 10 { 10 } else { img.data.length() }
  for i in 0..<limit {
    if i > 0 {
      s = s + ", "
    }
    s = s + img.data[i].to_string()
  }
  if img.data.length() > 10 {
    s = s + ", ..."
  }
  s = s + "]"
  s
}

/// 形态学 ID / Morphology advanced operator ID.
pub fn morphology_adv_id() -> String {
  "opcore/morphology_adv"
}