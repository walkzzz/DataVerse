///|
/// # opcore/image_segmentation 图像分割算子 / Image Segmentation Operators
///
/// 图像分割算法集合：阈值、区域、聚类、边缘、水平集、MRF/CRF、深度学习简化版等。
/// 纯 MoonBit 实现，无外部依赖。

///|
/// 分割图像 / Segmentation image (grayscale, Double data).
pub struct SegImage {
  width : Int32
  height : Int32
  data : Array[Double]
} derive(Debug, Eq)

///|
pub extend SegImage with Eq::{equal, not_equal}

///|
pub extend SegImage with Debug::{to_repr}

///|
/// 分割配置 / Segmentation config.
pub struct SegConfig {
  method_ : Int32
  threshold : Double
  num_clusters : Int32
  max_iter : Int32
  tolerance : Double
} derive(Debug, Eq)

///|
pub extend SegConfig with Eq::{equal, not_equal}

///|
pub extend SegConfig with Debug::{to_repr}

///|
/// 分割方法枚举 / Segmentation method_ enum.
pub(all) enum SegMethod {
  Threshold
  Otsu
  Adaptive
  Watershed
  RegionGrowing
  KMeans
  FuzzyCMeans
  SLIC
  GraphCut
  MeanShift
  LevelSet
  UNet
  FCN
  MaskRCNN
}

///|
fn image_segmentation_seg_pow(base : Double, exp : Double) -> Double {
  if base <= 0.0 {
    return 0.0
  }
  @math.exp(exp * @math.ln(base))
}

///|
fn image_segmentation_seg_empty(w : Int32, h : Int32) -> SegImage {
  let n = w * h
  let data : Array[Double] = []
  for _ in 0..<n {
    data.push(0.0)
  }
  { width: w, height: h, data, }
}

///|
fn image_segmentation_seg_pixel(img : SegImage, x : Int32, y : Int32) -> Double {
  if x < 0 || x >= img.width || y < 0 || y >= img.height {
    return 0.0
  }
  let idx = y * img.width + x
  if idx < 0 || idx >= img.data.length() {
    return 0.0
  }
  img.data[idx]
}

///|
fn image_segmentation_seg_set_pixel(img : SegImage, x : Int32, y : Int32, v : Double) -> Unit {
  if x < 0 || x >= img.width || y < 0 || y >= img.height {
    return
  }
  let idx = y * img.width + x
  if idx >= 0 && idx < img.data.length() {
    img.data[idx] = v
  }
}

///|
/// 构造分割图像 / Build segmentation image.
pub fn image_segmentation_make_seg_image(
  width : Int32,
  height : Int32,
  data : Array[Double],
) -> SegImage {
  { width, height, data, }
}

///|
/// 空分割图像 / Empty segmentation image.
pub fn image_segmentation_seg_empty_image(width : Int32, height : Int32) -> SegImage {
  image_segmentation_seg_empty(width, height)
}

///|
/// 克隆分割图像 / Clone segmentation image.
pub fn image_segmentation_seg_clone(img : SegImage) -> SegImage {
  let data : Array[Double] = []
  for i in 0..<img.data.length() {
    data.push(img.data[i])
  }
  { width: img.width, height: img.height, data, }
}

///|
/// 反转掩码 / Invert mask.
pub fn image_segmentation_seg_invert(mask : SegImage) -> SegImage {
  let out = image_segmentation_seg_empty(mask.width, mask.height)
  for y in 0..<mask.height {
    for x in 0..<mask.width {
      let v = image_segmentation_seg_pixel(mask, x, y)
      image_segmentation_seg_set_pixel(out, x, y, 255.0 - v)
    }
  }
  out
}

///|
/// 阈值分割 / Threshold segmentation.
pub fn image_segmentation_seg_threshold(img : SegImage, threshold : Double) -> SegImage {
  let out = image_segmentation_seg_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let v = image_segmentation_seg_pixel(img, x, y)
      if v >= threshold {
        image_segmentation_seg_set_pixel(out, x, y, 255.0)
      }
    }
  }
  out
}

///|
/// 双阈值分割 / Double-threshold segmentation.
pub fn image_segmentation_seg_from_threshold(
  img : SegImage,
  low : Double,
  high : Double,
) -> SegImage {
  let out = image_segmentation_seg_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let v = image_segmentation_seg_pixel(img, x, y)
      if v >= low && v <= high {
        image_segmentation_seg_set_pixel(out, x, y, 255.0)
      }
    }
  }
  out
}

///|
/// Otsu 阈值分割 / Otsu threshold segmentation.
pub fn image_segmentation_seg_otsu(img : SegImage) -> SegImage {
  let hist : Array[Int32] = []
  for _ in 0..<256 {
    hist.push(0)
  }
  for y in 0..<img.height {
    for x in 0..<img.width {
      let v = image_segmentation_seg_pixel(img, x, y)
      let bin = @_common.clamp(v, 0.0, 255.0).to_int()
      if bin >= 0 && bin < 256 {
        hist[bin] = hist[bin] + 1
      }
    }
  }
  let total = img.width * img.height
  if total == 0 {
    return image_segmentation_seg_empty(img.width, img.height)
  }
  let mut sum_all = 0.0
  for i in 0..<256 {
    sum_all = sum_all + i.to_double() * hist[i].to_double()
  }
  let mut sum_b = 0.0
  let mut w_b = 0
  let mut max_variance = 0.0
  let mut best_t = 0
  for t in 0..<256 {
    w_b = w_b + hist[t]
    if w_b == 0 {
      continue
    }
    let w_f = total - w_b
    if w_f == 0 {
      break
    }
    sum_b = sum_b + t.to_double() * hist[t].to_double()
    let m_b = sum_b / w_b.to_double()
    let m_f = (sum_all - sum_b) / w_f.to_double()
    let variance = w_b.to_double() * w_f.to_double() * (m_b - m_f) * (m_b - m_f)
    if variance > max_variance {
      max_variance = variance
      best_t = t
    }
  }
  image_segmentation_seg_threshold(img, best_t.to_double())
}

