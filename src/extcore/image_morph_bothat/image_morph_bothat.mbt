///===
/// extcore/image_morph_bothat

pub(all) struct ImagemorphbothatPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_bothat_make_point(x : Double, y : Double) -> ImagemorphbothatPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_bothat_make_point3(x : Double, y : Double, z : Double) -> ImagemorphbothatPoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphbothatPoint::x(self : ImagemorphbothatPoint) -> Double { self.x }

pub fn ImagemorphbothatPoint::y(self : ImagemorphbothatPoint) -> Double { self.y }

pub fn ImagemorphbothatPoint::z(self : ImagemorphbothatPoint) -> Double { self.z }

pub fn ImagemorphbothatPoint::label(self : ImagemorphbothatPoint) -> Int { self.label }

pub fn ImagemorphbothatPoint::dist(self : ImagemorphbothatPoint, other : ImagemorphbothatPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphbothatPoint::add(self : ImagemorphbothatPoint, other : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphbothatPoint::sub(self : ImagemorphbothatPoint, other : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphbothatPoint::scale(self : ImagemorphbothatPoint, s : Double) -> ImagemorphbothatPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphbothatPoint::dot(self : ImagemorphbothatPoint, other : ImagemorphbothatPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphbothatPoint::cross(self : ImagemorphbothatPoint, other : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphbothatPoint::norm(self : ImagemorphbothatPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphbothatPoint::normalize(self : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphbothatPoint::negate(self : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphbothatPoint::mid(self : ImagemorphbothatPoint, other : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphbothatPoint::lerp(self : ImagemorphbothatPoint, other : ImagemorphbothatPoint, t : Double) -> ImagemorphbothatPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphbothatPoint::to_string(self : ImagemorphbothatPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphbothatSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_bothat_make_series(vals : Array[Double], name : String) -> ImagemorphbothatSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphbothatSeries::len(self : ImagemorphbothatSeries) -> Int { self.vals.length() }

pub fn ImagemorphbothatSeries::sum(self : ImagemorphbothatSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphbothatSeries::mean(self : ImagemorphbothatSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphbothatSeries::min(self : ImagemorphbothatSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphbothatSeries::max(self : ImagemorphbothatSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphbothatSeries::range(self : ImagemorphbothatSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphbothatSeries::variance(self : ImagemorphbothatSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphbothatSeries::std(self : ImagemorphbothatSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphbothatSeries::median(self : ImagemorphbothatSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphbothatSeries::scale(self : ImagemorphbothatSeries, f : Double) -> ImagemorphbothatSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphbothatSeries::add(self : ImagemorphbothatSeries, other : ImagemorphbothatSeries) -> ImagemorphbothatSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphbothatSeries::sub(self : ImagemorphbothatSeries, other : ImagemorphbothatSeries) -> ImagemorphbothatSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphbothatSeries::normalize(self : ImagemorphbothatSeries) -> ImagemorphbothatSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphbothatSeries::cumsum(self : ImagemorphbothatSeries) -> ImagemorphbothatSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphbothatSeries::to_string(self : ImagemorphbothatSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphbothatMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_bothat_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphbothatMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_bothat_matrix_identity(n : Int) -> ImagemorphbothatMatrix {
  let m = image_morph_bothat_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphbothatMatrix::get(self : ImagemorphbothatMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphbothatMatrix::transpose(self : ImagemorphbothatMatrix) -> ImagemorphbothatMatrix {
  let result = image_morph_bothat_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphbothatMatrix::add(self : ImagemorphbothatMatrix, other : ImagemorphbothatMatrix) -> ImagemorphbothatMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_bothat_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphbothatMatrix::scale(self : ImagemorphbothatMatrix, s : Double) -> ImagemorphbothatMatrix {
  let result = image_morph_bothat_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphbothatMatrix::multiply(self : ImagemorphbothatMatrix, other : ImagemorphbothatMatrix) -> ImagemorphbothatMatrix {
  if self.cols != other.rows { return image_morph_bothat_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_bothat_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagemorphbothatMatrix::trace(self : ImagemorphbothatMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphbothatMatrix::det(self : ImagemorphbothatMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphbothatMatrix::norm(self : ImagemorphbothatMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphbothatMatrix::to_string(self : ImagemorphbothatMatrix) -> String {
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

pub(all) struct ImagemorphbothatVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_bothat_make_vector(comps : Array[Double]) -> ImagemorphbothatVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_bothat_vector_zero(dim : Int) -> ImagemorphbothatVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphbothatVector::add(self : ImagemorphbothatVector, other : ImagemorphbothatVector) -> ImagemorphbothatVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphbothatVector::sub(self : ImagemorphbothatVector, other : ImagemorphbothatVector) -> ImagemorphbothatVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphbothatVector::scale(self : ImagemorphbothatVector, s : Double) -> ImagemorphbothatVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphbothatVector::dot(self : ImagemorphbothatVector, other : ImagemorphbothatVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphbothatVector::norm(self : ImagemorphbothatVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphbothatVector::normalize(self : ImagemorphbothatVector) -> ImagemorphbothatVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphbothatVector::dist(self : ImagemorphbothatVector, other : ImagemorphbothatVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphbothatVector::to_string(self : ImagemorphbothatVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_bothat_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_morph_bothat_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_morph_bothat_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_morph_bothat_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_morph_bothat_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_morph_bothat_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_morph_bothat_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_morph_bothat_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_morph_bothat_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_morph_bothat_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_morph_bothat_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_morph_bothat_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_morph_bothat_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_morph_bothat_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_morph_bothat_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_morph_bothat_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_morph_bothat_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_morph_bothat_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_morph_bothat_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_morph_bothat_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_morph_bothat_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_morph_bothat_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_morph_bothat_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_morph_bothat_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_morph_bothat_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_morph_bothat_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_morph_bothat_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_morph_bothat_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_morph_bothat_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagemorphbothatFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_frame_make(size : Int) -> ImagemorphbothatFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_frame_len(s : ImagemorphbothatFrame) -> Int { s.size }

pub fn image_morph_bothat_frame_get(s : ImagemorphbothatFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_frame_set(s : ImagemorphbothatFrame, i : Int, v : Double) -> ImagemorphbothatFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_frame_sum(s : ImagemorphbothatFrame) -> Double { @_common.sum(s.data) }

pub fn image_morph_bothat_frame_mean(s : ImagemorphbothatFrame) -> Double { @_common.mean(s.data) }

pub fn image_morph_bothat_frame_scale(s : ImagemorphbothatFrame, f : Double) -> ImagemorphbothatFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_frame_add(a : ImagemorphbothatFrame, b : ImagemorphbothatFrame) -> ImagemorphbothatFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_bothat_frame_copy(s : ImagemorphbothatFrame) -> ImagemorphbothatFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_frame_fill(s : ImagemorphbothatFrame, v : Double) -> ImagemorphbothatFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_frame_min(s : ImagemorphbothatFrame) -> Double { @_common.min(s.data) }

pub fn image_morph_bothat_frame_max(s : ImagemorphbothatFrame) -> Double { @_common.max(s.data) }

pub fn image_morph_bothat_frame_to_string(s : ImagemorphbothatFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_table_make(size : Int) -> ImagemorphbothatTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_table_len(s : ImagemorphbothatTable) -> Int { s.size }

pub fn image_morph_bothat_table_get(s : ImagemorphbothatTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_table_set(s : ImagemorphbothatTable, i : Int, v : Double) -> ImagemorphbothatTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_table_sum(s : ImagemorphbothatTable) -> Double { @_common.sum(s.data) }

pub fn image_morph_bothat_table_mean(s : ImagemorphbothatTable) -> Double { @_common.mean(s.data) }

pub fn image_morph_bothat_table_scale(s : ImagemorphbothatTable, f : Double) -> ImagemorphbothatTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_table_add(a : ImagemorphbothatTable, b : ImagemorphbothatTable) -> ImagemorphbothatTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_bothat_table_copy(s : ImagemorphbothatTable) -> ImagemorphbothatTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_table_fill(s : ImagemorphbothatTable, v : Double) -> ImagemorphbothatTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_table_min(s : ImagemorphbothatTable) -> Double { @_common.min(s.data) }

pub fn image_morph_bothat_table_max(s : ImagemorphbothatTable) -> Double { @_common.max(s.data) }

pub fn image_morph_bothat_table_to_string(s : ImagemorphbothatTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_graphn_make(size : Int) -> ImagemorphbothatGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_graphn_len(s : ImagemorphbothatGraphN) -> Int { s.size }

pub fn image_morph_bothat_graphn_get(s : ImagemorphbothatGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_graphn_set(s : ImagemorphbothatGraphN, i : Int, v : Double) -> ImagemorphbothatGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_graphn_sum(s : ImagemorphbothatGraphN) -> Double { @_common.sum(s.data) }

pub fn image_morph_bothat_graphn_mean(s : ImagemorphbothatGraphN) -> Double { @_common.mean(s.data) }

pub fn image_morph_bothat_graphn_scale(s : ImagemorphbothatGraphN, f : Double) -> ImagemorphbothatGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_graphn_add(a : ImagemorphbothatGraphN, b : ImagemorphbothatGraphN) -> ImagemorphbothatGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_bothat_graphn_copy(s : ImagemorphbothatGraphN) -> ImagemorphbothatGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_graphn_fill(s : ImagemorphbothatGraphN, v : Double) -> ImagemorphbothatGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_graphn_min(s : ImagemorphbothatGraphN) -> Double { @_common.min(s.data) }

pub fn image_morph_bothat_graphn_max(s : ImagemorphbothatGraphN) -> Double { @_common.max(s.data) }

pub fn image_morph_bothat_graphn_to_string(s : ImagemorphbothatGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_node_make(size : Int) -> ImagemorphbothatNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_node_len(s : ImagemorphbothatNode) -> Int { s.size }

pub fn image_morph_bothat_node_get(s : ImagemorphbothatNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_node_set(s : ImagemorphbothatNode, i : Int, v : Double) -> ImagemorphbothatNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_node_sum(s : ImagemorphbothatNode) -> Double { @_common.sum(s.data) }

pub fn image_morph_bothat_node_mean(s : ImagemorphbothatNode) -> Double { @_common.mean(s.data) }

pub fn image_morph_bothat_node_scale(s : ImagemorphbothatNode, f : Double) -> ImagemorphbothatNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_node_add(a : ImagemorphbothatNode, b : ImagemorphbothatNode) -> ImagemorphbothatNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_bothat_node_copy(s : ImagemorphbothatNode) -> ImagemorphbothatNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_node_fill(s : ImagemorphbothatNode, v : Double) -> ImagemorphbothatNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_node_min(s : ImagemorphbothatNode) -> Double { @_common.min(s.data) }

pub fn image_morph_bothat_node_max(s : ImagemorphbothatNode) -> Double { @_common.max(s.data) }

pub fn image_morph_bothat_node_to_string(s : ImagemorphbothatNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_edge_make(size : Int) -> ImagemorphbothatEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_edge_len(s : ImagemorphbothatEdge) -> Int { s.size }

pub fn image_morph_bothat_edge_get(s : ImagemorphbothatEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_edge_set(s : ImagemorphbothatEdge, i : Int, v : Double) -> ImagemorphbothatEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_edge_sum(s : ImagemorphbothatEdge) -> Double { @_common.sum(s.data) }

pub fn image_morph_bothat_edge_mean(s : ImagemorphbothatEdge) -> Double { @_common.mean(s.data) }

pub fn image_morph_bothat_edge_scale(s : ImagemorphbothatEdge, f : Double) -> ImagemorphbothatEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_edge_add(a : ImagemorphbothatEdge, b : ImagemorphbothatEdge) -> ImagemorphbothatEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_bothat_edge_copy(s : ImagemorphbothatEdge) -> ImagemorphbothatEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_edge_fill(s : ImagemorphbothatEdge, v : Double) -> ImagemorphbothatEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_edge_min(s : ImagemorphbothatEdge) -> Double { @_common.min(s.data) }

pub fn image_morph_bothat_edge_max(s : ImagemorphbothatEdge) -> Double { @_common.max(s.data) }

pub fn image_morph_bothat_edge_to_string(s : ImagemorphbothatEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_path_make(size : Int) -> ImagemorphbothatPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_path_len(s : ImagemorphbothatPath) -> Int { s.size }

pub fn image_morph_bothat_path_get(s : ImagemorphbothatPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_path_set(s : ImagemorphbothatPath, i : Int, v : Double) -> ImagemorphbothatPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_path_sum(s : ImagemorphbothatPath) -> Double { @_common.sum(s.data) }

pub fn image_morph_bothat_path_mean(s : ImagemorphbothatPath) -> Double { @_common.mean(s.data) }

pub fn image_morph_bothat_path_scale(s : ImagemorphbothatPath, f : Double) -> ImagemorphbothatPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_path_add(a : ImagemorphbothatPath, b : ImagemorphbothatPath) -> ImagemorphbothatPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_bothat_path_copy(s : ImagemorphbothatPath) -> ImagemorphbothatPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_path_fill(s : ImagemorphbothatPath, v : Double) -> ImagemorphbothatPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_path_min(s : ImagemorphbothatPath) -> Double { @_common.min(s.data) }

pub fn image_morph_bothat_path_max(s : ImagemorphbothatPath) -> Double { @_common.max(s.data) }

pub fn image_morph_bothat_path_to_string(s : ImagemorphbothatPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_cluster_make(size : Int) -> ImagemorphbothatCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_cluster_len(s : ImagemorphbothatCluster) -> Int { s.size }

pub fn image_morph_bothat_cluster_get(s : ImagemorphbothatCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_cluster_set(s : ImagemorphbothatCluster, i : Int, v : Double) -> ImagemorphbothatCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_cluster_sum(s : ImagemorphbothatCluster) -> Double { @_common.sum(s.data) }

pub fn image_morph_bothat_cluster_mean(s : ImagemorphbothatCluster) -> Double { @_common.mean(s.data) }

pub fn image_morph_bothat_cluster_scale(s : ImagemorphbothatCluster, f : Double) -> ImagemorphbothatCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_cluster_add(a : ImagemorphbothatCluster, b : ImagemorphbothatCluster) -> ImagemorphbothatCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_bothat_cluster_copy(s : ImagemorphbothatCluster) -> ImagemorphbothatCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_cluster_fill(s : ImagemorphbothatCluster, v : Double) -> ImagemorphbothatCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_cluster_min(s : ImagemorphbothatCluster) -> Double { @_common.min(s.data) }

pub fn image_morph_bothat_cluster_max(s : ImagemorphbothatCluster) -> Double { @_common.max(s.data) }

pub fn image_morph_bothat_cluster_to_string(s : ImagemorphbothatCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_model_make(size : Int) -> ImagemorphbothatModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_model_len(s : ImagemorphbothatModel) -> Int { s.size }

pub fn image_morph_bothat_model_get(s : ImagemorphbothatModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_model_set(s : ImagemorphbothatModel, i : Int, v : Double) -> ImagemorphbothatModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_model_sum(s : ImagemorphbothatModel) -> Double { @_common.sum(s.data) }

pub fn image_morph_bothat_model_mean(s : ImagemorphbothatModel) -> Double { @_common.mean(s.data) }

pub fn image_morph_bothat_model_scale(s : ImagemorphbothatModel, f : Double) -> ImagemorphbothatModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_model_add(a : ImagemorphbothatModel, b : ImagemorphbothatModel) -> ImagemorphbothatModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_bothat_model_copy(s : ImagemorphbothatModel) -> ImagemorphbothatModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_model_fill(s : ImagemorphbothatModel, v : Double) -> ImagemorphbothatModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_model_min(s : ImagemorphbothatModel) -> Double { @_common.min(s.data) }

pub fn image_morph_bothat_model_max(s : ImagemorphbothatModel) -> Double { @_common.max(s.data) }

pub fn image_morph_bothat_model_to_string(s : ImagemorphbothatModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_layer_make(size : Int) -> ImagemorphbothatLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_layer_len(s : ImagemorphbothatLayer) -> Int { s.size }

pub fn image_morph_bothat_layer_get(s : ImagemorphbothatLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_layer_set(s : ImagemorphbothatLayer, i : Int, v : Double) -> ImagemorphbothatLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_layer_sum(s : ImagemorphbothatLayer) -> Double { @_common.sum(s.data) }

pub fn image_morph_bothat_layer_mean(s : ImagemorphbothatLayer) -> Double { @_common.mean(s.data) }

pub fn image_morph_bothat_layer_scale(s : ImagemorphbothatLayer, f : Double) -> ImagemorphbothatLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_layer_add(a : ImagemorphbothatLayer, b : ImagemorphbothatLayer) -> ImagemorphbothatLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_bothat_layer_copy(s : ImagemorphbothatLayer) -> ImagemorphbothatLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_layer_fill(s : ImagemorphbothatLayer, v : Double) -> ImagemorphbothatLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_layer_min(s : ImagemorphbothatLayer) -> Double { @_common.min(s.data) }

pub fn image_morph_bothat_layer_max(s : ImagemorphbothatLayer) -> Double { @_common.max(s.data) }

pub fn image_morph_bothat_layer_to_string(s : ImagemorphbothatLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_buffer_make(size : Int) -> ImagemorphbothatBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_buffer_len(s : ImagemorphbothatBuffer) -> Int { s.size }

pub fn image_morph_bothat_buffer_get(s : ImagemorphbothatBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_buffer_set(s : ImagemorphbothatBuffer, i : Int, v : Double) -> ImagemorphbothatBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_buffer_sum(s : ImagemorphbothatBuffer) -> Double { @_common.sum(s.data) }

pub fn image_morph_bothat_buffer_mean(s : ImagemorphbothatBuffer) -> Double { @_common.mean(s.data) }

pub fn image_morph_bothat_buffer_scale(s : ImagemorphbothatBuffer, f : Double) -> ImagemorphbothatBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_buffer_add(a : ImagemorphbothatBuffer, b : ImagemorphbothatBuffer) -> ImagemorphbothatBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_bothat_buffer_copy(s : ImagemorphbothatBuffer) -> ImagemorphbothatBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_buffer_fill(s : ImagemorphbothatBuffer, v : Double) -> ImagemorphbothatBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_buffer_min(s : ImagemorphbothatBuffer) -> Double { @_common.min(s.data) }

pub fn image_morph_bothat_buffer_max(s : ImagemorphbothatBuffer) -> Double { @_common.max(s.data) }

pub fn image_morph_bothat_buffer_to_string(s : ImagemorphbothatBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_cursor_make(size : Int) -> ImagemorphbothatCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_cursor_len(s : ImagemorphbothatCursor) -> Int { s.size }

pub fn image_morph_bothat_cursor_get(s : ImagemorphbothatCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_cursor_set(s : ImagemorphbothatCursor, i : Int, v : Double) -> ImagemorphbothatCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_cursor_sum(s : ImagemorphbothatCursor) -> Double { @_common.sum(s.data) }

pub fn image_morph_bothat_cursor_mean(s : ImagemorphbothatCursor) -> Double { @_common.mean(s.data) }

pub fn image_morph_bothat_cursor_scale(s : ImagemorphbothatCursor, f : Double) -> ImagemorphbothatCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_cursor_add(a : ImagemorphbothatCursor, b : ImagemorphbothatCursor) -> ImagemorphbothatCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_bothat_cursor_copy(s : ImagemorphbothatCursor) -> ImagemorphbothatCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_cursor_fill(s : ImagemorphbothatCursor, v : Double) -> ImagemorphbothatCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_cursor_min(s : ImagemorphbothatCursor) -> Double { @_common.min(s.data) }

pub fn image_morph_bothat_cursor_max(s : ImagemorphbothatCursor) -> Double { @_common.max(s.data) }

pub fn image_morph_bothat_cursor_to_string(s : ImagemorphbothatCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_view_make(size : Int) -> ImagemorphbothatView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_view_len(s : ImagemorphbothatView) -> Int { s.size }

pub fn image_morph_bothat_view_get(s : ImagemorphbothatView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_view_set(s : ImagemorphbothatView, i : Int, v : Double) -> ImagemorphbothatView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_view_sum(s : ImagemorphbothatView) -> Double { @_common.sum(s.data) }

pub fn image_morph_bothat_view_mean(s : ImagemorphbothatView) -> Double { @_common.mean(s.data) }

pub fn image_morph_bothat_view_scale(s : ImagemorphbothatView, f : Double) -> ImagemorphbothatView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_view_add(a : ImagemorphbothatView, b : ImagemorphbothatView) -> ImagemorphbothatView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_bothat_view_copy(s : ImagemorphbothatView) -> ImagemorphbothatView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_view_fill(s : ImagemorphbothatView, v : Double) -> ImagemorphbothatView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_view_min(s : ImagemorphbothatView) -> Double { @_common.min(s.data) }

pub fn image_morph_bothat_view_max(s : ImagemorphbothatView) -> Double { @_common.max(s.data) }

pub fn image_morph_bothat_view_to_string(s : ImagemorphbothatView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_range_make(size : Int) -> ImagemorphbothatRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_range_len(s : ImagemorphbothatRange) -> Int { s.size }

pub fn image_morph_bothat_range_get(s : ImagemorphbothatRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_range_set(s : ImagemorphbothatRange, i : Int, v : Double) -> ImagemorphbothatRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_range_sum(s : ImagemorphbothatRange) -> Double { @_common.sum(s.data) }

pub fn image_morph_bothat_range_mean(s : ImagemorphbothatRange) -> Double { @_common.mean(s.data) }

pub fn image_morph_bothat_range_scale(s : ImagemorphbothatRange, f : Double) -> ImagemorphbothatRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_range_add(a : ImagemorphbothatRange, b : ImagemorphbothatRange) -> ImagemorphbothatRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_bothat_range_copy(s : ImagemorphbothatRange) -> ImagemorphbothatRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_range_fill(s : ImagemorphbothatRange, v : Double) -> ImagemorphbothatRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_range_min(s : ImagemorphbothatRange) -> Double { @_common.min(s.data) }

pub fn image_morph_bothat_range_max(s : ImagemorphbothatRange) -> Double { @_common.max(s.data) }

pub fn image_morph_bothat_range_to_string(s : ImagemorphbothatRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_slice_make(size : Int) -> ImagemorphbothatSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_slice_len(s : ImagemorphbothatSlice) -> Int { s.size }

pub fn image_morph_bothat_slice_get(s : ImagemorphbothatSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_slice_set(s : ImagemorphbothatSlice, i : Int, v : Double) -> ImagemorphbothatSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_slice_sum(s : ImagemorphbothatSlice) -> Double { @_common.sum(s.data) }

pub fn image_morph_bothat_slice_mean(s : ImagemorphbothatSlice) -> Double { @_common.mean(s.data) }

pub fn image_morph_bothat_slice_scale(s : ImagemorphbothatSlice, f : Double) -> ImagemorphbothatSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_slice_add(a : ImagemorphbothatSlice, b : ImagemorphbothatSlice) -> ImagemorphbothatSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_bothat_slice_copy(s : ImagemorphbothatSlice) -> ImagemorphbothatSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_slice_fill(s : ImagemorphbothatSlice, v : Double) -> ImagemorphbothatSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_bothat_slice_min(s : ImagemorphbothatSlice) -> Double { @_common.min(s.data) }

pub fn image_morph_bothat_slice_max(s : ImagemorphbothatSlice) -> Double { @_common.max(s.data) }

pub fn image_morph_bothat_slice_to_string(s : ImagemorphbothatSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

