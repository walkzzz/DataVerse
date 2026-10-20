///===
/// extcore/ds_list_unrolled

pub(all) struct DslistunrolledPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_unrolled_make_point(x : Double, y : Double) -> DslistunrolledPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_unrolled_make_point3(x : Double, y : Double, z : Double) -> DslistunrolledPoint {
  { x, y, z, label: 0 }
}

pub fn DslistunrolledPoint::x(self : DslistunrolledPoint) -> Double { self.x }

pub fn DslistunrolledPoint::y(self : DslistunrolledPoint) -> Double { self.y }

pub fn DslistunrolledPoint::z(self : DslistunrolledPoint) -> Double { self.z }

pub fn DslistunrolledPoint::label(self : DslistunrolledPoint) -> Int { self.label }

pub fn DslistunrolledPoint::dist(self : DslistunrolledPoint, other : DslistunrolledPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistunrolledPoint::add(self : DslistunrolledPoint, other : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistunrolledPoint::sub(self : DslistunrolledPoint, other : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistunrolledPoint::scale(self : DslistunrolledPoint, s : Double) -> DslistunrolledPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistunrolledPoint::dot(self : DslistunrolledPoint, other : DslistunrolledPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistunrolledPoint::cross(self : DslistunrolledPoint, other : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistunrolledPoint::norm(self : DslistunrolledPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistunrolledPoint::normalize(self : DslistunrolledPoint) -> DslistunrolledPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistunrolledPoint::negate(self : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistunrolledPoint::mid(self : DslistunrolledPoint, other : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistunrolledPoint::lerp(self : DslistunrolledPoint, other : DslistunrolledPoint, t : Double) -> DslistunrolledPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistunrolledPoint::to_string(self : DslistunrolledPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistunrolledSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_unrolled_make_series(vals : Array[Double], name : String) -> DslistunrolledSeries {
  { vals, name, meta: 0 }
}

pub fn DslistunrolledSeries::len(self : DslistunrolledSeries) -> Int { self.vals.length() }

pub fn DslistunrolledSeries::sum(self : DslistunrolledSeries) -> Double { @_common.sum(self.vals) }

pub fn DslistunrolledSeries::mean(self : DslistunrolledSeries) -> Double { @_common.mean(self.vals) }

pub fn DslistunrolledSeries::min(self : DslistunrolledSeries) -> Double { @_common.min(self.vals) }

pub fn DslistunrolledSeries::max(self : DslistunrolledSeries) -> Double { @_common.max(self.vals) }

pub fn DslistunrolledSeries::range(self : DslistunrolledSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistunrolledSeries::variance(self : DslistunrolledSeries) -> Double { @_common.variance(self.vals) }

pub fn DslistunrolledSeries::std(self : DslistunrolledSeries) -> Double { @_common.std(self.vals) }

pub fn DslistunrolledSeries::median(self : DslistunrolledSeries) -> Double { @_common.median(self.vals) }

pub fn DslistunrolledSeries::scale(self : DslistunrolledSeries, f : Double) -> DslistunrolledSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistunrolledSeries::add(self : DslistunrolledSeries, other : DslistunrolledSeries) -> DslistunrolledSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistunrolledSeries::sub(self : DslistunrolledSeries, other : DslistunrolledSeries) -> DslistunrolledSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistunrolledSeries::normalize(self : DslistunrolledSeries) -> DslistunrolledSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistunrolledSeries::cumsum(self : DslistunrolledSeries) -> DslistunrolledSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistunrolledSeries::to_string(self : DslistunrolledSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistunrolledMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_unrolled_make_matrix(rows : Int, cols : Int, val : Double) -> DslistunrolledMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_unrolled_matrix_identity(n : Int) -> DslistunrolledMatrix {
  let m = ds_list_unrolled_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistunrolledMatrix::get(self : DslistunrolledMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistunrolledMatrix::transpose(self : DslistunrolledMatrix) -> DslistunrolledMatrix {
  let result = ds_list_unrolled_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistunrolledMatrix::add(self : DslistunrolledMatrix, other : DslistunrolledMatrix) -> DslistunrolledMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_unrolled_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistunrolledMatrix::scale(self : DslistunrolledMatrix, s : Double) -> DslistunrolledMatrix {
  let result = ds_list_unrolled_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistunrolledMatrix::multiply(self : DslistunrolledMatrix, other : DslistunrolledMatrix) -> DslistunrolledMatrix {
  if self.cols != other.rows { return ds_list_unrolled_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_unrolled_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DslistunrolledMatrix::trace(self : DslistunrolledMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistunrolledMatrix::det(self : DslistunrolledMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistunrolledMatrix::norm(self : DslistunrolledMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistunrolledMatrix::to_string(self : DslistunrolledMatrix) -> String {
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

pub(all) struct DslistunrolledVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_unrolled_make_vector(comps : Array[Double]) -> DslistunrolledVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_unrolled_vector_zero(dim : Int) -> DslistunrolledVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistunrolledVector::add(self : DslistunrolledVector, other : DslistunrolledVector) -> DslistunrolledVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistunrolledVector::sub(self : DslistunrolledVector, other : DslistunrolledVector) -> DslistunrolledVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistunrolledVector::scale(self : DslistunrolledVector, s : Double) -> DslistunrolledVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistunrolledVector::dot(self : DslistunrolledVector, other : DslistunrolledVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistunrolledVector::norm(self : DslistunrolledVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistunrolledVector::normalize(self : DslistunrolledVector) -> DslistunrolledVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistunrolledVector::dist(self : DslistunrolledVector, other : DslistunrolledVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistunrolledVector::to_string(self : DslistunrolledVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_unrolled_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_unrolled_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_unrolled_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_unrolled_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_unrolled_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_unrolled_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_unrolled_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_unrolled_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_unrolled_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_unrolled_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_unrolled_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_unrolled_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_unrolled_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_unrolled_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_unrolled_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_unrolled_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_unrolled_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_unrolled_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_unrolled_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_unrolled_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_unrolled_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_unrolled_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_unrolled_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_unrolled_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_unrolled_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_unrolled_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_unrolled_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_unrolled_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_unrolled_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistunrolledFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_frame_make(size : Int) -> DslistunrolledFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_frame_len(s : DslistunrolledFrame) -> Int { s.size }

pub fn ds_list_unrolled_frame_get(s : DslistunrolledFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_frame_set(s : DslistunrolledFrame, i : Int, v : Double) -> DslistunrolledFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_frame_sum(s : DslistunrolledFrame) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_frame_mean(s : DslistunrolledFrame) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_frame_scale(s : DslistunrolledFrame, f : Double) -> DslistunrolledFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_frame_add(a : DslistunrolledFrame, b : DslistunrolledFrame) -> DslistunrolledFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_frame_copy(s : DslistunrolledFrame) -> DslistunrolledFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_frame_fill(s : DslistunrolledFrame, v : Double) -> DslistunrolledFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_frame_min(s : DslistunrolledFrame) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_frame_max(s : DslistunrolledFrame) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_frame_to_string(s : DslistunrolledFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_table_make(size : Int) -> DslistunrolledTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_table_len(s : DslistunrolledTable) -> Int { s.size }

pub fn ds_list_unrolled_table_get(s : DslistunrolledTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_table_set(s : DslistunrolledTable, i : Int, v : Double) -> DslistunrolledTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_table_sum(s : DslistunrolledTable) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_table_mean(s : DslistunrolledTable) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_table_scale(s : DslistunrolledTable, f : Double) -> DslistunrolledTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_table_add(a : DslistunrolledTable, b : DslistunrolledTable) -> DslistunrolledTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_table_copy(s : DslistunrolledTable) -> DslistunrolledTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_table_fill(s : DslistunrolledTable, v : Double) -> DslistunrolledTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_table_min(s : DslistunrolledTable) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_table_max(s : DslistunrolledTable) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_table_to_string(s : DslistunrolledTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_graphn_make(size : Int) -> DslistunrolledGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_graphn_len(s : DslistunrolledGraphN) -> Int { s.size }

pub fn ds_list_unrolled_graphn_get(s : DslistunrolledGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_graphn_set(s : DslistunrolledGraphN, i : Int, v : Double) -> DslistunrolledGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_graphn_sum(s : DslistunrolledGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_graphn_mean(s : DslistunrolledGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_graphn_scale(s : DslistunrolledGraphN, f : Double) -> DslistunrolledGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_graphn_add(a : DslistunrolledGraphN, b : DslistunrolledGraphN) -> DslistunrolledGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_graphn_copy(s : DslistunrolledGraphN) -> DslistunrolledGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_graphn_fill(s : DslistunrolledGraphN, v : Double) -> DslistunrolledGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_graphn_min(s : DslistunrolledGraphN) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_graphn_max(s : DslistunrolledGraphN) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_graphn_to_string(s : DslistunrolledGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_node_make(size : Int) -> DslistunrolledNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_node_len(s : DslistunrolledNode) -> Int { s.size }

pub fn ds_list_unrolled_node_get(s : DslistunrolledNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_node_set(s : DslistunrolledNode, i : Int, v : Double) -> DslistunrolledNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_node_sum(s : DslistunrolledNode) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_node_mean(s : DslistunrolledNode) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_node_scale(s : DslistunrolledNode, f : Double) -> DslistunrolledNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_node_add(a : DslistunrolledNode, b : DslistunrolledNode) -> DslistunrolledNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_node_copy(s : DslistunrolledNode) -> DslistunrolledNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_node_fill(s : DslistunrolledNode, v : Double) -> DslistunrolledNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_node_min(s : DslistunrolledNode) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_node_max(s : DslistunrolledNode) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_node_to_string(s : DslistunrolledNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_edge_make(size : Int) -> DslistunrolledEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_edge_len(s : DslistunrolledEdge) -> Int { s.size }

pub fn ds_list_unrolled_edge_get(s : DslistunrolledEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_edge_set(s : DslistunrolledEdge, i : Int, v : Double) -> DslistunrolledEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_edge_sum(s : DslistunrolledEdge) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_edge_mean(s : DslistunrolledEdge) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_edge_scale(s : DslistunrolledEdge, f : Double) -> DslistunrolledEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_edge_add(a : DslistunrolledEdge, b : DslistunrolledEdge) -> DslistunrolledEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_edge_copy(s : DslistunrolledEdge) -> DslistunrolledEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_edge_fill(s : DslistunrolledEdge, v : Double) -> DslistunrolledEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_edge_min(s : DslistunrolledEdge) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_edge_max(s : DslistunrolledEdge) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_edge_to_string(s : DslistunrolledEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_path_make(size : Int) -> DslistunrolledPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_path_len(s : DslistunrolledPath) -> Int { s.size }

pub fn ds_list_unrolled_path_get(s : DslistunrolledPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_path_set(s : DslistunrolledPath, i : Int, v : Double) -> DslistunrolledPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_path_sum(s : DslistunrolledPath) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_path_mean(s : DslistunrolledPath) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_path_scale(s : DslistunrolledPath, f : Double) -> DslistunrolledPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_path_add(a : DslistunrolledPath, b : DslistunrolledPath) -> DslistunrolledPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_path_copy(s : DslistunrolledPath) -> DslistunrolledPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_path_fill(s : DslistunrolledPath, v : Double) -> DslistunrolledPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_path_min(s : DslistunrolledPath) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_path_max(s : DslistunrolledPath) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_path_to_string(s : DslistunrolledPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_cluster_make(size : Int) -> DslistunrolledCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_cluster_len(s : DslistunrolledCluster) -> Int { s.size }

pub fn ds_list_unrolled_cluster_get(s : DslistunrolledCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_cluster_set(s : DslistunrolledCluster, i : Int, v : Double) -> DslistunrolledCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cluster_sum(s : DslistunrolledCluster) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_cluster_mean(s : DslistunrolledCluster) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_cluster_scale(s : DslistunrolledCluster, f : Double) -> DslistunrolledCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cluster_add(a : DslistunrolledCluster, b : DslistunrolledCluster) -> DslistunrolledCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_cluster_copy(s : DslistunrolledCluster) -> DslistunrolledCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cluster_fill(s : DslistunrolledCluster, v : Double) -> DslistunrolledCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cluster_min(s : DslistunrolledCluster) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_cluster_max(s : DslistunrolledCluster) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_cluster_to_string(s : DslistunrolledCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_model_make(size : Int) -> DslistunrolledModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_model_len(s : DslistunrolledModel) -> Int { s.size }

pub fn ds_list_unrolled_model_get(s : DslistunrolledModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_model_set(s : DslistunrolledModel, i : Int, v : Double) -> DslistunrolledModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_model_sum(s : DslistunrolledModel) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_model_mean(s : DslistunrolledModel) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_model_scale(s : DslistunrolledModel, f : Double) -> DslistunrolledModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_model_add(a : DslistunrolledModel, b : DslistunrolledModel) -> DslistunrolledModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_model_copy(s : DslistunrolledModel) -> DslistunrolledModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_model_fill(s : DslistunrolledModel, v : Double) -> DslistunrolledModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_model_min(s : DslistunrolledModel) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_model_max(s : DslistunrolledModel) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_model_to_string(s : DslistunrolledModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_layer_make(size : Int) -> DslistunrolledLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_layer_len(s : DslistunrolledLayer) -> Int { s.size }

pub fn ds_list_unrolled_layer_get(s : DslistunrolledLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_layer_set(s : DslistunrolledLayer, i : Int, v : Double) -> DslistunrolledLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_layer_sum(s : DslistunrolledLayer) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_layer_mean(s : DslistunrolledLayer) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_layer_scale(s : DslistunrolledLayer, f : Double) -> DslistunrolledLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_layer_add(a : DslistunrolledLayer, b : DslistunrolledLayer) -> DslistunrolledLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_layer_copy(s : DslistunrolledLayer) -> DslistunrolledLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_layer_fill(s : DslistunrolledLayer, v : Double) -> DslistunrolledLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_layer_min(s : DslistunrolledLayer) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_layer_max(s : DslistunrolledLayer) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_layer_to_string(s : DslistunrolledLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_buffer_make(size : Int) -> DslistunrolledBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_buffer_len(s : DslistunrolledBuffer) -> Int { s.size }

pub fn ds_list_unrolled_buffer_get(s : DslistunrolledBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_buffer_set(s : DslistunrolledBuffer, i : Int, v : Double) -> DslistunrolledBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_buffer_sum(s : DslistunrolledBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_buffer_mean(s : DslistunrolledBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_buffer_scale(s : DslistunrolledBuffer, f : Double) -> DslistunrolledBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_buffer_add(a : DslistunrolledBuffer, b : DslistunrolledBuffer) -> DslistunrolledBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_buffer_copy(s : DslistunrolledBuffer) -> DslistunrolledBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_buffer_fill(s : DslistunrolledBuffer, v : Double) -> DslistunrolledBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_buffer_min(s : DslistunrolledBuffer) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_buffer_max(s : DslistunrolledBuffer) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_buffer_to_string(s : DslistunrolledBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_cursor_make(size : Int) -> DslistunrolledCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_cursor_len(s : DslistunrolledCursor) -> Int { s.size }

pub fn ds_list_unrolled_cursor_get(s : DslistunrolledCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_cursor_set(s : DslistunrolledCursor, i : Int, v : Double) -> DslistunrolledCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cursor_sum(s : DslistunrolledCursor) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_cursor_mean(s : DslistunrolledCursor) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_cursor_scale(s : DslistunrolledCursor, f : Double) -> DslistunrolledCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cursor_add(a : DslistunrolledCursor, b : DslistunrolledCursor) -> DslistunrolledCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_cursor_copy(s : DslistunrolledCursor) -> DslistunrolledCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cursor_fill(s : DslistunrolledCursor, v : Double) -> DslistunrolledCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_cursor_min(s : DslistunrolledCursor) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_cursor_max(s : DslistunrolledCursor) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_cursor_to_string(s : DslistunrolledCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_view_make(size : Int) -> DslistunrolledView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_view_len(s : DslistunrolledView) -> Int { s.size }

pub fn ds_list_unrolled_view_get(s : DslistunrolledView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_view_set(s : DslistunrolledView, i : Int, v : Double) -> DslistunrolledView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_view_sum(s : DslistunrolledView) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_view_mean(s : DslistunrolledView) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_view_scale(s : DslistunrolledView, f : Double) -> DslistunrolledView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_view_add(a : DslistunrolledView, b : DslistunrolledView) -> DslistunrolledView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_view_copy(s : DslistunrolledView) -> DslistunrolledView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_view_fill(s : DslistunrolledView, v : Double) -> DslistunrolledView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_view_min(s : DslistunrolledView) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_view_max(s : DslistunrolledView) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_view_to_string(s : DslistunrolledView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_range_make(size : Int) -> DslistunrolledRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_range_len(s : DslistunrolledRange) -> Int { s.size }

pub fn ds_list_unrolled_range_get(s : DslistunrolledRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_range_set(s : DslistunrolledRange, i : Int, v : Double) -> DslistunrolledRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_range_sum(s : DslistunrolledRange) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_range_mean(s : DslistunrolledRange) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_range_scale(s : DslistunrolledRange, f : Double) -> DslistunrolledRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_range_add(a : DslistunrolledRange, b : DslistunrolledRange) -> DslistunrolledRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_range_copy(s : DslistunrolledRange) -> DslistunrolledRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_range_fill(s : DslistunrolledRange, v : Double) -> DslistunrolledRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_range_min(s : DslistunrolledRange) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_range_max(s : DslistunrolledRange) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_range_to_string(s : DslistunrolledRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_slice_make(size : Int) -> DslistunrolledSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_slice_len(s : DslistunrolledSlice) -> Int { s.size }

pub fn ds_list_unrolled_slice_get(s : DslistunrolledSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_slice_set(s : DslistunrolledSlice, i : Int, v : Double) -> DslistunrolledSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_slice_sum(s : DslistunrolledSlice) -> Double { @_common.sum(s.data) }

pub fn ds_list_unrolled_slice_mean(s : DslistunrolledSlice) -> Double { @_common.mean(s.data) }

pub fn ds_list_unrolled_slice_scale(s : DslistunrolledSlice, f : Double) -> DslistunrolledSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_slice_add(a : DslistunrolledSlice, b : DslistunrolledSlice) -> DslistunrolledSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_unrolled_slice_copy(s : DslistunrolledSlice) -> DslistunrolledSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_slice_fill(s : DslistunrolledSlice, v : Double) -> DslistunrolledSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_unrolled_slice_min(s : DslistunrolledSlice) -> Double { @_common.min(s.data) }

pub fn ds_list_unrolled_slice_max(s : DslistunrolledSlice) -> Double { @_common.max(s.data) }

pub fn ds_list_unrolled_slice_to_string(s : DslistunrolledSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