///|
/// 自适应阈值分割 / Adaptive threshold segmentation.
pub fn image_segmentation_seg_adaptive(img : SegImage, block_size : Int32, c : Double) -> SegImage {
  if block_size < 3 {
    return image_segmentation_seg_threshold(img, 128.0)
  }
  let half = block_size / 2
  let out = image_segmentation_seg_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let mut sum = 0.0
      let mut count = 0
      for dy in -half..<=half {
        for dx in -half..<=half {
          sum = sum + image_segmentation_seg_pixel(img, x + dx, y + dy)
          count = count + 1
        }
      }
      let mean = if count > 0 { sum / count.to_double() } else { 0.0 }
      let v = image_segmentation_seg_pixel(img, x, y)
      if v > mean - c {
        image_segmentation_seg_set_pixel(out, x, y, 255.0)
      }
    }
  }
  out
}

///|
/// 分水岭分割 / Watershed segmentation (simplified).
pub fn image_segmentation_seg_watershed(img : SegImage) -> SegImage {
  let out = image_segmentation_seg_empty(img.width, img.height)
  let levels : Array[Array[(Int32, Int32)]] = []
  for _ in 0..<256 {
    levels.push([])
  }
  for y in 0..<img.height {
    for x in 0..<img.width {
      let v = image_segmentation_seg_pixel(img, x, y)
      let bin = @_common.clamp(v, 0.0, 255.0).to_int()
      if bin >= 0 && bin < 256 {
        levels[bin].push((x, y))
      }
    }
  }
  let mut label = 1.0
  for level in 0..<256 {
    for i in 0..<levels[level].length() {
      let (x, y) = levels[level][i]
      let mut min_neighbor = 0.0
      let mut has_label = false
      for dy in -1..<=1 {
        for dx in -1..<=1 {
          if dx == 0 && dy == 0 {
            continue
          }
          let nv = image_segmentation_seg_pixel(out, x + dx, y + dy)
          if nv > 0.0 {
            if !has_label {
              min_neighbor = nv
              has_label = true
            } else if nv < min_neighbor {
              min_neighbor = nv
            }
          }
        }
      }
      if has_label {
        image_segmentation_seg_set_pixel(out, x, y, min_neighbor)
      } else {
        image_segmentation_seg_set_pixel(out, x, y, label)
        label = label + 1.0
      }
    }
  }
  out
}

///|
/// 区域生长 / Region growing.
pub fn image_segmentation_seg_region_growing(
  img : SegImage,
  seeds : Array[(Int32, Int32)],
  threshold : Double,
) -> SegImage {
  let out = image_segmentation_seg_empty(img.width, img.height)
  let visited : Array[Bool] = []
  for _ in 0..<(img.width * img.height) {
    visited.push(false)
  }
  let queue : Array[(Int32, Int32)] = []
  for i in 0..<seeds.length() {
    let (sx, sy) = seeds[i]
    if sx >= 0 && sx < img.width && sy >= 0 && sy < img.height {
      queue.push((sx, sy))
      let idx = sy * img.width + sx
      if idx >= 0 && idx < visited.length() {
        visited[idx] = true
      }
      image_segmentation_seg_set_pixel(out, sx, sy, 255.0)
    }
  }
  while queue.length() > 0 {
    let (cx, cy) = queue[queue.length() - 1]
    ignore(queue.remove(queue.length() - 1))
    let seed_val = image_segmentation_seg_pixel(img, cx, cy)
    for dy in -1..<=1 {
      for dx in -1..<=1 {
        if dx == 0 && dy == 0 {
          continue
        }
        let nx = cx + dx
        let ny = cy + dy
        if nx < 0 || nx >= img.width || ny < 0 || ny >= img.height {
          continue
        }
        let nidx = ny * img.width + nx
        if nidx < 0 || nidx >= visited.length() || visited[nidx] {
          continue
        }
        let nv = image_segmentation_seg_pixel(img, nx, ny)
        if @_common.abs(nv - seed_val) <= threshold {
          visited[nidx] = true
          image_segmentation_seg_set_pixel(out, nx, ny, 255.0)
          queue.push((nx, ny))
        }
      }
    }
  }
  out
}

///|
/// 区域合并 / Region merge.
pub fn image_segmentation_seg_region_merge(img : SegImage, threshold : Double) -> SegImage {
  let out = image_segmentation_seg_clone(img)
  let mut changed = true
  let mut iter = 0
  while changed && iter < 20 {
    changed = false
    iter = iter + 1
    for y in 0..<out.height {
      for x in 0..<(out.width - 1) {
        let v1 = image_segmentation_seg_pixel(out, x, y)
        let v2 = image_segmentation_seg_pixel(out, x + 1, y)
        if @_common.abs(v1 - v2) < threshold {
          let avg = (v1 + v2) / 2.0
          image_segmentation_seg_set_pixel(out, x, y, avg)
          image_segmentation_seg_set_pixel(out, x + 1, y, avg)
          changed = true
        }
      }
    }
  }
  out
}

///|
/// K-means 分割 / K-means segmentation.
pub fn image_segmentation_seg_kmeans(img : SegImage, k : Int32, max_iter : Int32) -> SegImage {
  if k <= 0 || img.width * img.height == 0 {
    return image_segmentation_seg_empty(img.width, img.height)
  }
  let centroids : Array[Double] = []
  for i in 0..<k {
    centroids.push(255.0 * i.to_double() / k.to_double())
  }
  let out = image_segmentation_seg_empty(img.width, img.height)
  for _ in 0..<max_iter {
    let sums : Array[Double] = []
    let counts : Array[Int32] = []
    for _ in 0..<k {
      sums.push(0.0)
      counts.push(0)
    }
    for y in 0..<img.height {
      for x in 0..<img.width {
        let v = image_segmentation_seg_pixel(img, x, y)
        let mut best = 0
        let mut best_dist = 999999.0
        for c in 0..<k {
          let d = (v - centroids[c]) * (v - centroids[c])
          if d < best_dist {
            best_dist = d
            best = c
          }
        }
        image_segmentation_seg_set_pixel(out, x, y, best.to_double())
        sums[best] = sums[best] + v
        counts[best] = counts[best] + 1
      }
    }
    for c in 0..<k {
      if counts[c] > 0 {
        centroids[c] = sums[c] / counts[c].to_double()
      }
    }
  }
  out
}

