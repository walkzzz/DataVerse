///===
/// extcore/image_morph_thinning

pub(all) struct ImagemorphthinningPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_thinning_make_point(x : Double, y : Double) -> ImagemorphthinningPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_thinning_make_point3(x : Double, y : Double, z : Double) -> ImagemorphthinningPoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphthinningPoint::x(self : ImagemorphthinningPoint) -> Double { self.x }

pub fn ImagemorphthinningPoint::y(self : ImagemorphthinningPoint) -> Double { self.y }

pub fn ImagemorphthinningPoint::z(self : ImagemorphthinningPoint) -> Double { self.z }

pub fn ImagemorphthinningPoint::label(self : ImagemorphthinningPoint) -> Int { self.label }

pub fn ImagemorphthinningPoint::dist(self : ImagemorphthinningPoint, other : ImagemorphthinningPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphthinningPoint::add(self : ImagemorphthinningPoint, other : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphthinningPoint::sub(self : ImagemorphthinningPoint, other : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphthinningPoint::scale(self : ImagemorphthinningPoint, s : Double) -> ImagemorphthinningPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphthinningPoint::dot(self : ImagemorphthinningPoint, other : ImagemorphthinningPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphthinningPoint::cross(self : ImagemorphthinningPoint, other : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphthinningPoint::norm(self : ImagemorphthinningPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphthinningPoint::normalize(self : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphthinningPoint::negate(self : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphthinningPoint::mid(self : ImagemorphthinningPoint, other : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphthinningPoint::lerp(self : ImagemorphthinningPoint, other : ImagemorphthinningPoint, t : Double) -> ImagemorphthinningPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphthinningPoint::to_string(self : ImagemorphthinningPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphthinningSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_thinning_make_series(vals : Array[Double], name : String) -> ImagemorphthinningSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphthinningSeries::len(self : ImagemorphthinningSeries) -> Int { self.vals.length() }

pub fn ImagemorphthinningSeries::sum(self : ImagemorphthinningSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphthinningSeries::mean(self : ImagemorphthinningSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphthinningSeries::min(self : ImagemorphthinningSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphthinningSeries::max(self : ImagemorphthinningSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphthinningSeries::range(self : ImagemorphthinningSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphthinningSeries::variance(self : ImagemorphthinningSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphthinningSeries::std(self : ImagemorphthinningSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphthinningSeries::median(self : ImagemorphthinningSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphthinningSeries::scale(self : ImagemorphthinningSeries, f : Double) -> ImagemorphthinningSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphthinningSeries::add(self : ImagemorphthinningSeries, other : ImagemorphthinningSeries) -> ImagemorphthinningSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphthinningSeries::sub(self : ImagemorphthinningSeries, other : ImagemorphthinningSeries) -> ImagemorphthinningSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphthinningSeries::normalize(self : ImagemorphthinningSeries) -> ImagemorphthinningSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphthinningSeries::cumsum(self : ImagemorphthinningSeries) -> ImagemorphthinningSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphthinningSeries::to_string(self : ImagemorphthinningSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphthinningMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_thinning_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphthinningMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_thinning_matrix_identity(n : Int) -> ImagemorphthinningMatrix {
  let m = image_morph_thinning_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphthinningMatrix::get(self : ImagemorphthinningMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphthinningMatrix::transpose(self : ImagemorphthinningMatrix) -> ImagemorphthinningMatrix {
  let result = image_morph_thinning_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphthinningMatrix::add(self : ImagemorphthinningMatrix, other : ImagemorphthinningMatrix) -> ImagemorphthinningMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_thinning_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphthinningMatrix::scale(self : ImagemorphthinningMatrix, s : Double) -> ImagemorphthinningMatrix {
  let result = image_morph_thinning_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphthinningMatrix::multiply(self : ImagemorphthinningMatrix, other : ImagemorphthinningMatrix) -> ImagemorphthinningMatrix {
  if self.cols != other.rows { return image_morph_thinning_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_thinning_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagemorphthinningMatrix::trace(self : ImagemorphthinningMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphthinningMatrix::det(self : ImagemorphthinningMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphthinningMatrix::norm(self : ImagemorphthinningMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphthinningMatrix::to_string(self : ImagemorphthinningMatrix) -> String {
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

pub(all) struct ImagemorphthinningVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_thinning_make_vector(comps : Array[Double]) -> ImagemorphthinningVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_thinning_vector_zero(dim : Int) -> ImagemorphthinningVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphthinningVector::add(self : ImagemorphthinningVector, other : ImagemorphthinningVector) -> ImagemorphthinningVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphthinningVector::sub(self : ImagemorphthinningVector, other : ImagemorphthinningVector) -> ImagemorphthinningVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphthinningVector::scale(self : ImagemorphthinningVector, s : Double) -> ImagemorphthinningVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphthinningVector::dot(self : ImagemorphthinningVector, other : ImagemorphthinningVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphthinningVector::norm(self : ImagemorphthinningVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphthinningVector::normalize(self : ImagemorphthinningVector) -> ImagemorphthinningVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphthinningVector::dist(self : ImagemorphthinningVector, other : ImagemorphthinningVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphthinningVector::to_string(self : ImagemorphthinningVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_thinning_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_morph_thinning_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_morph_thinning_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_morph_thinning_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_morph_thinning_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_morph_thinning_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_morph_thinning_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_morph_thinning_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_morph_thinning_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_morph_thinning_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_morph_thinning_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_morph_thinning_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_morph_thinning_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_morph_thinning_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_morph_thinning_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_morph_thinning_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_morph_thinning_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_morph_thinning_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_morph_thinning_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_morph_thinning_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_morph_thinning_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_morph_thinning_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_morph_thinning_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_morph_thinning_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_morph_thinning_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_morph_thinning_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_morph_thinning_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_morph_thinning_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_morph_thinning_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagemorphthinningFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_frame_make(size : Int) -> ImagemorphthinningFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_frame_len(s : ImagemorphthinningFrame) -> Int { s.size }

pub fn image_morph_thinning_frame_get(s : ImagemorphthinningFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_frame_set(s : ImagemorphthinningFrame, i : Int, v : Double) -> ImagemorphthinningFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_frame_sum(s : ImagemorphthinningFrame) -> Double { @_common.sum(s.data) }

pub fn image_morph_thinning_frame_mean(s : ImagemorphthinningFrame) -> Double { @_common.mean(s.data) }

pub fn image_morph_thinning_frame_scale(s : ImagemorphthinningFrame, f : Double) -> ImagemorphthinningFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_frame_add(a : ImagemorphthinningFrame, b : ImagemorphthinningFrame) -> ImagemorphthinningFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thinning_frame_copy(s : ImagemorphthinningFrame) -> ImagemorphthinningFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_frame_fill(s : ImagemorphthinningFrame, v : Double) -> ImagemorphthinningFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_frame_min(s : ImagemorphthinningFrame) -> Double { @_common.min(s.data) }

pub fn image_morph_thinning_frame_max(s : ImagemorphthinningFrame) -> Double { @_common.max(s.data) }

pub fn image_morph_thinning_frame_to_string(s : ImagemorphthinningFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_table_make(size : Int) -> ImagemorphthinningTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_table_len(s : ImagemorphthinningTable) -> Int { s.size }

pub fn image_morph_thinning_table_get(s : ImagemorphthinningTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_table_set(s : ImagemorphthinningTable, i : Int, v : Double) -> ImagemorphthinningTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_table_sum(s : ImagemorphthinningTable) -> Double { @_common.sum(s.data) }

pub fn image_morph_thinning_table_mean(s : ImagemorphthinningTable) -> Double { @_common.mean(s.data) }

pub fn image_morph_thinning_table_scale(s : ImagemorphthinningTable, f : Double) -> ImagemorphthinningTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_table_add(a : ImagemorphthinningTable, b : ImagemorphthinningTable) -> ImagemorphthinningTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thinning_table_copy(s : ImagemorphthinningTable) -> ImagemorphthinningTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_table_fill(s : ImagemorphthinningTable, v : Double) -> ImagemorphthinningTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_table_min(s : ImagemorphthinningTable) -> Double { @_common.min(s.data) }

pub fn image_morph_thinning_table_max(s : ImagemorphthinningTable) -> Double { @_common.max(s.data) }

pub fn image_morph_thinning_table_to_string(s : ImagemorphthinningTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_graphn_make(size : Int) -> ImagemorphthinningGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_graphn_len(s : ImagemorphthinningGraphN) -> Int { s.size }

pub fn image_morph_thinning_graphn_get(s : ImagemorphthinningGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_graphn_set(s : ImagemorphthinningGraphN, i : Int, v : Double) -> ImagemorphthinningGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_graphn_sum(s : ImagemorphthinningGraphN) -> Double { @_common.sum(s.data) }

pub fn image_morph_thinning_graphn_mean(s : ImagemorphthinningGraphN) -> Double { @_common.mean(s.data) }

pub fn image_morph_thinning_graphn_scale(s : ImagemorphthinningGraphN, f : Double) -> ImagemorphthinningGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_graphn_add(a : ImagemorphthinningGraphN, b : ImagemorphthinningGraphN) -> ImagemorphthinningGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thinning_graphn_copy(s : ImagemorphthinningGraphN) -> ImagemorphthinningGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_graphn_fill(s : ImagemorphthinningGraphN, v : Double) -> ImagemorphthinningGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_graphn_min(s : ImagemorphthinningGraphN) -> Double { @_common.min(s.data) }

pub fn image_morph_thinning_graphn_max(s : ImagemorphthinningGraphN) -> Double { @_common.max(s.data) }

pub fn image_morph_thinning_graphn_to_string(s : ImagemorphthinningGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_node_make(size : Int) -> ImagemorphthinningNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_node_len(s : ImagemorphthinningNode) -> Int { s.size }

pub fn image_morph_thinning_node_get(s : ImagemorphthinningNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_node_set(s : ImagemorphthinningNode, i : Int, v : Double) -> ImagemorphthinningNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_node_sum(s : ImagemorphthinningNode) -> Double { @_common.sum(s.data) }

pub fn image_morph_thinning_node_mean(s : ImagemorphthinningNode) -> Double { @_common.mean(s.data) }

pub fn image_morph_thinning_node_scale(s : ImagemorphthinningNode, f : Double) -> ImagemorphthinningNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_node_add(a : ImagemorphthinningNode, b : ImagemorphthinningNode) -> ImagemorphthinningNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thinning_node_copy(s : ImagemorphthinningNode) -> ImagemorphthinningNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_node_fill(s : ImagemorphthinningNode, v : Double) -> ImagemorphthinningNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_node_min(s : ImagemorphthinningNode) -> Double { @_common.min(s.data) }

pub fn image_morph_thinning_node_max(s : ImagemorphthinningNode) -> Double { @_common.max(s.data) }

pub fn image_morph_thinning_node_to_string(s : ImagemorphthinningNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_edge_make(size : Int) -> ImagemorphthinningEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_edge_len(s : ImagemorphthinningEdge) -> Int { s.size }

pub fn image_morph_thinning_edge_get(s : ImagemorphthinningEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_edge_set(s : ImagemorphthinningEdge, i : Int, v : Double) -> ImagemorphthinningEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_edge_sum(s : ImagemorphthinningEdge) -> Double { @_common.sum(s.data) }

pub fn image_morph_thinning_edge_mean(s : ImagemorphthinningEdge) -> Double { @_common.mean(s.data) }

pub fn image_morph_thinning_edge_scale(s : ImagemorphthinningEdge, f : Double) -> ImagemorphthinningEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_edge_add(a : ImagemorphthinningEdge, b : ImagemorphthinningEdge) -> ImagemorphthinningEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thinning_edge_copy(s : ImagemorphthinningEdge) -> ImagemorphthinningEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_edge_fill(s : ImagemorphthinningEdge, v : Double) -> ImagemorphthinningEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_edge_min(s : ImagemorphthinningEdge) -> Double { @_common.min(s.data) }

pub fn image_morph_thinning_edge_max(s : ImagemorphthinningEdge) -> Double { @_common.max(s.data) }

pub fn image_morph_thinning_edge_to_string(s : ImagemorphthinningEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_path_make(size : Int) -> ImagemorphthinningPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_path_len(s : ImagemorphthinningPath) -> Int { s.size }

pub fn image_morph_thinning_path_get(s : ImagemorphthinningPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_path_set(s : ImagemorphthinningPath, i : Int, v : Double) -> ImagemorphthinningPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_path_sum(s : ImagemorphthinningPath) -> Double { @_common.sum(s.data) }

pub fn image_morph_thinning_path_mean(s : ImagemorphthinningPath) -> Double { @_common.mean(s.data) }

pub fn image_morph_thinning_path_scale(s : ImagemorphthinningPath, f : Double) -> ImagemorphthinningPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_path_add(a : ImagemorphthinningPath, b : ImagemorphthinningPath) -> ImagemorphthinningPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thinning_path_copy(s : ImagemorphthinningPath) -> ImagemorphthinningPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_path_fill(s : ImagemorphthinningPath, v : Double) -> ImagemorphthinningPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_path_min(s : ImagemorphthinningPath) -> Double { @_common.min(s.data) }

pub fn image_morph_thinning_path_max(s : ImagemorphthinningPath) -> Double { @_common.max(s.data) }

pub fn image_morph_thinning_path_to_string(s : ImagemorphthinningPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_cluster_make(size : Int) -> ImagemorphthinningCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_cluster_len(s : ImagemorphthinningCluster) -> Int { s.size }

pub fn image_morph_thinning_cluster_get(s : ImagemorphthinningCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_cluster_set(s : ImagemorphthinningCluster, i : Int, v : Double) -> ImagemorphthinningCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_cluster_sum(s : ImagemorphthinningCluster) -> Double { @_common.sum(s.data) }

pub fn image_morph_thinning_cluster_mean(s : ImagemorphthinningCluster) -> Double { @_common.mean(s.data) }

pub fn image_morph_thinning_cluster_scale(s : ImagemorphthinningCluster, f : Double) -> ImagemorphthinningCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_cluster_add(a : ImagemorphthinningCluster, b : ImagemorphthinningCluster) -> ImagemorphthinningCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thinning_cluster_copy(s : ImagemorphthinningCluster) -> ImagemorphthinningCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_cluster_fill(s : ImagemorphthinningCluster, v : Double) -> ImagemorphthinningCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_cluster_min(s : ImagemorphthinningCluster) -> Double { @_common.min(s.data) }

pub fn image_morph_thinning_cluster_max(s : ImagemorphthinningCluster) -> Double { @_common.max(s.data) }

pub fn image_morph_thinning_cluster_to_string(s : ImagemorphthinningCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_model_make(size : Int) -> ImagemorphthinningModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_model_len(s : ImagemorphthinningModel) -> Int { s.size }

pub fn image_morph_thinning_model_get(s : ImagemorphthinningModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_model_set(s : ImagemorphthinningModel, i : Int, v : Double) -> ImagemorphthinningModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_model_sum(s : ImagemorphthinningModel) -> Double { @_common.sum(s.data) }

pub fn image_morph_thinning_model_mean(s : ImagemorphthinningModel) -> Double { @_common.mean(s.data) }

pub fn image_morph_thinning_model_scale(s : ImagemorphthinningModel, f : Double) -> ImagemorphthinningModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_model_add(a : ImagemorphthinningModel, b : ImagemorphthinningModel) -> ImagemorphthinningModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thinning_model_copy(s : ImagemorphthinningModel) -> ImagemorphthinningModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_model_fill(s : ImagemorphthinningModel, v : Double) -> ImagemorphthinningModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_model_min(s : ImagemorphthinningModel) -> Double { @_common.min(s.data) }

pub fn image_morph_thinning_model_max(s : ImagemorphthinningModel) -> Double { @_common.max(s.data) }

pub fn image_morph_thinning_model_to_string(s : ImagemorphthinningModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_layer_make(size : Int) -> ImagemorphthinningLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_layer_len(s : ImagemorphthinningLayer) -> Int { s.size }

pub fn image_morph_thinning_layer_get(s : ImagemorphthinningLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_layer_set(s : ImagemorphthinningLayer, i : Int, v : Double) -> ImagemorphthinningLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_layer_sum(s : ImagemorphthinningLayer) -> Double { @_common.sum(s.data) }

pub fn image_morph_thinning_layer_mean(s : ImagemorphthinningLayer) -> Double { @_common.mean(s.data) }

pub fn image_morph_thinning_layer_scale(s : ImagemorphthinningLayer, f : Double) -> ImagemorphthinningLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_layer_add(a : ImagemorphthinningLayer, b : ImagemorphthinningLayer) -> ImagemorphthinningLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thinning_layer_copy(s : ImagemorphthinningLayer) -> ImagemorphthinningLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_layer_fill(s : ImagemorphthinningLayer, v : Double) -> ImagemorphthinningLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_layer_min(s : ImagemorphthinningLayer) -> Double { @_common.min(s.data) }

pub fn image_morph_thinning_layer_max(s : ImagemorphthinningLayer) -> Double { @_common.max(s.data) }

pub fn image_morph_thinning_layer_to_string(s : ImagemorphthinningLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_buffer_make(size : Int) -> ImagemorphthinningBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_buffer_len(s : ImagemorphthinningBuffer) -> Int { s.size }

pub fn image_morph_thinning_buffer_get(s : ImagemorphthinningBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_buffer_set(s : ImagemorphthinningBuffer, i : Int, v : Double) -> ImagemorphthinningBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_buffer_sum(s : ImagemorphthinningBuffer) -> Double { @_common.sum(s.data) }

pub fn image_morph_thinning_buffer_mean(s : ImagemorphthinningBuffer) -> Double { @_common.mean(s.data) }

pub fn image_morph_thinning_buffer_scale(s : ImagemorphthinningBuffer, f : Double) -> ImagemorphthinningBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_buffer_add(a : ImagemorphthinningBuffer, b : ImagemorphthinningBuffer) -> ImagemorphthinningBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thinning_buffer_copy(s : ImagemorphthinningBuffer) -> ImagemorphthinningBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_buffer_fill(s : ImagemorphthinningBuffer, v : Double) -> ImagemorphthinningBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_buffer_min(s : ImagemorphthinningBuffer) -> Double { @_common.min(s.data) }

pub fn image_morph_thinning_buffer_max(s : ImagemorphthinningBuffer) -> Double { @_common.max(s.data) }

pub fn image_morph_thinning_buffer_to_string(s : ImagemorphthinningBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_cursor_make(size : Int) -> ImagemorphthinningCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_cursor_len(s : ImagemorphthinningCursor) -> Int { s.size }

pub fn image_morph_thinning_cursor_get(s : ImagemorphthinningCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_cursor_set(s : ImagemorphthinningCursor, i : Int, v : Double) -> ImagemorphthinningCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_cursor_sum(s : ImagemorphthinningCursor) -> Double { @_common.sum(s.data) }

pub fn image_morph_thinning_cursor_mean(s : ImagemorphthinningCursor) -> Double { @_common.mean(s.data) }

pub fn image_morph_thinning_cursor_scale(s : ImagemorphthinningCursor, f : Double) -> ImagemorphthinningCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_cursor_add(a : ImagemorphthinningCursor, b : ImagemorphthinningCursor) -> ImagemorphthinningCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thinning_cursor_copy(s : ImagemorphthinningCursor) -> ImagemorphthinningCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_cursor_fill(s : ImagemorphthinningCursor, v : Double) -> ImagemorphthinningCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_cursor_min(s : ImagemorphthinningCursor) -> Double { @_common.min(s.data) }

pub fn image_morph_thinning_cursor_max(s : ImagemorphthinningCursor) -> Double { @_common.max(s.data) }

pub fn image_morph_thinning_cursor_to_string(s : ImagemorphthinningCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_view_make(size : Int) -> ImagemorphthinningView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_view_len(s : ImagemorphthinningView) -> Int { s.size }

pub fn image_morph_thinning_view_get(s : ImagemorphthinningView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_view_set(s : ImagemorphthinningView, i : Int, v : Double) -> ImagemorphthinningView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_view_sum(s : ImagemorphthinningView) -> Double { @_common.sum(s.data) }

pub fn image_morph_thinning_view_mean(s : ImagemorphthinningView) -> Double { @_common.mean(s.data) }

pub fn image_morph_thinning_view_scale(s : ImagemorphthinningView, f : Double) -> ImagemorphthinningView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_view_add(a : ImagemorphthinningView, b : ImagemorphthinningView) -> ImagemorphthinningView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thinning_view_copy(s : ImagemorphthinningView) -> ImagemorphthinningView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_view_fill(s : ImagemorphthinningView, v : Double) -> ImagemorphthinningView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_view_min(s : ImagemorphthinningView) -> Double { @_common.min(s.data) }

pub fn image_morph_thinning_view_max(s : ImagemorphthinningView) -> Double { @_common.max(s.data) }

pub fn image_morph_thinning_view_to_string(s : ImagemorphthinningView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_range_make(size : Int) -> ImagemorphthinningRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_range_len(s : ImagemorphthinningRange) -> Int { s.size }

pub fn image_morph_thinning_range_get(s : ImagemorphthinningRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_range_set(s : ImagemorphthinningRange, i : Int, v : Double) -> ImagemorphthinningRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_range_sum(s : ImagemorphthinningRange) -> Double { @_common.sum(s.data) }

pub fn image_morph_thinning_range_mean(s : ImagemorphthinningRange) -> Double { @_common.mean(s.data) }

pub fn image_morph_thinning_range_scale(s : ImagemorphthinningRange, f : Double) -> ImagemorphthinningRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_range_add(a : ImagemorphthinningRange, b : ImagemorphthinningRange) -> ImagemorphthinningRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thinning_range_copy(s : ImagemorphthinningRange) -> ImagemorphthinningRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_range_fill(s : ImagemorphthinningRange, v : Double) -> ImagemorphthinningRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_range_min(s : ImagemorphthinningRange) -> Double { @_common.min(s.data) }

pub fn image_morph_thinning_range_max(s : ImagemorphthinningRange) -> Double { @_common.max(s.data) }

pub fn image_morph_thinning_range_to_string(s : ImagemorphthinningRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_slice_make(size : Int) -> ImagemorphthinningSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_slice_len(s : ImagemorphthinningSlice) -> Int { s.size }

pub fn image_morph_thinning_slice_get(s : ImagemorphthinningSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_slice_set(s : ImagemorphthinningSlice, i : Int, v : Double) -> ImagemorphthinningSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_slice_sum(s : ImagemorphthinningSlice) -> Double { @_common.sum(s.data) }

pub fn image_morph_thinning_slice_mean(s : ImagemorphthinningSlice) -> Double { @_common.mean(s.data) }

pub fn image_morph_thinning_slice_scale(s : ImagemorphthinningSlice, f : Double) -> ImagemorphthinningSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_slice_add(a : ImagemorphthinningSlice, b : ImagemorphthinningSlice) -> ImagemorphthinningSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thinning_slice_copy(s : ImagemorphthinningSlice) -> ImagemorphthinningSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_slice_fill(s : ImagemorphthinningSlice, v : Double) -> ImagemorphthinningSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thinning_slice_min(s : ImagemorphthinningSlice) -> Double { @_common.min(s.data) }

pub fn image_morph_thinning_slice_max(s : ImagemorphthinningSlice) -> Double { @_common.max(s.data) }

pub fn image_morph_thinning_slice_to_string(s : ImagemorphthinningSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

