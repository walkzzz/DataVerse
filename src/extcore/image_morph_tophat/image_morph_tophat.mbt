///===
/// extcore/image_morph_tophat

pub(all) struct ImagemorphtophatPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_tophat_make_point(x : Double, y : Double) -> ImagemorphtophatPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_tophat_make_point3(x : Double, y : Double, z : Double) -> ImagemorphtophatPoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphtophatPoint::x(self : ImagemorphtophatPoint) -> Double { self.x }

pub fn ImagemorphtophatPoint::y(self : ImagemorphtophatPoint) -> Double { self.y }

pub fn ImagemorphtophatPoint::z(self : ImagemorphtophatPoint) -> Double { self.z }

pub fn ImagemorphtophatPoint::label(self : ImagemorphtophatPoint) -> Int { self.label }

pub fn ImagemorphtophatPoint::dist(self : ImagemorphtophatPoint, other : ImagemorphtophatPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphtophatPoint::add(self : ImagemorphtophatPoint, other : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphtophatPoint::sub(self : ImagemorphtophatPoint, other : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphtophatPoint::scale(self : ImagemorphtophatPoint, s : Double) -> ImagemorphtophatPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphtophatPoint::dot(self : ImagemorphtophatPoint, other : ImagemorphtophatPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphtophatPoint::cross(self : ImagemorphtophatPoint, other : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphtophatPoint::norm(self : ImagemorphtophatPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphtophatPoint::normalize(self : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphtophatPoint::negate(self : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphtophatPoint::mid(self : ImagemorphtophatPoint, other : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphtophatPoint::lerp(self : ImagemorphtophatPoint, other : ImagemorphtophatPoint, t : Double) -> ImagemorphtophatPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphtophatPoint::to_string(self : ImagemorphtophatPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphtophatSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_tophat_make_series(vals : Array[Double], name : String) -> ImagemorphtophatSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphtophatSeries::len(self : ImagemorphtophatSeries) -> Int { self.vals.length() }

pub fn ImagemorphtophatSeries::sum(self : ImagemorphtophatSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphtophatSeries::mean(self : ImagemorphtophatSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphtophatSeries::min(self : ImagemorphtophatSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphtophatSeries::max(self : ImagemorphtophatSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphtophatSeries::range(self : ImagemorphtophatSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphtophatSeries::variance(self : ImagemorphtophatSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphtophatSeries::std(self : ImagemorphtophatSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphtophatSeries::median(self : ImagemorphtophatSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphtophatSeries::scale(self : ImagemorphtophatSeries, f : Double) -> ImagemorphtophatSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphtophatSeries::add(self : ImagemorphtophatSeries, other : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphtophatSeries::sub(self : ImagemorphtophatSeries, other : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphtophatSeries::normalize(self : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphtophatSeries::cumsum(self : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphtophatSeries::to_string(self : ImagemorphtophatSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphtophatMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_tophat_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphtophatMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_tophat_matrix_identity(n : Int) -> ImagemorphtophatMatrix {
  let m = image_morph_tophat_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphtophatMatrix::get(self : ImagemorphtophatMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphtophatMatrix::transpose(self : ImagemorphtophatMatrix) -> ImagemorphtophatMatrix {
  let result = image_morph_tophat_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphtophatMatrix::add(self : ImagemorphtophatMatrix, other : ImagemorphtophatMatrix) -> ImagemorphtophatMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_tophat_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphtophatMatrix::scale(self : ImagemorphtophatMatrix, s : Double) -> ImagemorphtophatMatrix {
  let result = image_morph_tophat_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphtophatMatrix::multiply(self : ImagemorphtophatMatrix, other : ImagemorphtophatMatrix) -> ImagemorphtophatMatrix {
  if self.cols != other.rows { return image_morph_tophat_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_tophat_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagemorphtophatMatrix::trace(self : ImagemorphtophatMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphtophatMatrix::det(self : ImagemorphtophatMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphtophatMatrix::norm(self : ImagemorphtophatMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphtophatMatrix::to_string(self : ImagemorphtophatMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ImagemorphtophatVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_tophat_make_vector(comps : Array[Double]) -> ImagemorphtophatVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_tophat_vector_zero(dim : Int) -> ImagemorphtophatVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphtophatVector::add(self : ImagemorphtophatVector, other : ImagemorphtophatVector) -> ImagemorphtophatVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphtophatVector::sub(self : ImagemorphtophatVector, other : ImagemorphtophatVector) -> ImagemorphtophatVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphtophatVector::scale(self : ImagemorphtophatVector, s : Double) -> ImagemorphtophatVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphtophatVector::dot(self : ImagemorphtophatVector, other : ImagemorphtophatVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphtophatVector::norm(self : ImagemorphtophatVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphtophatVector::normalize(self : ImagemorphtophatVector) -> ImagemorphtophatVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphtophatVector::dist(self : ImagemorphtophatVector, other : ImagemorphtophatVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphtophatVector::to_string(self : ImagemorphtophatVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_tophat_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_morph_tophat_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_morph_tophat_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_morph_tophat_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_morph_tophat_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_morph_tophat_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_morph_tophat_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_morph_tophat_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_morph_tophat_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_morph_tophat_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_morph_tophat_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_morph_tophat_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_morph_tophat_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_morph_tophat_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_morph_tophat_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_morph_tophat_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_morph_tophat_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_morph_tophat_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_morph_tophat_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_morph_tophat_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_morph_tophat_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_morph_tophat_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_morph_tophat_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_morph_tophat_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_morph_tophat_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_morph_tophat_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_morph_tophat_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_morph_tophat_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_morph_tophat_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagemorphtophatFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_frame_make(size : Int) -> ImagemorphtophatFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_frame_len(s : ImagemorphtophatFrame) -> Int { s.size }

pub fn image_morph_tophat_frame_get(s : ImagemorphtophatFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_frame_set(s : ImagemorphtophatFrame, i : Int, v : Double) -> ImagemorphtophatFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_frame_sum(s : ImagemorphtophatFrame) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_frame_mean(s : ImagemorphtophatFrame) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_frame_scale(s : ImagemorphtophatFrame, f : Double) -> ImagemorphtophatFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_frame_add(a : ImagemorphtophatFrame, b : ImagemorphtophatFrame) -> ImagemorphtophatFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_tophat_frame_copy(s : ImagemorphtophatFrame) -> ImagemorphtophatFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_frame_fill(s : ImagemorphtophatFrame, v : Double) -> ImagemorphtophatFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_frame_min(s : ImagemorphtophatFrame) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_frame_max(s : ImagemorphtophatFrame) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_frame_to_string(s : ImagemorphtophatFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_table_make(size : Int) -> ImagemorphtophatTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_table_len(s : ImagemorphtophatTable) -> Int { s.size }

pub fn image_morph_tophat_table_get(s : ImagemorphtophatTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_table_set(s : ImagemorphtophatTable, i : Int, v : Double) -> ImagemorphtophatTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_table_sum(s : ImagemorphtophatTable) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_table_mean(s : ImagemorphtophatTable) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_table_scale(s : ImagemorphtophatTable, f : Double) -> ImagemorphtophatTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_table_add(a : ImagemorphtophatTable, b : ImagemorphtophatTable) -> ImagemorphtophatTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_tophat_table_copy(s : ImagemorphtophatTable) -> ImagemorphtophatTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_table_fill(s : ImagemorphtophatTable, v : Double) -> ImagemorphtophatTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_table_min(s : ImagemorphtophatTable) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_table_max(s : ImagemorphtophatTable) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_table_to_string(s : ImagemorphtophatTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_graphn_make(size : Int) -> ImagemorphtophatGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_graphn_len(s : ImagemorphtophatGraphN) -> Int { s.size }

pub fn image_morph_tophat_graphn_get(s : ImagemorphtophatGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_graphn_set(s : ImagemorphtophatGraphN, i : Int, v : Double) -> ImagemorphtophatGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_graphn_sum(s : ImagemorphtophatGraphN) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_graphn_mean(s : ImagemorphtophatGraphN) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_graphn_scale(s : ImagemorphtophatGraphN, f : Double) -> ImagemorphtophatGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_graphn_add(a : ImagemorphtophatGraphN, b : ImagemorphtophatGraphN) -> ImagemorphtophatGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_tophat_graphn_copy(s : ImagemorphtophatGraphN) -> ImagemorphtophatGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_graphn_fill(s : ImagemorphtophatGraphN, v : Double) -> ImagemorphtophatGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_graphn_min(s : ImagemorphtophatGraphN) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_graphn_max(s : ImagemorphtophatGraphN) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_graphn_to_string(s : ImagemorphtophatGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_node_make(size : Int) -> ImagemorphtophatNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_node_len(s : ImagemorphtophatNode) -> Int { s.size }

pub fn image_morph_tophat_node_get(s : ImagemorphtophatNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_node_set(s : ImagemorphtophatNode, i : Int, v : Double) -> ImagemorphtophatNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_node_sum(s : ImagemorphtophatNode) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_node_mean(s : ImagemorphtophatNode) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_node_scale(s : ImagemorphtophatNode, f : Double) -> ImagemorphtophatNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_node_add(a : ImagemorphtophatNode, b : ImagemorphtophatNode) -> ImagemorphtophatNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_tophat_node_copy(s : ImagemorphtophatNode) -> ImagemorphtophatNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_node_fill(s : ImagemorphtophatNode, v : Double) -> ImagemorphtophatNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_node_min(s : ImagemorphtophatNode) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_node_max(s : ImagemorphtophatNode) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_node_to_string(s : ImagemorphtophatNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_edge_make(size : Int) -> ImagemorphtophatEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_edge_len(s : ImagemorphtophatEdge) -> Int { s.size }

pub fn image_morph_tophat_edge_get(s : ImagemorphtophatEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_edge_set(s : ImagemorphtophatEdge, i : Int, v : Double) -> ImagemorphtophatEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_edge_sum(s : ImagemorphtophatEdge) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_edge_mean(s : ImagemorphtophatEdge) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_edge_scale(s : ImagemorphtophatEdge, f : Double) -> ImagemorphtophatEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_edge_add(a : ImagemorphtophatEdge, b : ImagemorphtophatEdge) -> ImagemorphtophatEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_tophat_edge_copy(s : ImagemorphtophatEdge) -> ImagemorphtophatEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_edge_fill(s : ImagemorphtophatEdge, v : Double) -> ImagemorphtophatEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_edge_min(s : ImagemorphtophatEdge) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_edge_max(s : ImagemorphtophatEdge) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_edge_to_string(s : ImagemorphtophatEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_path_make(size : Int) -> ImagemorphtophatPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_path_len(s : ImagemorphtophatPath) -> Int { s.size }

pub fn image_morph_tophat_path_get(s : ImagemorphtophatPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_path_set(s : ImagemorphtophatPath, i : Int, v : Double) -> ImagemorphtophatPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_path_sum(s : ImagemorphtophatPath) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_path_mean(s : ImagemorphtophatPath) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_path_scale(s : ImagemorphtophatPath, f : Double) -> ImagemorphtophatPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_path_add(a : ImagemorphtophatPath, b : ImagemorphtophatPath) -> ImagemorphtophatPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_tophat_path_copy(s : ImagemorphtophatPath) -> ImagemorphtophatPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_path_fill(s : ImagemorphtophatPath, v : Double) -> ImagemorphtophatPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_path_min(s : ImagemorphtophatPath) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_path_max(s : ImagemorphtophatPath) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_path_to_string(s : ImagemorphtophatPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_cluster_make(size : Int) -> ImagemorphtophatCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_cluster_len(s : ImagemorphtophatCluster) -> Int { s.size }

pub fn image_morph_tophat_cluster_get(s : ImagemorphtophatCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_cluster_set(s : ImagemorphtophatCluster, i : Int, v : Double) -> ImagemorphtophatCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_cluster_sum(s : ImagemorphtophatCluster) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_cluster_mean(s : ImagemorphtophatCluster) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_cluster_scale(s : ImagemorphtophatCluster, f : Double) -> ImagemorphtophatCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_cluster_add(a : ImagemorphtophatCluster, b : ImagemorphtophatCluster) -> ImagemorphtophatCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_tophat_cluster_copy(s : ImagemorphtophatCluster) -> ImagemorphtophatCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_cluster_fill(s : ImagemorphtophatCluster, v : Double) -> ImagemorphtophatCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_cluster_min(s : ImagemorphtophatCluster) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_cluster_max(s : ImagemorphtophatCluster) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_cluster_to_string(s : ImagemorphtophatCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_model_make(size : Int) -> ImagemorphtophatModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_model_len(s : ImagemorphtophatModel) -> Int { s.size }

pub fn image_morph_tophat_model_get(s : ImagemorphtophatModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_model_set(s : ImagemorphtophatModel, i : Int, v : Double) -> ImagemorphtophatModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_model_sum(s : ImagemorphtophatModel) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_model_mean(s : ImagemorphtophatModel) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_model_scale(s : ImagemorphtophatModel, f : Double) -> ImagemorphtophatModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_model_add(a : ImagemorphtophatModel, b : ImagemorphtophatModel) -> ImagemorphtophatModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_tophat_model_copy(s : ImagemorphtophatModel) -> ImagemorphtophatModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_model_fill(s : ImagemorphtophatModel, v : Double) -> ImagemorphtophatModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_model_min(s : ImagemorphtophatModel) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_model_max(s : ImagemorphtophatModel) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_model_to_string(s : ImagemorphtophatModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_layer_make(size : Int) -> ImagemorphtophatLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_layer_len(s : ImagemorphtophatLayer) -> Int { s.size }

pub fn image_morph_tophat_layer_get(s : ImagemorphtophatLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_layer_set(s : ImagemorphtophatLayer, i : Int, v : Double) -> ImagemorphtophatLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_layer_sum(s : ImagemorphtophatLayer) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_layer_mean(s : ImagemorphtophatLayer) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_layer_scale(s : ImagemorphtophatLayer, f : Double) -> ImagemorphtophatLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_layer_add(a : ImagemorphtophatLayer, b : ImagemorphtophatLayer) -> ImagemorphtophatLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_tophat_layer_copy(s : ImagemorphtophatLayer) -> ImagemorphtophatLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_layer_fill(s : ImagemorphtophatLayer, v : Double) -> ImagemorphtophatLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_layer_min(s : ImagemorphtophatLayer) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_layer_max(s : ImagemorphtophatLayer) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_layer_to_string(s : ImagemorphtophatLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_buffer_make(size : Int) -> ImagemorphtophatBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_buffer_len(s : ImagemorphtophatBuffer) -> Int { s.size }

pub fn image_morph_tophat_buffer_get(s : ImagemorphtophatBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_buffer_set(s : ImagemorphtophatBuffer, i : Int, v : Double) -> ImagemorphtophatBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_buffer_sum(s : ImagemorphtophatBuffer) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_buffer_mean(s : ImagemorphtophatBuffer) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_buffer_scale(s : ImagemorphtophatBuffer, f : Double) -> ImagemorphtophatBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_buffer_add(a : ImagemorphtophatBuffer, b : ImagemorphtophatBuffer) -> ImagemorphtophatBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_tophat_buffer_copy(s : ImagemorphtophatBuffer) -> ImagemorphtophatBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_buffer_fill(s : ImagemorphtophatBuffer, v : Double) -> ImagemorphtophatBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_buffer_min(s : ImagemorphtophatBuffer) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_buffer_max(s : ImagemorphtophatBuffer) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_buffer_to_string(s : ImagemorphtophatBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_cursor_make(size : Int) -> ImagemorphtophatCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_cursor_len(s : ImagemorphtophatCursor) -> Int { s.size }

pub fn image_morph_tophat_cursor_get(s : ImagemorphtophatCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_cursor_set(s : ImagemorphtophatCursor, i : Int, v : Double) -> ImagemorphtophatCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_cursor_sum(s : ImagemorphtophatCursor) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_cursor_mean(s : ImagemorphtophatCursor) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_cursor_scale(s : ImagemorphtophatCursor, f : Double) -> ImagemorphtophatCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_cursor_add(a : ImagemorphtophatCursor, b : ImagemorphtophatCursor) -> ImagemorphtophatCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_tophat_cursor_copy(s : ImagemorphtophatCursor) -> ImagemorphtophatCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_cursor_fill(s : ImagemorphtophatCursor, v : Double) -> ImagemorphtophatCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_cursor_min(s : ImagemorphtophatCursor) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_cursor_max(s : ImagemorphtophatCursor) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_cursor_to_string(s : ImagemorphtophatCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_view_make(size : Int) -> ImagemorphtophatView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_view_len(s : ImagemorphtophatView) -> Int { s.size }

pub fn image_morph_tophat_view_get(s : ImagemorphtophatView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_view_set(s : ImagemorphtophatView, i : Int, v : Double) -> ImagemorphtophatView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_view_sum(s : ImagemorphtophatView) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_view_mean(s : ImagemorphtophatView) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_view_scale(s : ImagemorphtophatView, f : Double) -> ImagemorphtophatView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_view_add(a : ImagemorphtophatView, b : ImagemorphtophatView) -> ImagemorphtophatView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_tophat_view_copy(s : ImagemorphtophatView) -> ImagemorphtophatView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_view_fill(s : ImagemorphtophatView, v : Double) -> ImagemorphtophatView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_view_min(s : ImagemorphtophatView) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_view_max(s : ImagemorphtophatView) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_view_to_string(s : ImagemorphtophatView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_range_make(size : Int) -> ImagemorphtophatRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_range_len(s : ImagemorphtophatRange) -> Int { s.size }

pub fn image_morph_tophat_range_get(s : ImagemorphtophatRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_range_set(s : ImagemorphtophatRange, i : Int, v : Double) -> ImagemorphtophatRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_range_sum(s : ImagemorphtophatRange) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_range_mean(s : ImagemorphtophatRange) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_range_scale(s : ImagemorphtophatRange, f : Double) -> ImagemorphtophatRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_range_add(a : ImagemorphtophatRange, b : ImagemorphtophatRange) -> ImagemorphtophatRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_tophat_range_copy(s : ImagemorphtophatRange) -> ImagemorphtophatRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_range_fill(s : ImagemorphtophatRange, v : Double) -> ImagemorphtophatRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_range_min(s : ImagemorphtophatRange) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_range_max(s : ImagemorphtophatRange) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_range_to_string(s : ImagemorphtophatRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_slice_make(size : Int) -> ImagemorphtophatSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_slice_len(s : ImagemorphtophatSlice) -> Int { s.size }

pub fn image_morph_tophat_slice_get(s : ImagemorphtophatSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_slice_set(s : ImagemorphtophatSlice, i : Int, v : Double) -> ImagemorphtophatSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_slice_sum(s : ImagemorphtophatSlice) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_slice_mean(s : ImagemorphtophatSlice) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_slice_scale(s : ImagemorphtophatSlice, f : Double) -> ImagemorphtophatSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_slice_add(a : ImagemorphtophatSlice, b : ImagemorphtophatSlice) -> ImagemorphtophatSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_tophat_slice_copy(s : ImagemorphtophatSlice) -> ImagemorphtophatSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_slice_fill(s : ImagemorphtophatSlice, v : Double) -> ImagemorphtophatSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_tophat_slice_min(s : ImagemorphtophatSlice) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_slice_max(s : ImagemorphtophatSlice) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_slice_to_string(s : ImagemorphtophatSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