///|
/// 模糊 C 均值分割 / Fuzzy C-means segmentation.
pub fn image_segmentation_seg_fuzzy_cmeans(
  img : SegImage,
  c : Int32,
  m : Double,
  max_iter : Int32,
) -> SegImage {
  if c <= 0 || img.width * img.height == 0 {
    return image_segmentation_seg_empty(img.width, img.height)
  }
  let centroids : Array[Double] = []
  for i in 0..<c {
    centroids.push(255.0 * i.to_double() / c.to_double())
  }
  let out = image_segmentation_seg_empty(img.width, img.height)
  let n = img.width * img.height
  let membership : Array[Double] = []
  for _ in 0..<(n * c) {
    membership.push(1.0 / c.to_double())
  }
  for _ in 0..<max_iter {
    for y in 0..<img.height {
      for x in 0..<img.width {
        let v = image_segmentation_seg_pixel(img, x, y)
        let pidx = y * img.width + x
        let mut best = 0
        let mut best_dist = 999999.0
        for ci in 0..<c {
          let d = (v - centroids[ci]) * (v - centroids[ci])
          if d < best_dist {
            best_dist = d
            best = ci
          }
        }
        image_segmentation_seg_set_pixel(out, x, y, best.to_double())
        for ci in 0..<c {
          let d = @_common.abs(v - centroids[ci])
          if d < 0.0001 {
            membership[pidx * c + ci] = 1.0
          } else {
            let mut u = 0.0
            for cj in 0..<c {
              let dj = @_common.abs(v - centroids[cj])
              if dj < 0.0001 {
                u = u + 0.0
              } else {
                u = u + image_segmentation_seg_pow(d / dj, 2.0 / (m - 1.0))
              }
            }
            if u > 0.0 {
              membership[pidx * c + ci] = 1.0 / u
            }
          }
        }
        for ci in 0..<c {
          let num = membership[pidx * c + ci] * v
          let den = membership[pidx * c + ci]
          if den > 0.0 {
            centroids[ci] = (centroids[ci] + num) / (1.0 + den)
          }
        }
      }
    }
  }
  out
}

///|
/// SLIC 超像素分割 / SLIC superpixels segmentation (simplified).
pub fn image_segmentation_seg_slic_superpixels(img : SegImage, k : Int32, m : Double) -> SegImage {
  if k <= 0 || img.width * img.height == 0 {
    return image_segmentation_seg_empty(img.width, img.height)
  }
  let n = img.width * img.height
  let s = @_common.sqrt(n.to_double() / k.to_double()).to_int()
  if s <= 0 {
    return image_segmentation_seg_kmeans(img, k, 10)
  }
  let centroids : Array[(Int32, Int32, Double)] = []
  let mut cy = s / 2
  while cy < img.height {
    let mut cx = s / 2
    while cx < img.width {
      centroids.push((cx, cy, image_segmentation_seg_pixel(img, cx, cy)))
      cx = cx + s
    }
    cy = cy + s
  }
  let out = image_segmentation_seg_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let v = image_segmentation_seg_pixel(img, x, y)
      let mut best = 0
      let mut best_dist = 999999.0
      for i in 0..<centroids.length() {
        let (ccx, ccy, cv) = centroids[i]
        let dc = (v - cv) * (v - cv)
        let ds = ((x - ccx) * (x - ccx) + (y - ccy) * (y - ccy)).to_double()
        let d = dc + ds * m * m / (s.to_double() * s.to_double())
        if d < best_dist {
          best_dist = d
          best = i
        }
      }
      image_segmentation_seg_set_pixel(out, x, y, best.to_double())
    }
  }
  out
}

///|
/// 图割分割 / Graph cut segmentation (simplified).
pub fn image_segmentation_seg_graph_cut(
  img : SegImage,
  seeds_fg : Array[(Int32, Int32)],
  seeds_bg : Array[(Int32, Int32)],
) -> SegImage {
  let out = image_segmentation_seg_empty(img.width, img.height)
  let mut fg_mean = 0.0
  for i in 0..<seeds_fg.length() {
    let (sx, sy) = seeds_fg[i]
    fg_mean = fg_mean + image_segmentation_seg_pixel(img, sx, sy)
  }
  if seeds_fg.length() > 0 {
    fg_mean = fg_mean / seeds_fg.length().to_double()
  }
  let mut bg_mean = 0.0
  for i in 0..<seeds_bg.length() {
    let (sx, sy) = seeds_bg[i]
    bg_mean = bg_mean + image_segmentation_seg_pixel(img, sx, sy)
  }
  if seeds_bg.length() > 0 {
    bg_mean = bg_mean / seeds_bg.length().to_double()
  }
  let mid = (fg_mean + bg_mean) / 2.0
  for y in 0..<img.height {
    for x in 0..<img.width {
      let v = image_segmentation_seg_pixel(img, x, y)
      if @_common.abs(v - fg_mean) < @_common.abs(v - bg_mean) {
        image_segmentation_seg_set_pixel(out, x, y, 255.0)
      }
    }
  }
  ignore(mid)
  out
}

///|
/// 归一化割分割 / Normalized cut segmentation (simplified).
pub fn image_segmentation_seg_normalized_cut(img : SegImage, k : Int32) -> SegImage {
  image_segmentation_seg_kmeans(img, k, 15)
}

///|
/// 均值漂移分割 / Mean shift segmentation.
pub fn image_segmentation_seg_mean_shift(img : SegImage, bandwidth : Double) -> SegImage {
  if bandwidth <= 0.0 {
    return image_segmentation_seg_clone(img)
  }
  let out = image_segmentation_seg_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let mut mode = image_segmentation_seg_pixel(img, x, y)
      let mut iter = 0
      while iter < 20 {
        iter = iter + 1
        let mut num = 0.0
        let mut den = 0.0
        for dy in -2..<=2 {
          for dx in -2..<=2 {
            let nv = image_segmentation_seg_pixel(img, x + dx, y + dy)
            let diff = (nv - mode) / bandwidth
            let w = @math.exp(-diff * diff / 2.0)
            num = num + nv * w
            den = den + w
          }
        }
        if den > 0.0 {
          let new_mode = num / den
          if @_common.abs(new_mode - mode) < 0.1 {
            mode = new_mode
            break
          }
          mode = new_mode
        } else {
          break
        }
      }
      image_segmentation_seg_set_pixel(out, x, y, mode)
    }
  }
  out
}

