///===
/// extcore/signal_transform_wigner

pub(all) struct SignaltransformwignerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_wigner_make_point(x : Double, y : Double) -> SignaltransformwignerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_wigner_make_point3(x : Double, y : Double, z : Double) -> SignaltransformwignerPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformwignerPoint::x(self : SignaltransformwignerPoint) -> Double { self.x }

pub fn SignaltransformwignerPoint::y(self : SignaltransformwignerPoint) -> Double { self.y }

pub fn SignaltransformwignerPoint::z(self : SignaltransformwignerPoint) -> Double { self.z }

pub fn SignaltransformwignerPoint::label(self : SignaltransformwignerPoint) -> Int { self.label }

pub fn SignaltransformwignerPoint::dist(self : SignaltransformwignerPoint, other : SignaltransformwignerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformwignerPoint::add(self : SignaltransformwignerPoint, other : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformwignerPoint::sub(self : SignaltransformwignerPoint, other : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformwignerPoint::scale(self : SignaltransformwignerPoint, s : Double) -> SignaltransformwignerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformwignerPoint::dot(self : SignaltransformwignerPoint, other : SignaltransformwignerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformwignerPoint::cross(self : SignaltransformwignerPoint, other : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformwignerPoint::norm(self : SignaltransformwignerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformwignerPoint::normalize(self : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformwignerPoint::negate(self : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformwignerPoint::mid(self : SignaltransformwignerPoint, other : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformwignerPoint::lerp(self : SignaltransformwignerPoint, other : SignaltransformwignerPoint, t : Double) -> SignaltransformwignerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformwignerPoint::to_string(self : SignaltransformwignerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformwignerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_wigner_make_series(vals : Array[Double], name : String) -> SignaltransformwignerSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformwignerSeries::len(self : SignaltransformwignerSeries) -> Int { self.vals.length() }

pub fn SignaltransformwignerSeries::sum(self : SignaltransformwignerSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformwignerSeries::mean(self : SignaltransformwignerSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformwignerSeries::min(self : SignaltransformwignerSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformwignerSeries::max(self : SignaltransformwignerSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformwignerSeries::range(self : SignaltransformwignerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformwignerSeries::variance(self : SignaltransformwignerSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformwignerSeries::std(self : SignaltransformwignerSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformwignerSeries::median(self : SignaltransformwignerSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformwignerSeries::scale(self : SignaltransformwignerSeries, f : Double) -> SignaltransformwignerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformwignerSeries::add(self : SignaltransformwignerSeries, other : SignaltransformwignerSeries) -> SignaltransformwignerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformwignerSeries::sub(self : SignaltransformwignerSeries, other : SignaltransformwignerSeries) -> SignaltransformwignerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformwignerSeries::normalize(self : SignaltransformwignerSeries) -> SignaltransformwignerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformwignerSeries::cumsum(self : SignaltransformwignerSeries) -> SignaltransformwignerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformwignerSeries::to_string(self : SignaltransformwignerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformwignerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_wigner_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformwignerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_wigner_matrix_identity(n : Int) -> SignaltransformwignerMatrix {
  let m = signal_transform_wigner_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformwignerMatrix::get(self : SignaltransformwignerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformwignerMatrix::transpose(self : SignaltransformwignerMatrix) -> SignaltransformwignerMatrix {
  let result = signal_transform_wigner_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformwignerMatrix::add(self : SignaltransformwignerMatrix, other : SignaltransformwignerMatrix) -> SignaltransformwignerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_wigner_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformwignerMatrix::scale(self : SignaltransformwignerMatrix, s : Double) -> SignaltransformwignerMatrix {
  let result = signal_transform_wigner_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformwignerMatrix::multiply(self : SignaltransformwignerMatrix, other : SignaltransformwignerMatrix) -> SignaltransformwignerMatrix {
  if self.cols != other.rows { return signal_transform_wigner_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_wigner_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformwignerMatrix::trace(self : SignaltransformwignerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformwignerMatrix::det(self : SignaltransformwignerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformwignerMatrix::norm(self : SignaltransformwignerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformwignerMatrix::to_string(self : SignaltransformwignerMatrix) -> String {
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

pub(all) struct SignaltransformwignerVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_wigner_make_vector(comps : Array[Double]) -> SignaltransformwignerVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_wigner_vector_zero(dim : Int) -> SignaltransformwignerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformwignerVector::add(self : SignaltransformwignerVector, other : SignaltransformwignerVector) -> SignaltransformwignerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformwignerVector::sub(self : SignaltransformwignerVector, other : SignaltransformwignerVector) -> SignaltransformwignerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformwignerVector::scale(self : SignaltransformwignerVector, s : Double) -> SignaltransformwignerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformwignerVector::dot(self : SignaltransformwignerVector, other : SignaltransformwignerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformwignerVector::norm(self : SignaltransformwignerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformwignerVector::normalize(self : SignaltransformwignerVector) -> SignaltransformwignerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformwignerVector::dist(self : SignaltransformwignerVector, other : SignaltransformwignerVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformwignerVector::to_string(self : SignaltransformwignerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_wigner_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_wigner_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_wigner_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_wigner_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_wigner_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_wigner_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_wigner_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_wigner_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_wigner_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_wigner_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_wigner_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_wigner_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_wigner_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_wigner_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_wigner_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_wigner_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_wigner_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_wigner_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_wigner_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_wigner_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_wigner_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_wigner_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_wigner_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_wigner_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_wigner_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_wigner_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_wigner_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_wigner_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_wigner_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformwignerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_frame_make(size : Int) -> SignaltransformwignerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_frame_len(s : SignaltransformwignerFrame) -> Int { s.size }

pub fn signal_transform_wigner_frame_get(s : SignaltransformwignerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_frame_set(s : SignaltransformwignerFrame, i : Int, v : Double) -> SignaltransformwignerFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_frame_sum(s : SignaltransformwignerFrame) -> Double { @_common.sum(s.data) }

pub fn signal_transform_wigner_frame_mean(s : SignaltransformwignerFrame) -> Double { @_common.mean(s.data) }

pub fn signal_transform_wigner_frame_scale(s : SignaltransformwignerFrame, f : Double) -> SignaltransformwignerFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_frame_add(a : SignaltransformwignerFrame, b : SignaltransformwignerFrame) -> SignaltransformwignerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_wigner_frame_copy(s : SignaltransformwignerFrame) -> SignaltransformwignerFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_frame_fill(s : SignaltransformwignerFrame, v : Double) -> SignaltransformwignerFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_frame_min(s : SignaltransformwignerFrame) -> Double { @_common.min(s.data) }

pub fn signal_transform_wigner_frame_max(s : SignaltransformwignerFrame) -> Double { @_common.max(s.data) }

pub fn signal_transform_wigner_frame_to_string(s : SignaltransformwignerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_table_make(size : Int) -> SignaltransformwignerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_table_len(s : SignaltransformwignerTable) -> Int { s.size }

pub fn signal_transform_wigner_table_get(s : SignaltransformwignerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_table_set(s : SignaltransformwignerTable, i : Int, v : Double) -> SignaltransformwignerTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_table_sum(s : SignaltransformwignerTable) -> Double { @_common.sum(s.data) }

pub fn signal_transform_wigner_table_mean(s : SignaltransformwignerTable) -> Double { @_common.mean(s.data) }

pub fn signal_transform_wigner_table_scale(s : SignaltransformwignerTable, f : Double) -> SignaltransformwignerTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_table_add(a : SignaltransformwignerTable, b : SignaltransformwignerTable) -> SignaltransformwignerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_wigner_table_copy(s : SignaltransformwignerTable) -> SignaltransformwignerTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_table_fill(s : SignaltransformwignerTable, v : Double) -> SignaltransformwignerTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_table_min(s : SignaltransformwignerTable) -> Double { @_common.min(s.data) }

pub fn signal_transform_wigner_table_max(s : SignaltransformwignerTable) -> Double { @_common.max(s.data) }

pub fn signal_transform_wigner_table_to_string(s : SignaltransformwignerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_graphn_make(size : Int) -> SignaltransformwignerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_graphn_len(s : SignaltransformwignerGraphN) -> Int { s.size }

pub fn signal_transform_wigner_graphn_get(s : SignaltransformwignerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_graphn_set(s : SignaltransformwignerGraphN, i : Int, v : Double) -> SignaltransformwignerGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_graphn_sum(s : SignaltransformwignerGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_transform_wigner_graphn_mean(s : SignaltransformwignerGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_transform_wigner_graphn_scale(s : SignaltransformwignerGraphN, f : Double) -> SignaltransformwignerGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_graphn_add(a : SignaltransformwignerGraphN, b : SignaltransformwignerGraphN) -> SignaltransformwignerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_wigner_graphn_copy(s : SignaltransformwignerGraphN) -> SignaltransformwignerGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_graphn_fill(s : SignaltransformwignerGraphN, v : Double) -> SignaltransformwignerGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_graphn_min(s : SignaltransformwignerGraphN) -> Double { @_common.min(s.data) }

pub fn signal_transform_wigner_graphn_max(s : SignaltransformwignerGraphN) -> Double { @_common.max(s.data) }

pub fn signal_transform_wigner_graphn_to_string(s : SignaltransformwignerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_node_make(size : Int) -> SignaltransformwignerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_node_len(s : SignaltransformwignerNode) -> Int { s.size }

pub fn signal_transform_wigner_node_get(s : SignaltransformwignerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_node_set(s : SignaltransformwignerNode, i : Int, v : Double) -> SignaltransformwignerNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_node_sum(s : SignaltransformwignerNode) -> Double { @_common.sum(s.data) }

pub fn signal_transform_wigner_node_mean(s : SignaltransformwignerNode) -> Double { @_common.mean(s.data) }

pub fn signal_transform_wigner_node_scale(s : SignaltransformwignerNode, f : Double) -> SignaltransformwignerNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_node_add(a : SignaltransformwignerNode, b : SignaltransformwignerNode) -> SignaltransformwignerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_wigner_node_copy(s : SignaltransformwignerNode) -> SignaltransformwignerNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_node_fill(s : SignaltransformwignerNode, v : Double) -> SignaltransformwignerNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_node_min(s : SignaltransformwignerNode) -> Double { @_common.min(s.data) }

pub fn signal_transform_wigner_node_max(s : SignaltransformwignerNode) -> Double { @_common.max(s.data) }

pub fn signal_transform_wigner_node_to_string(s : SignaltransformwignerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_edge_make(size : Int) -> SignaltransformwignerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_edge_len(s : SignaltransformwignerEdge) -> Int { s.size }

pub fn signal_transform_wigner_edge_get(s : SignaltransformwignerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_edge_set(s : SignaltransformwignerEdge, i : Int, v : Double) -> SignaltransformwignerEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_edge_sum(s : SignaltransformwignerEdge) -> Double { @_common.sum(s.data) }

pub fn signal_transform_wigner_edge_mean(s : SignaltransformwignerEdge) -> Double { @_common.mean(s.data) }

pub fn signal_transform_wigner_edge_scale(s : SignaltransformwignerEdge, f : Double) -> SignaltransformwignerEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_edge_add(a : SignaltransformwignerEdge, b : SignaltransformwignerEdge) -> SignaltransformwignerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_wigner_edge_copy(s : SignaltransformwignerEdge) -> SignaltransformwignerEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_edge_fill(s : SignaltransformwignerEdge, v : Double) -> SignaltransformwignerEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_edge_min(s : SignaltransformwignerEdge) -> Double { @_common.min(s.data) }

pub fn signal_transform_wigner_edge_max(s : SignaltransformwignerEdge) -> Double { @_common.max(s.data) }

pub fn signal_transform_wigner_edge_to_string(s : SignaltransformwignerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_path_make(size : Int) -> SignaltransformwignerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_path_len(s : SignaltransformwignerPath) -> Int { s.size }

pub fn signal_transform_wigner_path_get(s : SignaltransformwignerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_path_set(s : SignaltransformwignerPath, i : Int, v : Double) -> SignaltransformwignerPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_path_sum(s : SignaltransformwignerPath) -> Double { @_common.sum(s.data) }

pub fn signal_transform_wigner_path_mean(s : SignaltransformwignerPath) -> Double { @_common.mean(s.data) }

pub fn signal_transform_wigner_path_scale(s : SignaltransformwignerPath, f : Double) -> SignaltransformwignerPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_path_add(a : SignaltransformwignerPath, b : SignaltransformwignerPath) -> SignaltransformwignerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_wigner_path_copy(s : SignaltransformwignerPath) -> SignaltransformwignerPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_path_fill(s : SignaltransformwignerPath, v : Double) -> SignaltransformwignerPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_path_min(s : SignaltransformwignerPath) -> Double { @_common.min(s.data) }

pub fn signal_transform_wigner_path_max(s : SignaltransformwignerPath) -> Double { @_common.max(s.data) }

pub fn signal_transform_wigner_path_to_string(s : SignaltransformwignerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_cluster_make(size : Int) -> SignaltransformwignerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_cluster_len(s : SignaltransformwignerCluster) -> Int { s.size }

pub fn signal_transform_wigner_cluster_get(s : SignaltransformwignerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_cluster_set(s : SignaltransformwignerCluster, i : Int, v : Double) -> SignaltransformwignerCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_cluster_sum(s : SignaltransformwignerCluster) -> Double { @_common.sum(s.data) }

pub fn signal_transform_wigner_cluster_mean(s : SignaltransformwignerCluster) -> Double { @_common.mean(s.data) }

pub fn signal_transform_wigner_cluster_scale(s : SignaltransformwignerCluster, f : Double) -> SignaltransformwignerCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_cluster_add(a : SignaltransformwignerCluster, b : SignaltransformwignerCluster) -> SignaltransformwignerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_wigner_cluster_copy(s : SignaltransformwignerCluster) -> SignaltransformwignerCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_cluster_fill(s : SignaltransformwignerCluster, v : Double) -> SignaltransformwignerCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_cluster_min(s : SignaltransformwignerCluster) -> Double { @_common.min(s.data) }

pub fn signal_transform_wigner_cluster_max(s : SignaltransformwignerCluster) -> Double { @_common.max(s.data) }

pub fn signal_transform_wigner_cluster_to_string(s : SignaltransformwignerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_model_make(size : Int) -> SignaltransformwignerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_model_len(s : SignaltransformwignerModel) -> Int { s.size }

pub fn signal_transform_wigner_model_get(s : SignaltransformwignerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_model_set(s : SignaltransformwignerModel, i : Int, v : Double) -> SignaltransformwignerModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_model_sum(s : SignaltransformwignerModel) -> Double { @_common.sum(s.data) }

pub fn signal_transform_wigner_model_mean(s : SignaltransformwignerModel) -> Double { @_common.mean(s.data) }

pub fn signal_transform_wigner_model_scale(s : SignaltransformwignerModel, f : Double) -> SignaltransformwignerModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_model_add(a : SignaltransformwignerModel, b : SignaltransformwignerModel) -> SignaltransformwignerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_wigner_model_copy(s : SignaltransformwignerModel) -> SignaltransformwignerModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_model_fill(s : SignaltransformwignerModel, v : Double) -> SignaltransformwignerModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_model_min(s : SignaltransformwignerModel) -> Double { @_common.min(s.data) }

pub fn signal_transform_wigner_model_max(s : SignaltransformwignerModel) -> Double { @_common.max(s.data) }

pub fn signal_transform_wigner_model_to_string(s : SignaltransformwignerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_layer_make(size : Int) -> SignaltransformwignerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_layer_len(s : SignaltransformwignerLayer) -> Int { s.size }

pub fn signal_transform_wigner_layer_get(s : SignaltransformwignerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_layer_set(s : SignaltransformwignerLayer, i : Int, v : Double) -> SignaltransformwignerLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_layer_sum(s : SignaltransformwignerLayer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_wigner_layer_mean(s : SignaltransformwignerLayer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_wigner_layer_scale(s : SignaltransformwignerLayer, f : Double) -> SignaltransformwignerLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_layer_add(a : SignaltransformwignerLayer, b : SignaltransformwignerLayer) -> SignaltransformwignerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_wigner_layer_copy(s : SignaltransformwignerLayer) -> SignaltransformwignerLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_layer_fill(s : SignaltransformwignerLayer, v : Double) -> SignaltransformwignerLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_layer_min(s : SignaltransformwignerLayer) -> Double { @_common.min(s.data) }

pub fn signal_transform_wigner_layer_max(s : SignaltransformwignerLayer) -> Double { @_common.max(s.data) }

pub fn signal_transform_wigner_layer_to_string(s : SignaltransformwignerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_buffer_make(size : Int) -> SignaltransformwignerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_buffer_len(s : SignaltransformwignerBuffer) -> Int { s.size }

pub fn signal_transform_wigner_buffer_get(s : SignaltransformwignerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_buffer_set(s : SignaltransformwignerBuffer, i : Int, v : Double) -> SignaltransformwignerBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_buffer_sum(s : SignaltransformwignerBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_wigner_buffer_mean(s : SignaltransformwignerBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_wigner_buffer_scale(s : SignaltransformwignerBuffer, f : Double) -> SignaltransformwignerBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_buffer_add(a : SignaltransformwignerBuffer, b : SignaltransformwignerBuffer) -> SignaltransformwignerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_wigner_buffer_copy(s : SignaltransformwignerBuffer) -> SignaltransformwignerBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_buffer_fill(s : SignaltransformwignerBuffer, v : Double) -> SignaltransformwignerBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_buffer_min(s : SignaltransformwignerBuffer) -> Double { @_common.min(s.data) }

pub fn signal_transform_wigner_buffer_max(s : SignaltransformwignerBuffer) -> Double { @_common.max(s.data) }

pub fn signal_transform_wigner_buffer_to_string(s : SignaltransformwignerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_cursor_make(size : Int) -> SignaltransformwignerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_cursor_len(s : SignaltransformwignerCursor) -> Int { s.size }

pub fn signal_transform_wigner_cursor_get(s : SignaltransformwignerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_cursor_set(s : SignaltransformwignerCursor, i : Int, v : Double) -> SignaltransformwignerCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_cursor_sum(s : SignaltransformwignerCursor) -> Double { @_common.sum(s.data) }

pub fn signal_transform_wigner_cursor_mean(s : SignaltransformwignerCursor) -> Double { @_common.mean(s.data) }

pub fn signal_transform_wigner_cursor_scale(s : SignaltransformwignerCursor, f : Double) -> SignaltransformwignerCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_cursor_add(a : SignaltransformwignerCursor, b : SignaltransformwignerCursor) -> SignaltransformwignerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_wigner_cursor_copy(s : SignaltransformwignerCursor) -> SignaltransformwignerCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_cursor_fill(s : SignaltransformwignerCursor, v : Double) -> SignaltransformwignerCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_cursor_min(s : SignaltransformwignerCursor) -> Double { @_common.min(s.data) }

pub fn signal_transform_wigner_cursor_max(s : SignaltransformwignerCursor) -> Double { @_common.max(s.data) }

pub fn signal_transform_wigner_cursor_to_string(s : SignaltransformwignerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_view_make(size : Int) -> SignaltransformwignerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_view_len(s : SignaltransformwignerView) -> Int { s.size }

pub fn signal_transform_wigner_view_get(s : SignaltransformwignerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_view_set(s : SignaltransformwignerView, i : Int, v : Double) -> SignaltransformwignerView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_view_sum(s : SignaltransformwignerView) -> Double { @_common.sum(s.data) }

pub fn signal_transform_wigner_view_mean(s : SignaltransformwignerView) -> Double { @_common.mean(s.data) }

pub fn signal_transform_wigner_view_scale(s : SignaltransformwignerView, f : Double) -> SignaltransformwignerView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_view_add(a : SignaltransformwignerView, b : SignaltransformwignerView) -> SignaltransformwignerView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_wigner_view_copy(s : SignaltransformwignerView) -> SignaltransformwignerView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_view_fill(s : SignaltransformwignerView, v : Double) -> SignaltransformwignerView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_view_min(s : SignaltransformwignerView) -> Double { @_common.min(s.data) }

pub fn signal_transform_wigner_view_max(s : SignaltransformwignerView) -> Double { @_common.max(s.data) }

pub fn signal_transform_wigner_view_to_string(s : SignaltransformwignerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_range_make(size : Int) -> SignaltransformwignerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_range_len(s : SignaltransformwignerRange) -> Int { s.size }

pub fn signal_transform_wigner_range_get(s : SignaltransformwignerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_range_set(s : SignaltransformwignerRange, i : Int, v : Double) -> SignaltransformwignerRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_range_sum(s : SignaltransformwignerRange) -> Double { @_common.sum(s.data) }

pub fn signal_transform_wigner_range_mean(s : SignaltransformwignerRange) -> Double { @_common.mean(s.data) }

pub fn signal_transform_wigner_range_scale(s : SignaltransformwignerRange, f : Double) -> SignaltransformwignerRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_range_add(a : SignaltransformwignerRange, b : SignaltransformwignerRange) -> SignaltransformwignerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_wigner_range_copy(s : SignaltransformwignerRange) -> SignaltransformwignerRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_range_fill(s : SignaltransformwignerRange, v : Double) -> SignaltransformwignerRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_range_min(s : SignaltransformwignerRange) -> Double { @_common.min(s.data) }

pub fn signal_transform_wigner_range_max(s : SignaltransformwignerRange) -> Double { @_common.max(s.data) }

pub fn signal_transform_wigner_range_to_string(s : SignaltransformwignerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_slice_make(size : Int) -> SignaltransformwignerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_slice_len(s : SignaltransformwignerSlice) -> Int { s.size }

pub fn signal_transform_wigner_slice_get(s : SignaltransformwignerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_slice_set(s : SignaltransformwignerSlice, i : Int, v : Double) -> SignaltransformwignerSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_slice_sum(s : SignaltransformwignerSlice) -> Double { @_common.sum(s.data) }

pub fn signal_transform_wigner_slice_mean(s : SignaltransformwignerSlice) -> Double { @_common.mean(s.data) }

pub fn signal_transform_wigner_slice_scale(s : SignaltransformwignerSlice, f : Double) -> SignaltransformwignerSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_slice_add(a : SignaltransformwignerSlice, b : SignaltransformwignerSlice) -> SignaltransformwignerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_wigner_slice_copy(s : SignaltransformwignerSlice) -> SignaltransformwignerSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_slice_fill(s : SignaltransformwignerSlice, v : Double) -> SignaltransformwignerSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_wigner_slice_min(s : SignaltransformwignerSlice) -> Double { @_common.min(s.data) }

pub fn signal_transform_wigner_slice_max(s : SignaltransformwignerSlice) -> Double { @_common.max(s.data) }

pub fn signal_transform_wigner_slice_to_string(s : SignaltransformwignerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

