///===
/// extcore/image_filter_prewitt

pub(all) struct ImagefilterprewittPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_prewitt_make_point(x : Double, y : Double) -> ImagefilterprewittPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_prewitt_make_point3(x : Double, y : Double, z : Double) -> ImagefilterprewittPoint {
  { x, y, z, label: 0 }
}

pub fn ImagefilterprewittPoint::x(self : ImagefilterprewittPoint) -> Double { self.x }

pub fn ImagefilterprewittPoint::y(self : ImagefilterprewittPoint) -> Double { self.y }

pub fn ImagefilterprewittPoint::z(self : ImagefilterprewittPoint) -> Double { self.z }

pub fn ImagefilterprewittPoint::label(self : ImagefilterprewittPoint) -> Int { self.label }

pub fn ImagefilterprewittPoint::dist(self : ImagefilterprewittPoint, other : ImagefilterprewittPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagefilterprewittPoint::add(self : ImagefilterprewittPoint, other : ImagefilterprewittPoint) -> ImagefilterprewittPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagefilterprewittPoint::sub(self : ImagefilterprewittPoint, other : ImagefilterprewittPoint) -> ImagefilterprewittPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagefilterprewittPoint::scale(self : ImagefilterprewittPoint, s : Double) -> ImagefilterprewittPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagefilterprewittPoint::dot(self : ImagefilterprewittPoint, other : ImagefilterprewittPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagefilterprewittPoint::cross(self : ImagefilterprewittPoint, other : ImagefilterprewittPoint) -> ImagefilterprewittPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagefilterprewittPoint::norm(self : ImagefilterprewittPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagefilterprewittPoint::normalize(self : ImagefilterprewittPoint) -> ImagefilterprewittPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefilterprewittPoint::negate(self : ImagefilterprewittPoint) -> ImagefilterprewittPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagefilterprewittPoint::mid(self : ImagefilterprewittPoint, other : ImagefilterprewittPoint) -> ImagefilterprewittPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagefilterprewittPoint::lerp(self : ImagefilterprewittPoint, other : ImagefilterprewittPoint, t : Double) -> ImagefilterprewittPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagefilterprewittPoint::to_string(self : ImagefilterprewittPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagefilterprewittSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_prewitt_make_series(vals : Array[Double], name : String) -> ImagefilterprewittSeries {
  { vals, name, meta: 0 }
}

pub fn ImagefilterprewittSeries::len(self : ImagefilterprewittSeries) -> Int { self.vals.length() }

pub fn ImagefilterprewittSeries::sum(self : ImagefilterprewittSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagefilterprewittSeries::mean(self : ImagefilterprewittSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagefilterprewittSeries::min(self : ImagefilterprewittSeries) -> Double { @_common.min(self.vals) }

pub fn ImagefilterprewittSeries::max(self : ImagefilterprewittSeries) -> Double { @_common.max(self.vals) }

pub fn ImagefilterprewittSeries::range(self : ImagefilterprewittSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagefilterprewittSeries::variance(self : ImagefilterprewittSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagefilterprewittSeries::std(self : ImagefilterprewittSeries) -> Double { @_common.std(self.vals) }

pub fn ImagefilterprewittSeries::median(self : ImagefilterprewittSeries) -> Double { @_common.median(self.vals) }

pub fn ImagefilterprewittSeries::scale(self : ImagefilterprewittSeries, f : Double) -> ImagefilterprewittSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagefilterprewittSeries::add(self : ImagefilterprewittSeries, other : ImagefilterprewittSeries) -> ImagefilterprewittSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagefilterprewittSeries::sub(self : ImagefilterprewittSeries, other : ImagefilterprewittSeries) -> ImagefilterprewittSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagefilterprewittSeries::normalize(self : ImagefilterprewittSeries) -> ImagefilterprewittSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagefilterprewittSeries::cumsum(self : ImagefilterprewittSeries) -> ImagefilterprewittSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagefilterprewittSeries::to_string(self : ImagefilterprewittSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefilterprewittMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_prewitt_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefilterprewittMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_prewitt_matrix_identity(n : Int) -> ImagefilterprewittMatrix {
  let m = image_filter_prewitt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagefilterprewittMatrix::get(self : ImagefilterprewittMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagefilterprewittMatrix::transpose(self : ImagefilterprewittMatrix) -> ImagefilterprewittMatrix {
  let result = image_filter_prewitt_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagefilterprewittMatrix::add(self : ImagefilterprewittMatrix, other : ImagefilterprewittMatrix) -> ImagefilterprewittMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_filter_prewitt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagefilterprewittMatrix::scale(self : ImagefilterprewittMatrix, s : Double) -> ImagefilterprewittMatrix {
  let result = image_filter_prewitt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagefilterprewittMatrix::multiply(self : ImagefilterprewittMatrix, other : ImagefilterprewittMatrix) -> ImagefilterprewittMatrix {
  if self.cols != other.rows { return image_filter_prewitt_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_filter_prewitt_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagefilterprewittMatrix::trace(self : ImagefilterprewittMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagefilterprewittMatrix::det(self : ImagefilterprewittMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagefilterprewittMatrix::norm(self : ImagefilterprewittMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagefilterprewittMatrix::to_string(self : ImagefilterprewittMatrix) -> String {
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

pub(all) struct ImagefilterprewittVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_prewitt_make_vector(comps : Array[Double]) -> ImagefilterprewittVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_prewitt_vector_zero(dim : Int) -> ImagefilterprewittVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagefilterprewittVector::add(self : ImagefilterprewittVector, other : ImagefilterprewittVector) -> ImagefilterprewittVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefilterprewittVector::sub(self : ImagefilterprewittVector, other : ImagefilterprewittVector) -> ImagefilterprewittVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagefilterprewittVector::scale(self : ImagefilterprewittVector, s : Double) -> ImagefilterprewittVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagefilterprewittVector::dot(self : ImagefilterprewittVector, other : ImagefilterprewittVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagefilterprewittVector::norm(self : ImagefilterprewittVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagefilterprewittVector::normalize(self : ImagefilterprewittVector) -> ImagefilterprewittVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagefilterprewittVector::dist(self : ImagefilterprewittVector, other : ImagefilterprewittVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagefilterprewittVector::to_string(self : ImagefilterprewittVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_prewitt_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_prewitt_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_prewitt_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_prewitt_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_prewitt_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_prewitt_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_prewitt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_prewitt_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_prewitt_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_prewitt_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_prewitt_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_prewitt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_prewitt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_prewitt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_prewitt_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_prewitt_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_prewitt_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_prewitt_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_prewitt_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_prewitt_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_prewitt_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_prewitt_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_prewitt_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_prewitt_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_prewitt_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_prewitt_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_prewitt_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_prewitt_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_prewitt_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefilterprewittFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_frame_make(size : Int) -> ImagefilterprewittFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_frame_len(s : ImagefilterprewittFrame) -> Int { s.size }

pub fn image_filter_prewitt_frame_get(s : ImagefilterprewittFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_frame_set(s : ImagefilterprewittFrame, i : Int, v : Double) -> ImagefilterprewittFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_frame_sum(s : ImagefilterprewittFrame) -> Double { @_common.sum(s.data) }

pub fn image_filter_prewitt_frame_mean(s : ImagefilterprewittFrame) -> Double { @_common.mean(s.data) }

pub fn image_filter_prewitt_frame_scale(s : ImagefilterprewittFrame, f : Double) -> ImagefilterprewittFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_frame_add(a : ImagefilterprewittFrame, b : ImagefilterprewittFrame) -> ImagefilterprewittFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_prewitt_frame_copy(s : ImagefilterprewittFrame) -> ImagefilterprewittFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_frame_fill(s : ImagefilterprewittFrame, v : Double) -> ImagefilterprewittFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_frame_min(s : ImagefilterprewittFrame) -> Double { @_common.min(s.data) }

pub fn image_filter_prewitt_frame_max(s : ImagefilterprewittFrame) -> Double { @_common.max(s.data) }

pub fn image_filter_prewitt_frame_to_string(s : ImagefilterprewittFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_table_make(size : Int) -> ImagefilterprewittTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_table_len(s : ImagefilterprewittTable) -> Int { s.size }

pub fn image_filter_prewitt_table_get(s : ImagefilterprewittTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_table_set(s : ImagefilterprewittTable, i : Int, v : Double) -> ImagefilterprewittTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_table_sum(s : ImagefilterprewittTable) -> Double { @_common.sum(s.data) }

pub fn image_filter_prewitt_table_mean(s : ImagefilterprewittTable) -> Double { @_common.mean(s.data) }

pub fn image_filter_prewitt_table_scale(s : ImagefilterprewittTable, f : Double) -> ImagefilterprewittTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_table_add(a : ImagefilterprewittTable, b : ImagefilterprewittTable) -> ImagefilterprewittTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_prewitt_table_copy(s : ImagefilterprewittTable) -> ImagefilterprewittTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_table_fill(s : ImagefilterprewittTable, v : Double) -> ImagefilterprewittTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_table_min(s : ImagefilterprewittTable) -> Double { @_common.min(s.data) }

pub fn image_filter_prewitt_table_max(s : ImagefilterprewittTable) -> Double { @_common.max(s.data) }

pub fn image_filter_prewitt_table_to_string(s : ImagefilterprewittTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_graphn_make(size : Int) -> ImagefilterprewittGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_graphn_len(s : ImagefilterprewittGraphN) -> Int { s.size }

pub fn image_filter_prewitt_graphn_get(s : ImagefilterprewittGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_graphn_set(s : ImagefilterprewittGraphN, i : Int, v : Double) -> ImagefilterprewittGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_graphn_sum(s : ImagefilterprewittGraphN) -> Double { @_common.sum(s.data) }

pub fn image_filter_prewitt_graphn_mean(s : ImagefilterprewittGraphN) -> Double { @_common.mean(s.data) }

pub fn image_filter_prewitt_graphn_scale(s : ImagefilterprewittGraphN, f : Double) -> ImagefilterprewittGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_graphn_add(a : ImagefilterprewittGraphN, b : ImagefilterprewittGraphN) -> ImagefilterprewittGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_prewitt_graphn_copy(s : ImagefilterprewittGraphN) -> ImagefilterprewittGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_graphn_fill(s : ImagefilterprewittGraphN, v : Double) -> ImagefilterprewittGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_graphn_min(s : ImagefilterprewittGraphN) -> Double { @_common.min(s.data) }

pub fn image_filter_prewitt_graphn_max(s : ImagefilterprewittGraphN) -> Double { @_common.max(s.data) }

pub fn image_filter_prewitt_graphn_to_string(s : ImagefilterprewittGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_node_make(size : Int) -> ImagefilterprewittNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_node_len(s : ImagefilterprewittNode) -> Int { s.size }

pub fn image_filter_prewitt_node_get(s : ImagefilterprewittNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_node_set(s : ImagefilterprewittNode, i : Int, v : Double) -> ImagefilterprewittNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_node_sum(s : ImagefilterprewittNode) -> Double { @_common.sum(s.data) }

pub fn image_filter_prewitt_node_mean(s : ImagefilterprewittNode) -> Double { @_common.mean(s.data) }

pub fn image_filter_prewitt_node_scale(s : ImagefilterprewittNode, f : Double) -> ImagefilterprewittNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_node_add(a : ImagefilterprewittNode, b : ImagefilterprewittNode) -> ImagefilterprewittNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_prewitt_node_copy(s : ImagefilterprewittNode) -> ImagefilterprewittNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_node_fill(s : ImagefilterprewittNode, v : Double) -> ImagefilterprewittNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_node_min(s : ImagefilterprewittNode) -> Double { @_common.min(s.data) }

pub fn image_filter_prewitt_node_max(s : ImagefilterprewittNode) -> Double { @_common.max(s.data) }

pub fn image_filter_prewitt_node_to_string(s : ImagefilterprewittNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_edge_make(size : Int) -> ImagefilterprewittEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_edge_len(s : ImagefilterprewittEdge) -> Int { s.size }

pub fn image_filter_prewitt_edge_get(s : ImagefilterprewittEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_edge_set(s : ImagefilterprewittEdge, i : Int, v : Double) -> ImagefilterprewittEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_edge_sum(s : ImagefilterprewittEdge) -> Double { @_common.sum(s.data) }

pub fn image_filter_prewitt_edge_mean(s : ImagefilterprewittEdge) -> Double { @_common.mean(s.data) }

pub fn image_filter_prewitt_edge_scale(s : ImagefilterprewittEdge, f : Double) -> ImagefilterprewittEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_edge_add(a : ImagefilterprewittEdge, b : ImagefilterprewittEdge) -> ImagefilterprewittEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_prewitt_edge_copy(s : ImagefilterprewittEdge) -> ImagefilterprewittEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_edge_fill(s : ImagefilterprewittEdge, v : Double) -> ImagefilterprewittEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_edge_min(s : ImagefilterprewittEdge) -> Double { @_common.min(s.data) }

pub fn image_filter_prewitt_edge_max(s : ImagefilterprewittEdge) -> Double { @_common.max(s.data) }

pub fn image_filter_prewitt_edge_to_string(s : ImagefilterprewittEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_path_make(size : Int) -> ImagefilterprewittPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_path_len(s : ImagefilterprewittPath) -> Int { s.size }

pub fn image_filter_prewitt_path_get(s : ImagefilterprewittPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_path_set(s : ImagefilterprewittPath, i : Int, v : Double) -> ImagefilterprewittPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_path_sum(s : ImagefilterprewittPath) -> Double { @_common.sum(s.data) }

pub fn image_filter_prewitt_path_mean(s : ImagefilterprewittPath) -> Double { @_common.mean(s.data) }

pub fn image_filter_prewitt_path_scale(s : ImagefilterprewittPath, f : Double) -> ImagefilterprewittPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_path_add(a : ImagefilterprewittPath, b : ImagefilterprewittPath) -> ImagefilterprewittPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_prewitt_path_copy(s : ImagefilterprewittPath) -> ImagefilterprewittPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_path_fill(s : ImagefilterprewittPath, v : Double) -> ImagefilterprewittPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_path_min(s : ImagefilterprewittPath) -> Double { @_common.min(s.data) }

pub fn image_filter_prewitt_path_max(s : ImagefilterprewittPath) -> Double { @_common.max(s.data) }

pub fn image_filter_prewitt_path_to_string(s : ImagefilterprewittPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_cluster_make(size : Int) -> ImagefilterprewittCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_cluster_len(s : ImagefilterprewittCluster) -> Int { s.size }

pub fn image_filter_prewitt_cluster_get(s : ImagefilterprewittCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_cluster_set(s : ImagefilterprewittCluster, i : Int, v : Double) -> ImagefilterprewittCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_cluster_sum(s : ImagefilterprewittCluster) -> Double { @_common.sum(s.data) }

pub fn image_filter_prewitt_cluster_mean(s : ImagefilterprewittCluster) -> Double { @_common.mean(s.data) }

pub fn image_filter_prewitt_cluster_scale(s : ImagefilterprewittCluster, f : Double) -> ImagefilterprewittCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_cluster_add(a : ImagefilterprewittCluster, b : ImagefilterprewittCluster) -> ImagefilterprewittCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_prewitt_cluster_copy(s : ImagefilterprewittCluster) -> ImagefilterprewittCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_cluster_fill(s : ImagefilterprewittCluster, v : Double) -> ImagefilterprewittCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_cluster_min(s : ImagefilterprewittCluster) -> Double { @_common.min(s.data) }

pub fn image_filter_prewitt_cluster_max(s : ImagefilterprewittCluster) -> Double { @_common.max(s.data) }

pub fn image_filter_prewitt_cluster_to_string(s : ImagefilterprewittCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_model_make(size : Int) -> ImagefilterprewittModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_model_len(s : ImagefilterprewittModel) -> Int { s.size }

pub fn image_filter_prewitt_model_get(s : ImagefilterprewittModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_model_set(s : ImagefilterprewittModel, i : Int, v : Double) -> ImagefilterprewittModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_model_sum(s : ImagefilterprewittModel) -> Double { @_common.sum(s.data) }

pub fn image_filter_prewitt_model_mean(s : ImagefilterprewittModel) -> Double { @_common.mean(s.data) }

pub fn image_filter_prewitt_model_scale(s : ImagefilterprewittModel, f : Double) -> ImagefilterprewittModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_model_add(a : ImagefilterprewittModel, b : ImagefilterprewittModel) -> ImagefilterprewittModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_prewitt_model_copy(s : ImagefilterprewittModel) -> ImagefilterprewittModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_model_fill(s : ImagefilterprewittModel, v : Double) -> ImagefilterprewittModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_model_min(s : ImagefilterprewittModel) -> Double { @_common.min(s.data) }

pub fn image_filter_prewitt_model_max(s : ImagefilterprewittModel) -> Double { @_common.max(s.data) }

pub fn image_filter_prewitt_model_to_string(s : ImagefilterprewittModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_layer_make(size : Int) -> ImagefilterprewittLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_layer_len(s : ImagefilterprewittLayer) -> Int { s.size }

pub fn image_filter_prewitt_layer_get(s : ImagefilterprewittLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_layer_set(s : ImagefilterprewittLayer, i : Int, v : Double) -> ImagefilterprewittLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_layer_sum(s : ImagefilterprewittLayer) -> Double { @_common.sum(s.data) }

pub fn image_filter_prewitt_layer_mean(s : ImagefilterprewittLayer) -> Double { @_common.mean(s.data) }

pub fn image_filter_prewitt_layer_scale(s : ImagefilterprewittLayer, f : Double) -> ImagefilterprewittLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_layer_add(a : ImagefilterprewittLayer, b : ImagefilterprewittLayer) -> ImagefilterprewittLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_prewitt_layer_copy(s : ImagefilterprewittLayer) -> ImagefilterprewittLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_layer_fill(s : ImagefilterprewittLayer, v : Double) -> ImagefilterprewittLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_layer_min(s : ImagefilterprewittLayer) -> Double { @_common.min(s.data) }

pub fn image_filter_prewitt_layer_max(s : ImagefilterprewittLayer) -> Double { @_common.max(s.data) }

pub fn image_filter_prewitt_layer_to_string(s : ImagefilterprewittLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_buffer_make(size : Int) -> ImagefilterprewittBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_buffer_len(s : ImagefilterprewittBuffer) -> Int { s.size }

pub fn image_filter_prewitt_buffer_get(s : ImagefilterprewittBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_buffer_set(s : ImagefilterprewittBuffer, i : Int, v : Double) -> ImagefilterprewittBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_buffer_sum(s : ImagefilterprewittBuffer) -> Double { @_common.sum(s.data) }

pub fn image_filter_prewitt_buffer_mean(s : ImagefilterprewittBuffer) -> Double { @_common.mean(s.data) }

pub fn image_filter_prewitt_buffer_scale(s : ImagefilterprewittBuffer, f : Double) -> ImagefilterprewittBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_buffer_add(a : ImagefilterprewittBuffer, b : ImagefilterprewittBuffer) -> ImagefilterprewittBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_prewitt_buffer_copy(s : ImagefilterprewittBuffer) -> ImagefilterprewittBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_buffer_fill(s : ImagefilterprewittBuffer, v : Double) -> ImagefilterprewittBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_buffer_min(s : ImagefilterprewittBuffer) -> Double { @_common.min(s.data) }

pub fn image_filter_prewitt_buffer_max(s : ImagefilterprewittBuffer) -> Double { @_common.max(s.data) }

pub fn image_filter_prewitt_buffer_to_string(s : ImagefilterprewittBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_cursor_make(size : Int) -> ImagefilterprewittCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_cursor_len(s : ImagefilterprewittCursor) -> Int { s.size }

pub fn image_filter_prewitt_cursor_get(s : ImagefilterprewittCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_cursor_set(s : ImagefilterprewittCursor, i : Int, v : Double) -> ImagefilterprewittCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_cursor_sum(s : ImagefilterprewittCursor) -> Double { @_common.sum(s.data) }

pub fn image_filter_prewitt_cursor_mean(s : ImagefilterprewittCursor) -> Double { @_common.mean(s.data) }

pub fn image_filter_prewitt_cursor_scale(s : ImagefilterprewittCursor, f : Double) -> ImagefilterprewittCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_cursor_add(a : ImagefilterprewittCursor, b : ImagefilterprewittCursor) -> ImagefilterprewittCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_prewitt_cursor_copy(s : ImagefilterprewittCursor) -> ImagefilterprewittCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_cursor_fill(s : ImagefilterprewittCursor, v : Double) -> ImagefilterprewittCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_cursor_min(s : ImagefilterprewittCursor) -> Double { @_common.min(s.data) }

pub fn image_filter_prewitt_cursor_max(s : ImagefilterprewittCursor) -> Double { @_common.max(s.data) }

pub fn image_filter_prewitt_cursor_to_string(s : ImagefilterprewittCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_view_make(size : Int) -> ImagefilterprewittView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_view_len(s : ImagefilterprewittView) -> Int { s.size }

pub fn image_filter_prewitt_view_get(s : ImagefilterprewittView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_view_set(s : ImagefilterprewittView, i : Int, v : Double) -> ImagefilterprewittView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_view_sum(s : ImagefilterprewittView) -> Double { @_common.sum(s.data) }

pub fn image_filter_prewitt_view_mean(s : ImagefilterprewittView) -> Double { @_common.mean(s.data) }

pub fn image_filter_prewitt_view_scale(s : ImagefilterprewittView, f : Double) -> ImagefilterprewittView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_view_add(a : ImagefilterprewittView, b : ImagefilterprewittView) -> ImagefilterprewittView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_prewitt_view_copy(s : ImagefilterprewittView) -> ImagefilterprewittView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_view_fill(s : ImagefilterprewittView, v : Double) -> ImagefilterprewittView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_view_min(s : ImagefilterprewittView) -> Double { @_common.min(s.data) }

pub fn image_filter_prewitt_view_max(s : ImagefilterprewittView) -> Double { @_common.max(s.data) }

pub fn image_filter_prewitt_view_to_string(s : ImagefilterprewittView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_range_make(size : Int) -> ImagefilterprewittRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_range_len(s : ImagefilterprewittRange) -> Int { s.size }

pub fn image_filter_prewitt_range_get(s : ImagefilterprewittRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_range_set(s : ImagefilterprewittRange, i : Int, v : Double) -> ImagefilterprewittRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_range_sum(s : ImagefilterprewittRange) -> Double { @_common.sum(s.data) }

pub fn image_filter_prewitt_range_mean(s : ImagefilterprewittRange) -> Double { @_common.mean(s.data) }

pub fn image_filter_prewitt_range_scale(s : ImagefilterprewittRange, f : Double) -> ImagefilterprewittRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_range_add(a : ImagefilterprewittRange, b : ImagefilterprewittRange) -> ImagefilterprewittRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_prewitt_range_copy(s : ImagefilterprewittRange) -> ImagefilterprewittRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_range_fill(s : ImagefilterprewittRange, v : Double) -> ImagefilterprewittRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_range_min(s : ImagefilterprewittRange) -> Double { @_common.min(s.data) }

pub fn image_filter_prewitt_range_max(s : ImagefilterprewittRange) -> Double { @_common.max(s.data) }

pub fn image_filter_prewitt_range_to_string(s : ImagefilterprewittRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_slice_make(size : Int) -> ImagefilterprewittSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_slice_len(s : ImagefilterprewittSlice) -> Int { s.size }

pub fn image_filter_prewitt_slice_get(s : ImagefilterprewittSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_slice_set(s : ImagefilterprewittSlice, i : Int, v : Double) -> ImagefilterprewittSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_slice_sum(s : ImagefilterprewittSlice) -> Double { @_common.sum(s.data) }

pub fn image_filter_prewitt_slice_mean(s : ImagefilterprewittSlice) -> Double { @_common.mean(s.data) }

pub fn image_filter_prewitt_slice_scale(s : ImagefilterprewittSlice, f : Double) -> ImagefilterprewittSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_slice_add(a : ImagefilterprewittSlice, b : ImagefilterprewittSlice) -> ImagefilterprewittSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_prewitt_slice_copy(s : ImagefilterprewittSlice) -> ImagefilterprewittSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_slice_fill(s : ImagefilterprewittSlice, v : Double) -> ImagefilterprewittSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_prewitt_slice_min(s : ImagefilterprewittSlice) -> Double { @_common.min(s.data) }

pub fn image_filter_prewitt_slice_max(s : ImagefilterprewittSlice) -> Double { @_common.max(s.data) }

pub fn image_filter_prewitt_slice_to_string(s : ImagefilterprewittSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