///|
/// 水平集分割 / Level set segmentation.
pub fn image_segmentation_seg_level_set(
  img : SegImage,
  init_phi : SegImage,
  max_iter : Int32,
) -> SegImage {
  let phi = image_segmentation_seg_clone(init_phi)
  let mut iter = 0
  while iter < max_iter {
    iter = iter + 1
    let mut changed = false
    for y in 0..<phi.height {
      for x in 0..<phi.width {
        let dx = (image_segmentation_seg_pixel(phi, x + 1, y) - image_segmentation_seg_pixel(phi, x - 1, y)) / 2.0
        let dy = (image_segmentation_seg_pixel(phi, x, y + 1) - image_segmentation_seg_pixel(phi, x, y - 1)) / 2.0
        let mag = @_common.sqrt(dx * dx + dy * dy)
        let force = 128.0 - image_segmentation_seg_pixel(img, x, y)
        let update = force * mag * 0.01
        let old = image_segmentation_seg_pixel(phi, x, y)
        image_segmentation_seg_set_pixel(phi, x, y, old + update)
        if @_common.abs(update) > 0.01 {
          changed = true
        }
      }
    }
    if !changed {
      break
    }
  }
  let out = image_segmentation_seg_empty(img.width, img.height)
  for y in 0..<phi.height {
    for x in 0..<phi.width {
      if image_segmentation_seg_pixel(phi, x, y) >= 0.0 {
        image_segmentation_seg_set_pixel(out, x, y, 255.0)
      }
    }
  }
  out
}

///|
/// 主动轮廓 / Active contour segmentation.
pub fn image_segmentation_seg_active_contour(
  img : SegImage,
  init_contour : Array[(Double, Double)],
  alpha : Double,
  beta : Double,
  gamma : Double,
) -> SegImage {
  image_segmentation_seg_snake(img, init_contour, alpha, beta, gamma, 50)
}

///|
/// Snake 轮廓 / Snake contour.
pub fn image_segmentation_seg_snake(
  img : SegImage,
  init_contour : Array[(Double, Double)],
  alpha : Double,
  beta : Double,
  gamma : Double,
  max_iter : Int32,
) -> SegImage {
  let contour : Array[(Double, Double)] = []
  for i in 0..<init_contour.length() {
    contour.push(init_contour[i])
  }
  let n = contour.length()
  if n < 3 {
    return image_segmentation_seg_empty(img.width, img.height)
  }
  for _ in 0..<max_iter {
    for i in 0..<n {
      let prev_idx = if i == 0 { n - 1 } else { i - 1 }
      let next_idx = if i == n - 1 { 0 } else { i + 1 }
      let (px, py) = contour[prev_idx]
      let (cx, cy) = contour[i]
      let (nx, ny) = contour[next_idx]
      let elastic_x = alpha * (px + nx - 2.0 * cx)
      let elastic_y = alpha * (py + ny - 2.0 * cy)
      let ppx = if prev_idx == 0 {
        contour[n - 1].0
      } else {
        contour[prev_idx - 1].0
      }
      let ppy = if prev_idx == 0 {
        contour[n - 1].1
      } else {
        contour[prev_idx - 1].1
      }
      let nnx = if next_idx == n - 1 {
        contour[0].0
      } else {
        contour[next_idx + 1].0
      }
      let nny = if next_idx == n - 1 {
        contour[0].1
      } else {
        contour[next_idx + 1].1
      }
      let rigid_x = beta * (ppx - 4.0 * px + 6.0 * cx - 4.0 * nx + nnx)
      let rigid_y = beta * (ppy - 4.0 * py + 6.0 * cy - 4.0 * ny + nny)
      let gx = image_segmentation_seg_pixel(img, (cx + 1.0).to_int(), cy.to_int()) -
        image_segmentation_seg_pixel(img, (cx - 1.0).to_int(), cy.to_int())
      let gy = image_segmentation_seg_pixel(img, cx.to_int(), (cy + 1.0).to_int()) -
        image_segmentation_seg_pixel(img, cx.to_int(), (cy - 1.0).to_int())
      let new_x = cx + gamma * (elastic_x - rigid_x + gx)
      let new_y = cy + gamma * (elastic_y - rigid_y + gy)
      contour[i] = (new_x, new_y)
    }
  }
  let out = image_segmentation_seg_empty(img.width, img.height)
  for i in 0..<n {
    let (cx, cy) = contour[i]
    let xi = cx.to_int()
    let yi = cy.to_int()
    if xi >= 0 && xi < img.width && yi >= 0 && yi < img.height {
      image_segmentation_seg_set_pixel(out, xi, yi, 255.0)
    }
  }
  out
}

///|
/// 随机游走分割 / Random walker segmentation (simplified).
pub fn image_segmentation_seg_random_walker(
  img : SegImage,
  seeds : Array[(Int32, Int32, Int32)],
) -> SegImage {
  let out = image_segmentation_seg_empty(img.width, img.height)
  let n = img.width * img.height
  if n == 0 {
    return out
  }
  let labels : Array[Double] = []
  for _ in 0..<n {
    labels.push(0.0)
  }
  for i in 0..<seeds.length() {
    let (sx, sy, sl) = seeds[i]
    if sx >= 0 && sx < img.width && sy >= 0 && sy < img.height {
      let idx = sy * img.width + sx
      if idx >= 0 && idx < labels.length() {
        labels[idx] = sl.to_double()
      }
    }
  }
  let mut iter = 0
  while iter < 30 {
    iter = iter + 1
    let new_labels : Array[Double] = []
    for i in 0..<n {
      new_labels.push(labels[i])
    }
    for y in 0..<img.height {
      for x in 0..<img.width {
        let idx = y * img.width + x
        if labels[idx] > 0.0 {
          continue
        }
        let mut sum = 0.0
        let mut count = 0
        for dy in -1..<=1 {
          for dx in -1..<=1 {
            if dx == 0 && dy == 0 {
              continue
            }
            let nx = x + dx
            let ny = y + dy
            if nx < 0 || nx >= img.width || ny < 0 || ny >= img.height {
              continue
            }
            let nidx = ny * img.width + nx
            let w = @math.exp(
              -@_common.abs(image_segmentation_seg_pixel(img, x, y) - image_segmentation_seg_pixel(img, nx, ny)) /
              32.0,
            )
            sum = sum + labels[nidx] * w
            count = count + 1
          }
        }
        if count > 0 {
          new_labels[idx] = sum / count.to_double()
        }
      }
    }
    let mut changed = false
    for i in 0..<n {
      if @_common.abs(labels[i] - new_labels[i]) > 0.01 {
        changed = true
      }
      labels[i] = new_labels[i]
    }
    if !changed {
      break
    }
  }
  for y in 0..<img.height {
    for x in 0..<img.width {
      image_segmentation_seg_set_pixel(out, x, y, labels[y * img.width + x])
    }
  }
  out
}

