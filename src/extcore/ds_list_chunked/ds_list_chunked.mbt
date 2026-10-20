///===
/// extcore/ds_list_chunked

pub(all) struct DslistchunkedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_chunked_make_point(x : Double, y : Double) -> DslistchunkedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_chunked_make_point3(x : Double, y : Double, z : Double) -> DslistchunkedPoint {
  { x, y, z, label: 0 }
}

pub fn DslistchunkedPoint::x(self : DslistchunkedPoint) -> Double { self.x }

pub fn DslistchunkedPoint::y(self : DslistchunkedPoint) -> Double { self.y }

pub fn DslistchunkedPoint::z(self : DslistchunkedPoint) -> Double { self.z }

pub fn DslistchunkedPoint::label(self : DslistchunkedPoint) -> Int { self.label }

pub fn DslistchunkedPoint::dist(self : DslistchunkedPoint, other : DslistchunkedPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistchunkedPoint::add(self : DslistchunkedPoint, other : DslistchunkedPoint) -> DslistchunkedPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistchunkedPoint::sub(self : DslistchunkedPoint, other : DslistchunkedPoint) -> DslistchunkedPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistchunkedPoint::scale(self : DslistchunkedPoint, s : Double) -> DslistchunkedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistchunkedPoint::dot(self : DslistchunkedPoint, other : DslistchunkedPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistchunkedPoint::cross(self : DslistchunkedPoint, other : DslistchunkedPoint) -> DslistchunkedPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistchunkedPoint::norm(self : DslistchunkedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistchunkedPoint::normalize(self : DslistchunkedPoint) -> DslistchunkedPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistchunkedPoint::negate(self : DslistchunkedPoint) -> DslistchunkedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistchunkedPoint::mid(self : DslistchunkedPoint, other : DslistchunkedPoint) -> DslistchunkedPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistchunkedPoint::lerp(self : DslistchunkedPoint, other : DslistchunkedPoint, t : Double) -> DslistchunkedPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistchunkedPoint::to_string(self : DslistchunkedPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistchunkedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_chunked_make_series(vals : Array[Double], name : String) -> DslistchunkedSeries {
  { vals, name, meta: 0 }
}

pub fn DslistchunkedSeries::len(self : DslistchunkedSeries) -> Int { self.vals.length() }

pub fn DslistchunkedSeries::sum(self : DslistchunkedSeries) -> Double { @_common.sum(self.vals) }

pub fn DslistchunkedSeries::mean(self : DslistchunkedSeries) -> Double { @_common.mean(self.vals) }

pub fn DslistchunkedSeries::min(self : DslistchunkedSeries) -> Double { @_common.min(self.vals) }

pub fn DslistchunkedSeries::max(self : DslistchunkedSeries) -> Double { @_common.max(self.vals) }

pub fn DslistchunkedSeries::range(self : DslistchunkedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistchunkedSeries::variance(self : DslistchunkedSeries) -> Double { @_common.variance(self.vals) }

pub fn DslistchunkedSeries::std(self : DslistchunkedSeries) -> Double { @_common.std(self.vals) }

pub fn DslistchunkedSeries::median(self : DslistchunkedSeries) -> Double { @_common.median(self.vals) }

pub fn DslistchunkedSeries::scale(self : DslistchunkedSeries, f : Double) -> DslistchunkedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistchunkedSeries::add(self : DslistchunkedSeries, other : DslistchunkedSeries) -> DslistchunkedSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistchunkedSeries::sub(self : DslistchunkedSeries, other : DslistchunkedSeries) -> DslistchunkedSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistchunkedSeries::normalize(self : DslistchunkedSeries) -> DslistchunkedSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistchunkedSeries::cumsum(self : DslistchunkedSeries) -> DslistchunkedSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistchunkedSeries::to_string(self : DslistchunkedSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistchunkedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_chunked_make_matrix(rows : Int, cols : Int, val : Double) -> DslistchunkedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_chunked_matrix_identity(n : Int) -> DslistchunkedMatrix {
  let m = ds_list_chunked_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistchunkedMatrix::get(self : DslistchunkedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistchunkedMatrix::transpose(self : DslistchunkedMatrix) -> DslistchunkedMatrix {
  let result = ds_list_chunked_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistchunkedMatrix::add(self : DslistchunkedMatrix, other : DslistchunkedMatrix) -> DslistchunkedMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_chunked_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistchunkedMatrix::scale(self : DslistchunkedMatrix, s : Double) -> DslistchunkedMatrix {
  let result = ds_list_chunked_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistchunkedMatrix::multiply(self : DslistchunkedMatrix, other : DslistchunkedMatrix) -> DslistchunkedMatrix {
  if self.cols != other.rows { return ds_list_chunked_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_chunked_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DslistchunkedMatrix::trace(self : DslistchunkedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistchunkedMatrix::det(self : DslistchunkedMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistchunkedMatrix::norm(self : DslistchunkedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistchunkedMatrix::to_string(self : DslistchunkedMatrix) -> String {
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

pub(all) struct DslistchunkedVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_chunked_make_vector(comps : Array[Double]) -> DslistchunkedVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_chunked_vector_zero(dim : Int) -> DslistchunkedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistchunkedVector::add(self : DslistchunkedVector, other : DslistchunkedVector) -> DslistchunkedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistchunkedVector::sub(self : DslistchunkedVector, other : DslistchunkedVector) -> DslistchunkedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistchunkedVector::scale(self : DslistchunkedVector, s : Double) -> DslistchunkedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistchunkedVector::dot(self : DslistchunkedVector, other : DslistchunkedVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistchunkedVector::norm(self : DslistchunkedVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistchunkedVector::normalize(self : DslistchunkedVector) -> DslistchunkedVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistchunkedVector::dist(self : DslistchunkedVector, other : DslistchunkedVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistchunkedVector::to_string(self : DslistchunkedVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_chunked_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_chunked_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_chunked_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_chunked_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_chunked_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_chunked_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_chunked_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_chunked_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_chunked_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_chunked_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_chunked_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_chunked_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_chunked_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_chunked_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_chunked_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_chunked_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_chunked_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_chunked_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_chunked_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_chunked_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_chunked_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_chunked_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_chunked_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_chunked_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_chunked_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_chunked_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_chunked_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_chunked_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_chunked_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistchunkedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_frame_make(size : Int) -> DslistchunkedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_frame_len(s : DslistchunkedFrame) -> Int { s.size }

pub fn ds_list_chunked_frame_get(s : DslistchunkedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_frame_set(s : DslistchunkedFrame, i : Int, v : Double) -> DslistchunkedFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_frame_sum(s : DslistchunkedFrame) -> Double { @_common.sum(s.data) }

pub fn ds_list_chunked_frame_mean(s : DslistchunkedFrame) -> Double { @_common.mean(s.data) }

pub fn ds_list_chunked_frame_scale(s : DslistchunkedFrame, f : Double) -> DslistchunkedFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_frame_add(a : DslistchunkedFrame, b : DslistchunkedFrame) -> DslistchunkedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_chunked_frame_copy(s : DslistchunkedFrame) -> DslistchunkedFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_frame_fill(s : DslistchunkedFrame, v : Double) -> DslistchunkedFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_frame_min(s : DslistchunkedFrame) -> Double { @_common.min(s.data) }

pub fn ds_list_chunked_frame_max(s : DslistchunkedFrame) -> Double { @_common.max(s.data) }

pub fn ds_list_chunked_frame_to_string(s : DslistchunkedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_table_make(size : Int) -> DslistchunkedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_table_len(s : DslistchunkedTable) -> Int { s.size }

pub fn ds_list_chunked_table_get(s : DslistchunkedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_table_set(s : DslistchunkedTable, i : Int, v : Double) -> DslistchunkedTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_table_sum(s : DslistchunkedTable) -> Double { @_common.sum(s.data) }

pub fn ds_list_chunked_table_mean(s : DslistchunkedTable) -> Double { @_common.mean(s.data) }

pub fn ds_list_chunked_table_scale(s : DslistchunkedTable, f : Double) -> DslistchunkedTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_table_add(a : DslistchunkedTable, b : DslistchunkedTable) -> DslistchunkedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_chunked_table_copy(s : DslistchunkedTable) -> DslistchunkedTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_table_fill(s : DslistchunkedTable, v : Double) -> DslistchunkedTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_table_min(s : DslistchunkedTable) -> Double { @_common.min(s.data) }

pub fn ds_list_chunked_table_max(s : DslistchunkedTable) -> Double { @_common.max(s.data) }

pub fn ds_list_chunked_table_to_string(s : DslistchunkedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_graphn_make(size : Int) -> DslistchunkedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_graphn_len(s : DslistchunkedGraphN) -> Int { s.size }

pub fn ds_list_chunked_graphn_get(s : DslistchunkedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_graphn_set(s : DslistchunkedGraphN, i : Int, v : Double) -> DslistchunkedGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_graphn_sum(s : DslistchunkedGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_list_chunked_graphn_mean(s : DslistchunkedGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_list_chunked_graphn_scale(s : DslistchunkedGraphN, f : Double) -> DslistchunkedGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_graphn_add(a : DslistchunkedGraphN, b : DslistchunkedGraphN) -> DslistchunkedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_chunked_graphn_copy(s : DslistchunkedGraphN) -> DslistchunkedGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_graphn_fill(s : DslistchunkedGraphN, v : Double) -> DslistchunkedGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_graphn_min(s : DslistchunkedGraphN) -> Double { @_common.min(s.data) }

pub fn ds_list_chunked_graphn_max(s : DslistchunkedGraphN) -> Double { @_common.max(s.data) }

pub fn ds_list_chunked_graphn_to_string(s : DslistchunkedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_node_make(size : Int) -> DslistchunkedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_node_len(s : DslistchunkedNode) -> Int { s.size }

pub fn ds_list_chunked_node_get(s : DslistchunkedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_node_set(s : DslistchunkedNode, i : Int, v : Double) -> DslistchunkedNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_node_sum(s : DslistchunkedNode) -> Double { @_common.sum(s.data) }

pub fn ds_list_chunked_node_mean(s : DslistchunkedNode) -> Double { @_common.mean(s.data) }

pub fn ds_list_chunked_node_scale(s : DslistchunkedNode, f : Double) -> DslistchunkedNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_node_add(a : DslistchunkedNode, b : DslistchunkedNode) -> DslistchunkedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_chunked_node_copy(s : DslistchunkedNode) -> DslistchunkedNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_node_fill(s : DslistchunkedNode, v : Double) -> DslistchunkedNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_node_min(s : DslistchunkedNode) -> Double { @_common.min(s.data) }

pub fn ds_list_chunked_node_max(s : DslistchunkedNode) -> Double { @_common.max(s.data) }

pub fn ds_list_chunked_node_to_string(s : DslistchunkedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_edge_make(size : Int) -> DslistchunkedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_edge_len(s : DslistchunkedEdge) -> Int { s.size }

pub fn ds_list_chunked_edge_get(s : DslistchunkedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_edge_set(s : DslistchunkedEdge, i : Int, v : Double) -> DslistchunkedEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_edge_sum(s : DslistchunkedEdge) -> Double { @_common.sum(s.data) }

pub fn ds_list_chunked_edge_mean(s : DslistchunkedEdge) -> Double { @_common.mean(s.data) }

pub fn ds_list_chunked_edge_scale(s : DslistchunkedEdge, f : Double) -> DslistchunkedEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_edge_add(a : DslistchunkedEdge, b : DslistchunkedEdge) -> DslistchunkedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_chunked_edge_copy(s : DslistchunkedEdge) -> DslistchunkedEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_edge_fill(s : DslistchunkedEdge, v : Double) -> DslistchunkedEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_edge_min(s : DslistchunkedEdge) -> Double { @_common.min(s.data) }

pub fn ds_list_chunked_edge_max(s : DslistchunkedEdge) -> Double { @_common.max(s.data) }

pub fn ds_list_chunked_edge_to_string(s : DslistchunkedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_path_make(size : Int) -> DslistchunkedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_path_len(s : DslistchunkedPath) -> Int { s.size }

pub fn ds_list_chunked_path_get(s : DslistchunkedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_path_set(s : DslistchunkedPath, i : Int, v : Double) -> DslistchunkedPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_path_sum(s : DslistchunkedPath) -> Double { @_common.sum(s.data) }

pub fn ds_list_chunked_path_mean(s : DslistchunkedPath) -> Double { @_common.mean(s.data) }

pub fn ds_list_chunked_path_scale(s : DslistchunkedPath, f : Double) -> DslistchunkedPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_path_add(a : DslistchunkedPath, b : DslistchunkedPath) -> DslistchunkedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_chunked_path_copy(s : DslistchunkedPath) -> DslistchunkedPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_path_fill(s : DslistchunkedPath, v : Double) -> DslistchunkedPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_path_min(s : DslistchunkedPath) -> Double { @_common.min(s.data) }

pub fn ds_list_chunked_path_max(s : DslistchunkedPath) -> Double { @_common.max(s.data) }

pub fn ds_list_chunked_path_to_string(s : DslistchunkedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_cluster_make(size : Int) -> DslistchunkedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_cluster_len(s : DslistchunkedCluster) -> Int { s.size }

pub fn ds_list_chunked_cluster_get(s : DslistchunkedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_cluster_set(s : DslistchunkedCluster, i : Int, v : Double) -> DslistchunkedCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_cluster_sum(s : DslistchunkedCluster) -> Double { @_common.sum(s.data) }

pub fn ds_list_chunked_cluster_mean(s : DslistchunkedCluster) -> Double { @_common.mean(s.data) }

pub fn ds_list_chunked_cluster_scale(s : DslistchunkedCluster, f : Double) -> DslistchunkedCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_cluster_add(a : DslistchunkedCluster, b : DslistchunkedCluster) -> DslistchunkedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_chunked_cluster_copy(s : DslistchunkedCluster) -> DslistchunkedCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_cluster_fill(s : DslistchunkedCluster, v : Double) -> DslistchunkedCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_cluster_min(s : DslistchunkedCluster) -> Double { @_common.min(s.data) }

pub fn ds_list_chunked_cluster_max(s : DslistchunkedCluster) -> Double { @_common.max(s.data) }

pub fn ds_list_chunked_cluster_to_string(s : DslistchunkedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_model_make(size : Int) -> DslistchunkedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_model_len(s : DslistchunkedModel) -> Int { s.size }

pub fn ds_list_chunked_model_get(s : DslistchunkedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_model_set(s : DslistchunkedModel, i : Int, v : Double) -> DslistchunkedModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_model_sum(s : DslistchunkedModel) -> Double { @_common.sum(s.data) }

pub fn ds_list_chunked_model_mean(s : DslistchunkedModel) -> Double { @_common.mean(s.data) }

pub fn ds_list_chunked_model_scale(s : DslistchunkedModel, f : Double) -> DslistchunkedModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_model_add(a : DslistchunkedModel, b : DslistchunkedModel) -> DslistchunkedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_chunked_model_copy(s : DslistchunkedModel) -> DslistchunkedModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_model_fill(s : DslistchunkedModel, v : Double) -> DslistchunkedModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_model_min(s : DslistchunkedModel) -> Double { @_common.min(s.data) }

pub fn ds_list_chunked_model_max(s : DslistchunkedModel) -> Double { @_common.max(s.data) }

pub fn ds_list_chunked_model_to_string(s : DslistchunkedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_layer_make(size : Int) -> DslistchunkedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_layer_len(s : DslistchunkedLayer) -> Int { s.size }

pub fn ds_list_chunked_layer_get(s : DslistchunkedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_layer_set(s : DslistchunkedLayer, i : Int, v : Double) -> DslistchunkedLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_layer_sum(s : DslistchunkedLayer) -> Double { @_common.sum(s.data) }

pub fn ds_list_chunked_layer_mean(s : DslistchunkedLayer) -> Double { @_common.mean(s.data) }

pub fn ds_list_chunked_layer_scale(s : DslistchunkedLayer, f : Double) -> DslistchunkedLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_layer_add(a : DslistchunkedLayer, b : DslistchunkedLayer) -> DslistchunkedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_chunked_layer_copy(s : DslistchunkedLayer) -> DslistchunkedLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_layer_fill(s : DslistchunkedLayer, v : Double) -> DslistchunkedLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_layer_min(s : DslistchunkedLayer) -> Double { @_common.min(s.data) }

pub fn ds_list_chunked_layer_max(s : DslistchunkedLayer) -> Double { @_common.max(s.data) }

pub fn ds_list_chunked_layer_to_string(s : DslistchunkedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_buffer_make(size : Int) -> DslistchunkedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_buffer_len(s : DslistchunkedBuffer) -> Int { s.size }

pub fn ds_list_chunked_buffer_get(s : DslistchunkedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_buffer_set(s : DslistchunkedBuffer, i : Int, v : Double) -> DslistchunkedBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_buffer_sum(s : DslistchunkedBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_list_chunked_buffer_mean(s : DslistchunkedBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_list_chunked_buffer_scale(s : DslistchunkedBuffer, f : Double) -> DslistchunkedBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_buffer_add(a : DslistchunkedBuffer, b : DslistchunkedBuffer) -> DslistchunkedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_chunked_buffer_copy(s : DslistchunkedBuffer) -> DslistchunkedBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_buffer_fill(s : DslistchunkedBuffer, v : Double) -> DslistchunkedBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_buffer_min(s : DslistchunkedBuffer) -> Double { @_common.min(s.data) }

pub fn ds_list_chunked_buffer_max(s : DslistchunkedBuffer) -> Double { @_common.max(s.data) }

pub fn ds_list_chunked_buffer_to_string(s : DslistchunkedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_cursor_make(size : Int) -> DslistchunkedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_cursor_len(s : DslistchunkedCursor) -> Int { s.size }

pub fn ds_list_chunked_cursor_get(s : DslistchunkedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_cursor_set(s : DslistchunkedCursor, i : Int, v : Double) -> DslistchunkedCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_cursor_sum(s : DslistchunkedCursor) -> Double { @_common.sum(s.data) }

pub fn ds_list_chunked_cursor_mean(s : DslistchunkedCursor) -> Double { @_common.mean(s.data) }

pub fn ds_list_chunked_cursor_scale(s : DslistchunkedCursor, f : Double) -> DslistchunkedCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_cursor_add(a : DslistchunkedCursor, b : DslistchunkedCursor) -> DslistchunkedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_chunked_cursor_copy(s : DslistchunkedCursor) -> DslistchunkedCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_cursor_fill(s : DslistchunkedCursor, v : Double) -> DslistchunkedCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_cursor_min(s : DslistchunkedCursor) -> Double { @_common.min(s.data) }

pub fn ds_list_chunked_cursor_max(s : DslistchunkedCursor) -> Double { @_common.max(s.data) }

pub fn ds_list_chunked_cursor_to_string(s : DslistchunkedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_view_make(size : Int) -> DslistchunkedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_view_len(s : DslistchunkedView) -> Int { s.size }

pub fn ds_list_chunked_view_get(s : DslistchunkedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_view_set(s : DslistchunkedView, i : Int, v : Double) -> DslistchunkedView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_view_sum(s : DslistchunkedView) -> Double { @_common.sum(s.data) }

pub fn ds_list_chunked_view_mean(s : DslistchunkedView) -> Double { @_common.mean(s.data) }

pub fn ds_list_chunked_view_scale(s : DslistchunkedView, f : Double) -> DslistchunkedView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_view_add(a : DslistchunkedView, b : DslistchunkedView) -> DslistchunkedView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_chunked_view_copy(s : DslistchunkedView) -> DslistchunkedView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_view_fill(s : DslistchunkedView, v : Double) -> DslistchunkedView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_view_min(s : DslistchunkedView) -> Double { @_common.min(s.data) }

pub fn ds_list_chunked_view_max(s : DslistchunkedView) -> Double { @_common.max(s.data) }

pub fn ds_list_chunked_view_to_string(s : DslistchunkedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_range_make(size : Int) -> DslistchunkedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_range_len(s : DslistchunkedRange) -> Int { s.size }

pub fn ds_list_chunked_range_get(s : DslistchunkedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_range_set(s : DslistchunkedRange, i : Int, v : Double) -> DslistchunkedRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_range_sum(s : DslistchunkedRange) -> Double { @_common.sum(s.data) }

pub fn ds_list_chunked_range_mean(s : DslistchunkedRange) -> Double { @_common.mean(s.data) }

pub fn ds_list_chunked_range_scale(s : DslistchunkedRange, f : Double) -> DslistchunkedRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_range_add(a : DslistchunkedRange, b : DslistchunkedRange) -> DslistchunkedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_chunked_range_copy(s : DslistchunkedRange) -> DslistchunkedRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_range_fill(s : DslistchunkedRange, v : Double) -> DslistchunkedRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_range_min(s : DslistchunkedRange) -> Double { @_common.min(s.data) }

pub fn ds_list_chunked_range_max(s : DslistchunkedRange) -> Double { @_common.max(s.data) }

pub fn ds_list_chunked_range_to_string(s : DslistchunkedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistchunkedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_slice_make(size : Int) -> DslistchunkedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_chunked_slice_len(s : DslistchunkedSlice) -> Int { s.size }

pub fn ds_list_chunked_slice_get(s : DslistchunkedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_chunked_slice_set(s : DslistchunkedSlice, i : Int, v : Double) -> DslistchunkedSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_slice_sum(s : DslistchunkedSlice) -> Double { @_common.sum(s.data) }

pub fn ds_list_chunked_slice_mean(s : DslistchunkedSlice) -> Double { @_common.mean(s.data) }

pub fn ds_list_chunked_slice_scale(s : DslistchunkedSlice, f : Double) -> DslistchunkedSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_slice_add(a : DslistchunkedSlice, b : DslistchunkedSlice) -> DslistchunkedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_chunked_slice_copy(s : DslistchunkedSlice) -> DslistchunkedSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_slice_fill(s : DslistchunkedSlice, v : Double) -> DslistchunkedSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_chunked_slice_min(s : DslistchunkedSlice) -> Double { @_common.min(s.data) }

pub fn ds_list_chunked_slice_max(s : DslistchunkedSlice) -> Double { @_common.max(s.data) }

pub fn ds_list_chunked_slice_to_string(s : DslistchunkedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