///|
/// MRF 分割 / MRF segmentation.
pub fn image_segmentation_seg_mrf(img : SegImage, labels : Int32, max_iter : Int32) -> SegImage {
  if labels <= 0 {
    return image_segmentation_seg_empty(img.width, img.height)
  }
  let out = image_segmentation_seg_kmeans(img, labels, 10)
  for _ in 0..<max_iter {
    for y in 0..<img.height {
      for x in 0..<img.width {
        let v = image_segmentation_seg_pixel(img, x, y)
        let cur = image_segmentation_seg_pixel(out, x, y)
        let mut best = cur.to_int()
        let mut best_energy = 999999.0
        for l in 0..<labels {
          let data_energy = (v - l.to_double() * 255.0 / labels.to_double()) *
            (v - l.to_double() * 255.0 / labels.to_double())
          let mut smooth_energy = 0.0
          for dy in -1..<=1 {
            for dx in -1..<=1 {
              if dx == 0 && dy == 0 {
                continue
              }
              let nv = image_segmentation_seg_pixel(out, x + dx, y + dy)
              if nv.to_int() != l {
                smooth_energy = smooth_energy + 1.0
              }
            }
          }
          let energy = data_energy + 50.0 * smooth_energy
          if energy < best_energy {
            best_energy = energy
            best = l
          }
        }
        image_segmentation_seg_set_pixel(out, x, y, best.to_double())
      }
    }
  }
  out
}

///|
/// CRF 分割 / CRF segmentation.
pub fn image_segmentation_seg_crf(img : SegImage, labels : Int32, max_iter : Int32) -> SegImage {
  let out = image_segmentation_seg_mrf(img, labels, max_iter)
  for _ in 0..<5 {
    for y in 0..<out.height {
      for x in 0..<out.width {
        let cur = image_segmentation_seg_pixel(out, x, y)
        let mut sum = cur
        let mut count = 1.0
        for dy in -1..<=1 {
          for dx in -1..<=1 {
            if dx == 0 && dy == 0 {
              continue
            }
            let nv = image_segmentation_seg_pixel(out, x + dx, y + dy)
            let pv = image_segmentation_seg_pixel(img, x + dx, y + dy)
            let cv = image_segmentation_seg_pixel(img, x, y)
            let w = @math.exp(-@_common.abs(cv - pv) / 32.0)
            sum = sum + nv * w
            count = count + w
          }
        }
        image_segmentation_seg_set_pixel(out, x, y, sum / count)
      }
    }
  }
  out
}

///|
/// UNet 简化分割 / UNet simple segmentation.
pub fn image_segmentation_seg_unet_simple(img : SegImage) -> SegImage {
  let out = image_segmentation_seg_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let mut sum = 0.0
      let mut count = 0
      for dy in -1..<=1 {
        for dx in -1..<=1 {
          sum = sum + image_segmentation_seg_pixel(img, x + dx, y + dy)
          count = count + 1
        }
      }
      let mean = sum / count.to_double()
      let v = image_segmentation_seg_pixel(img, x, y)
      let diff = v - mean
      if diff > 10.0 {
        image_segmentation_seg_set_pixel(out, x, y, 255.0)
      } else {
        image_segmentation_seg_set_pixel(out, x, y, 0.0)
      }
    }
  }
  out
}

///|
/// FCN 简化分割 / FCN simple segmentation.
pub fn image_segmentation_seg_fcn_simple(img : SegImage) -> SegImage {
  let out = image_segmentation_seg_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let mut sum = 0.0
      let mut count = 0
      for dy in -2..<=2 {
        for dx in -2..<=2 {
          sum = sum + image_segmentation_seg_pixel(img, x + dx, y + dy)
          count = count + 1
        }
      }
      let score = sum / count.to_double()
      if score > 128.0 {
        image_segmentation_seg_set_pixel(out, x, y, 1.0)
      } else {
        image_segmentation_seg_set_pixel(out, x, y, 0.0)
      }
    }
  }
  out
}

///|
/// Mask R-CNN 简化分割 / Mask R-CNN simple segmentation.
pub fn image_segmentation_seg_mask_rcnn_simple(img : SegImage) -> SegImage {
  let edges = image_segmentation_seg_otsu(img)
  let out = image_segmentation_seg_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      if image_segmentation_seg_pixel(edges, x, y) > 0.0 {
        image_segmentation_seg_set_pixel(out, x, y, 1.0)
      }
    }
  }
  out
}

///|
/// 实例分割 / Instance segmentation.
pub fn image_segmentation_seg_instance(img : SegImage) -> SegImage {
  let binary = image_segmentation_seg_otsu(img)
  image_segmentation_seg_label_regions(binary)
}

///|
/// 语义分割 / Semantic segmentation.
pub fn image_segmentation_seg_semantic(img : SegImage) -> SegImage {
  image_segmentation_seg_kmeans(img, 5, 20)
}

///|
/// 全景分割 / Panoptic segmentation.
pub fn image_segmentation_seg_panoptic(img : SegImage) -> SegImage {
  let semantic = image_segmentation_seg_semantic(img)
  let instance = image_segmentation_seg_instance(img)
  let out = image_segmentation_seg_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let s = image_segmentation_seg_pixel(semantic, x, y)
      let i = image_segmentation_seg_pixel(instance, x, y)
      image_segmentation_seg_set_pixel(out, x, y, s * 100.0 + i)
    }
  }
  out
}

///|
/// IoU 评估 / IoU evaluation.
pub fn image_segmentation_seg_evaluate_iou(pred : SegImage, gt : SegImage) -> Double {
  let mut inter = 0.0
  let mut union_ = 0.0
  let h = if pred.height < gt.height { pred.height } else { gt.height }
  let w = if pred.width < gt.width { pred.width } else { gt.width }
  for y in 0..<h {
    for x in 0..<w {
      let p = if image_segmentation_seg_pixel(pred, x, y) > 0.0 { 1.0 } else { 0.0 }
      let g = if image_segmentation_seg_pixel(gt, x, y) > 0.0 { 1.0 } else { 0.0 }
      if p > 0.0 && g > 0.0 {
        inter = inter + 1.0
      }
      if p > 0.0 || g > 0.0 {
        union_ = union_ + 1.0
      }
    }
  }
  if union_ == 0.0 {
    return 0.0
  }
  inter / union_
}

///|
/// Dice 评估 / Dice evaluation.
pub fn image_segmentation_seg_evaluate_dice(pred : SegImage, gt : SegImage) -> Double {
  let mut inter = 0.0
  let mut sum = 0.0
  let h = if pred.height < gt.height { pred.height } else { gt.height }
  let w = if pred.width < gt.width { pred.width } else { gt.width }
  for y in 0..<h {
    for x in 0..<w {
      let p = if image_segmentation_seg_pixel(pred, x, y) > 0.0 { 1.0 } else { 0.0 }
      let g = if image_segmentation_seg_pixel(gt, x, y) > 0.0 { 1.0 } else { 0.0 }
      if p > 0.0 && g > 0.0 {
        inter = inter + 1.0
      }
      sum = sum + p + g
    }
  }
  if sum == 0.0 {
    return 0.0
  }
  2.0 * inter / sum
}

///|
/// 像素准确率 / Pixel accuracy.
pub fn image_segmentation_seg_evaluate_pixel_acc(pred : SegImage, gt : SegImage) -> Double {
  let mut correct = 0.0
  let mut total = 0.0
  let h = if pred.height < gt.height { pred.height } else { gt.height }
  let w = if pred.width < gt.width { pred.width } else { gt.width }
  for y in 0..<h {
    for x in 0..<w {
      let p = if image_segmentation_seg_pixel(pred, x, y) > 0.0 { 1.0 } else { 0.0 }
      let g = if image_segmentation_seg_pixel(gt, x, y) > 0.0 { 1.0 } else { 0.0 }
      if p == g {
        correct = correct + 1.0
      }
      total = total + 1.0
    }
  }
  if total == 0.0 {
    return 0.0
  }
  correct / total
}

///|
/// 平均 IoU / Mean IoU.
pub fn image_segmentation_seg_evaluate_mean_iou(
  pred : SegImage,
  gt : SegImage,
  num_classes : Int32,
) -> Double {
  if num_classes <= 0 {
    return 0.0
  }
  let mut sum_iou = 0.0
  let mut valid = 0
  for c in 0..<num_classes {
    let mut inter = 0.0
    let mut union_ = 0.0
    let h = if pred.height < gt.height { pred.height } else { gt.height }
    let w = if pred.width < gt.width { pred.width } else { gt.width }
    for y in 0..<h {
      for x in 0..<w {
        let p = if image_segmentation_seg_pixel(pred, x, y).to_int() == c { 1.0 } else { 0.0 }
        let g = if image_segmentation_seg_pixel(gt, x, y).to_int() == c { 1.0 } else { 0.0 }
        if p > 0.0 && g > 0.0 {
          inter = inter + 1.0
        }
        if p > 0.0 || g > 0.0 {
          union_ = union_ + 1.0
        }
      }
    }
    if union_ > 0.0 {
      sum_iou = sum_iou + inter / union_
      valid = valid + 1
    }
  }
  if valid == 0 {
    return 0.0
  }
  sum_iou / valid.to_double()
}

///|
/// 边界 F-measure / Boundary F-measure.
pub fn image_segmentation_seg_evaluate_boundary(
  pred : SegImage,
  gt : SegImage,
  tolerance : Double,
) -> Double {
  let pred_bd = image_segmentation_seg_boundary_extract(pred)
  let gt_bd = image_segmentation_seg_boundary_extract(gt)
  let mut tp = 0.0
  let mut fp = 0.0
  let mut fn_ = 0.0
  let h = if pred.height < gt.height { pred.height } else { gt.height }
  let w = if pred.width < gt.width { pred.width } else { gt.width }
  let tol = tolerance.to_int()
  for y in 0..<h {
    for x in 0..<w {
      let pb = image_segmentation_seg_pixel(pred_bd, x, y) > 0.0
      let gb = image_segmentation_seg_pixel(gt_bd, x, y) > 0.0
      if pb {
        let mut matched = false
        for dy in -tol..<=tol {
          for dx in -tol..<=tol {
            if image_segmentation_seg_pixel(gt_bd, x + dx, y + dy) > 0.0 {
              matched = true
            }
          }
        }
        if matched {
          tp = tp + 1.0
        } else {
          fp = fp + 1.0
        }
      }
      if gb {
        let mut matched = false
        for dy in -tol..<=tol {
          for dx in -tol..<=tol {
            if image_segmentation_seg_pixel(pred_bd, x + dx, y + dy) > 0.0 {
              matched = true
            }
          }
        }
        if !matched {
          fn_ = fn_ + 1.0
        }
      }
    }
  }
  if tp + fp == 0.0 || tp + fn_ == 0.0 {
    return 0.0
  }
  let precision = tp / (tp + fp)
  let recall = tp / (tp + fn_)
  if precision + recall == 0.0 {
    return 0.0
  }
  2.0 * precision * recall / (precision + recall)
}

///|
/// 后处理 / Post process.
pub fn image_segmentation_seg_post_process(mask : SegImage) -> SegImage {
  let filled = image_segmentation_seg_fill_holes(mask)
  image_segmentation_seg_remove_small(filled, 10)
}

///|
/// 填充孔洞 / Fill holes.
pub fn image_segmentation_seg_fill_holes(mask : SegImage) -> SegImage {
  let out = image_segmentation_seg_clone(mask)
  let visited : Array[Bool] = []
  for _ in 0..<(mask.width * mask.height) {
    visited.push(false)
  }
  let queue : Array[(Int32, Int32)] = []
  for x in 0..<mask.width {
    if image_segmentation_seg_pixel(mask, x, 0) == 0.0 {
      queue.push((x, 0))
      visited[0 * mask.width + x] = true
    }
    if image_segmentation_seg_pixel(mask, x, mask.height - 1) == 0.0 {
      queue.push((x, mask.height - 1))
      visited[(mask.height - 1) * mask.width + x] = true
    }
  }
  for y in 0..<mask.height {
    if image_segmentation_seg_pixel(mask, 0, y) == 0.0 {
      queue.push((0, y))
      visited[y * mask.width + 0] = true
    }
    if image_segmentation_seg_pixel(mask, mask.width - 1, y) == 0.0 {
      queue.push((mask.width - 1, y))
      visited[y * mask.width + (mask.width - 1)] = true
    }
  }
  while queue.length() > 0 {
    let (cx, cy) = queue[queue.length() - 1]
    ignore(queue.remove(queue.length() - 1))
    for dy in -1..<=1 {
      for dx in -1..<=1 {
        if dx == 0 && dy == 0 {
          continue
        }
        let nx = cx + dx
        let ny = cy + dy
        if nx < 0 || nx >= mask.width || ny < 0 || ny >= mask.height {
          continue
        }
        let nidx = ny * mask.width + nx
        if visited[nidx] || image_segmentation_seg_pixel(mask, nx, ny) > 0.0 {
          continue
        }
        visited[nidx] = true
        queue.push((nx, ny))
      }
    }
  }
  for y in 0..<mask.height {
    for x in 0..<mask.width {
      let idx = y * mask.width + x
      if !visited[idx] && image_segmentation_seg_pixel(mask, x, y) == 0.0 {
        image_segmentation_seg_set_pixel(out, x, y, 255.0)
      }
    }
  }
  out
}

///|
/// 移除小区域 / Remove small regions.
pub fn image_segmentation_seg_remove_small(mask : SegImage, min_size : Int32) -> SegImage {
  let labels = image_segmentation_seg_label_regions(mask)
  let max_label = 0.0
  for y in 0..<labels.height {
    for x in 0..<labels.width {
      let l = image_segmentation_seg_pixel(labels, x, y)
      if l > max_label {
        ignore(l)
      }
    }
  }
  let counts : Array[Int32] = []
  for _ in 0..<(mask.width * mask.height + 1) {
    counts.push(0)
  }
  for y in 0..<labels.height {
    for x in 0..<labels.width {
      let l = image_segmentation_seg_pixel(labels, x, y).to_int()
      if l >= 0 && l < counts.length() {
        counts[l] = counts[l] + 1
      }
    }
  }
  let out = image_segmentation_seg_empty(mask.width, mask.height)
  for y in 0..<mask.height {
    for x in 0..<mask.width {
      let l = image_segmentation_seg_pixel(labels, x, y).to_int()
      if l >= 0 && l < counts.length() && counts[l] >= min_size {
        image_segmentation_seg_set_pixel(out, x, y, image_segmentation_seg_pixel(mask, x, y))
      }
    }
  }
  out
}

///|
/// 边界提取 / Boundary extraction.
pub fn image_segmentation_seg_boundary_extract(mask : SegImage) -> SegImage {
  let out = image_segmentation_seg_empty(mask.width, mask.height)
  for y in 0..<mask.height {
    for x in 0..<mask.width {
      let v = image_segmentation_seg_pixel(mask, x, y)
      if v > 0.0 {
        let mut is_boundary = false
        for dy in -1..<=1 {
          for dx in -1..<=1 {
            if dx == 0 && dy == 0 {
              continue
            }
            if image_segmentation_seg_pixel(mask, x + dx, y + dy) == 0.0 {
              is_boundary = true
            }
          }
        }
        if is_boundary {
          image_segmentation_seg_set_pixel(out, x, y, 255.0)
        }
      }
    }
  }
  out
}

///|
/// 轮廓平滑 / Contour smooth.
pub fn image_segmentation_seg_contour_smooth(
  contour : Array[(Double, Double)],
) -> Array[(Double, Double)] {
  let n = contour.length()
  if n < 3 {
    let result : Array[(Double, Double)] = []
    for i in 0..<n {
      result.push(contour[i])
    }
    return result
  }
  let result : Array[(Double, Double)] = []
  for i in 0..<n {
    let prev_idx = if i == 0 { n - 1 } else { i - 1 }
    let next_idx = if i == n - 1 { 0 } else { i + 1 }
    let (px, py) = contour[prev_idx]
    let (cx, cy) = contour[i]
    let (nx, ny) = contour[next_idx]
    let sx = (px + 2.0 * cx + nx) / 4.0
    let sy = (py + 2.0 * cy + ny) / 4.0
    result.push((sx, sy))
  }
  result
}

///|
/// 构造分割配置 / Build segmentation config.
pub fn image_segmentation_make_seg_config(
  method_ : Int32,
  threshold : Double,
  num_clusters : Int32,
  max_iter : Int32,
  tolerance : Double,
) -> SegConfig {
  { method_, threshold, num_clusters, max_iter, tolerance, }
}

///|
/// 分割预测 / Segmentation predict.
pub fn image_segmentation_seg_predict(img : SegImage, config : SegConfig) -> SegImage {
  if config.method_ == 0 {
    image_segmentation_seg_threshold(img, config.threshold)
  } else if config.method_ == 1 {
    image_segmentation_seg_otsu(img)
  } else if config.method_ == 2 {
    image_segmentation_seg_adaptive(img, 15, 5.0)
  } else if config.method_ == 3 {
    image_segmentation_seg_watershed(img)
  } else if config.method_ == 4 {
    image_segmentation_seg_kmeans(img, config.num_clusters, config.max_iter)
  } else if config.method_ == 5 {
    image_segmentation_seg_fuzzy_cmeans(img, config.num_clusters, 2.0, config.max_iter)
  } else if config.method_ == 6 {
    image_segmentation_seg_slic_superpixels(img, config.num_clusters, 10.0)
  } else if config.method_ == 7 {
    image_segmentation_seg_mean_shift(img, config.tolerance)
  } else if config.method_ == 8 {
    image_segmentation_seg_unet_simple(img)
  } else if config.method_ == 9 {
    image_segmentation_seg_fcn_simple(img)
  } else if config.method_ == 10 {
    image_segmentation_seg_mask_rcnn_simple(img)
  } else {
    image_segmentation_seg_threshold(img, config.threshold)
  }
}

///|
/// 分割可视化 / Segmentation visualize.
pub fn image_segmentation_seg_visualize(
  mask : SegImage,
  color_map : Array[(Double, Double, Double)],
) -> SegImage {
  let out = image_segmentation_seg_empty(mask.width, mask.height)
  for y in 0..<mask.height {
    for x in 0..<mask.width {
      let v = image_segmentation_seg_pixel(mask, x, y)
      let idx = v.to_int()
      if idx >= 0 && idx < color_map.length() {
        let (r, g, b) = color_map[idx]
        let gray = 0.299 * r + 0.587 * g + 0.114 * b
        image_segmentation_seg_set_pixel(out, x, y, gray)
      } else {
        image_segmentation_seg_set_pixel(out, x, y, v)
      }
    }
  }
  out
}

///|
/// 膨胀掩码 / Dilate mask.
pub fn image_segmentation_seg_dilate_mask(mask : SegImage, iter : Int32) -> SegImage {
  let mut out = image_segmentation_seg_clone(mask)
  for _ in 0..<iter {
    let next = image_segmentation_seg_empty(out.width, out.height)
    for y in 0..<out.height {
      for x in 0..<out.width {
        let mut max_v = 0.0
        for dy in -1..<=1 {
          for dx in -1..<=1 {
            let v = image_segmentation_seg_pixel(out, x + dx, y + dy)
            if v > max_v {
              max_v = v
            }
          }
        }
        image_segmentation_seg_set_pixel(next, x, y, max_v)
      }
    }
    out = next
  }
  out
}

///|
/// 腐蚀掩码 / Erode mask.
pub fn image_segmentation_seg_erode_mask(mask : SegImage, iter : Int32) -> SegImage {
  let mut out = image_segmentation_seg_clone(mask)
  for _ in 0..<iter {
    let next = image_segmentation_seg_empty(out.width, out.height)
    for y in 0..<out.height {
      for x in 0..<out.width {
        let mut min_v = 999999.0
        let mut found = false
        for dy in -1..<=1 {
          for dx in -1..<=1 {
            let v = image_segmentation_seg_pixel(out, x + dx, y + dy)
            if v < min_v {
              min_v = v
              found = true
            }
          }
        }
        if found {
          image_segmentation_seg_set_pixel(next, x, y, min_v)
        }
      }
    }
    out = next
  }
  out
}

///|
/// 标记区域 / Label connected regions.
pub fn image_segmentation_seg_label_regions(mask : SegImage) -> SegImage {
  let out = image_segmentation_seg_empty(mask.width, mask.height)
  let visited : Array[Bool] = []
  for _ in 0..<(mask.width * mask.height) {
    visited.push(false)
  }
  let mut label = 1.0
  for y in 0..<mask.height {
    for x in 0..<mask.width {
      let idx = y * mask.width + x
      if visited[idx] || image_segmentation_seg_pixel(mask, x, y) == 0.0 {
        continue
      }
      let queue : Array[(Int32, Int32)] = []
      queue.push((x, y))
      visited[idx] = true
      while queue.length() > 0 {
        let (cx, cy) = queue[queue.length() - 1]
        ignore(queue.remove(queue.length() - 1))
        image_segmentation_seg_set_pixel(out, cx, cy, label)
        for dy in -1..<=1 {
          for dx in -1..<=1 {
            if dx == 0 && dy == 0 {
              continue
            }
            let nx = cx + dx
            let ny = cy + dy
            if nx < 0 || nx >= mask.width || ny < 0 || ny >= mask.height {
              continue
            }
            let nidx = ny * mask.width + nx
            if visited[nidx] || image_segmentation_seg_pixel(mask, nx, ny) == 0.0 {
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

///|
/// 合并区域 / Merge regions.
pub fn image_segmentation_seg_merge_regions(mask : SegImage, threshold : Double) -> SegImage {
  let labels = image_segmentation_seg_label_regions(mask)
  let counts : Array[Int32] = []
  let sums : Array[Double] = []
  for _ in 0..<(mask.width * mask.height + 1) {
    counts.push(0)
    sums.push(0.0)
  }
  for y in 0..<mask.height {
    for x in 0..<mask.width {
      let l = image_segmentation_seg_pixel(labels, x, y).to_int()
      if l >= 0 && l < counts.length() {
        counts[l] = counts[l] + 1
        sums[l] = sums[l] + image_segmentation_seg_pixel(mask, x, y)
      }
    }
  }
  let out = image_segmentation_seg_empty(mask.width, mask.height)
  for y in 0..<mask.height {
    for x in 0..<mask.width {
      let l = image_segmentation_seg_pixel(labels, x, y).to_int()
      if l > 0 && l < counts.length() && counts[l] > 0 {
        let mean = sums[l] / counts[l].to_double()
        if mean >= threshold {
          image_segmentation_seg_set_pixel(out, x, y, 255.0)
        }
      }
    }
  }
  out
}

///|
/// 分裂区域 / Split regions.
pub fn image_segmentation_seg_split_regions(img : SegImage, threshold : Double) -> SegImage {
  let out = image_segmentation_seg_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<(img.width - 1) {
      let v1 = image_segmentation_seg_pixel(img, x, y)
      let v2 = image_segmentation_seg_pixel(img, x + 1, y)
      if @_common.abs(v1 - v2) > threshold {
        image_segmentation_seg_set_pixel(out, x, y, 255.0)
        image_segmentation_seg_set_pixel(out, x + 1, y, 255.0)
      }
    }
  }
  out
}

///|
/// 转字符串 / Convert to string.
pub fn image_segmentation_seg_to_string(img : SegImage) -> String {
  let mut s = "SegImage(" +
    img.width.to_string() +
    "x" +
    img.height.to_string() +
    ")["
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

///|
/// 分割图像 ID / Image segmentation operator ID.
pub fn image_segmentation_image_segmentation_id() -> String {
  "opcore/image_segmentation"
}
