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

pub fn DslistchunkedFrame::len(self : DslistchunkedFrame) -> Int { self.size }

pub fn DslistchunkedFrame::get(self : DslistchunkedFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistchunkedFrame::set(self : DslistchunkedFrame, i : Int, v : Double) -> DslistchunkedFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistchunkedFrame::sum(self : DslistchunkedFrame) -> Double { @_common.sum(self.data) }

pub fn DslistchunkedFrame::mean(self : DslistchunkedFrame) -> Double { @_common.mean(self.data) }

pub fn DslistchunkedFrame::scale(self : DslistchunkedFrame, f : Double) -> DslistchunkedFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistchunkedFrame::add(self : DslistchunkedFrame, other : DslistchunkedFrame) -> DslistchunkedFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistchunkedFrame::copy(self : DslistchunkedFrame) -> DslistchunkedFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistchunkedFrame::fill(self : DslistchunkedFrame, v : Double) -> DslistchunkedFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistchunkedFrame::min(self : DslistchunkedFrame) -> Double { @_common.min(self.data) }

pub fn DslistchunkedFrame::max(self : DslistchunkedFrame) -> Double { @_common.max(self.data) }

pub fn DslistchunkedFrame::to_string(self : DslistchunkedFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistchunkedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_table_make(size : Int) -> DslistchunkedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistchunkedTable::len(self : DslistchunkedTable) -> Int { self.size }

pub fn DslistchunkedTable::get(self : DslistchunkedTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistchunkedTable::set(self : DslistchunkedTable, i : Int, v : Double) -> DslistchunkedTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistchunkedTable::sum(self : DslistchunkedTable) -> Double { @_common.sum(self.data) }

pub fn DslistchunkedTable::mean(self : DslistchunkedTable) -> Double { @_common.mean(self.data) }

pub fn DslistchunkedTable::scale(self : DslistchunkedTable, f : Double) -> DslistchunkedTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistchunkedTable::add(self : DslistchunkedTable, other : DslistchunkedTable) -> DslistchunkedTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistchunkedTable::copy(self : DslistchunkedTable) -> DslistchunkedTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistchunkedTable::fill(self : DslistchunkedTable, v : Double) -> DslistchunkedTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistchunkedTable::min(self : DslistchunkedTable) -> Double { @_common.min(self.data) }

pub fn DslistchunkedTable::max(self : DslistchunkedTable) -> Double { @_common.max(self.data) }

pub fn DslistchunkedTable::to_string(self : DslistchunkedTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistchunkedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_graphn_make(size : Int) -> DslistchunkedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistchunkedGraphN::len(self : DslistchunkedGraphN) -> Int { self.size }

pub fn DslistchunkedGraphN::get(self : DslistchunkedGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistchunkedGraphN::set(self : DslistchunkedGraphN, i : Int, v : Double) -> DslistchunkedGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistchunkedGraphN::sum(self : DslistchunkedGraphN) -> Double { @_common.sum(self.data) }

pub fn DslistchunkedGraphN::mean(self : DslistchunkedGraphN) -> Double { @_common.mean(self.data) }

pub fn DslistchunkedGraphN::scale(self : DslistchunkedGraphN, f : Double) -> DslistchunkedGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistchunkedGraphN::add(self : DslistchunkedGraphN, other : DslistchunkedGraphN) -> DslistchunkedGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistchunkedGraphN::copy(self : DslistchunkedGraphN) -> DslistchunkedGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistchunkedGraphN::fill(self : DslistchunkedGraphN, v : Double) -> DslistchunkedGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistchunkedGraphN::min(self : DslistchunkedGraphN) -> Double { @_common.min(self.data) }

pub fn DslistchunkedGraphN::max(self : DslistchunkedGraphN) -> Double { @_common.max(self.data) }

pub fn DslistchunkedGraphN::to_string(self : DslistchunkedGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistchunkedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_node_make(size : Int) -> DslistchunkedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistchunkedNode::len(self : DslistchunkedNode) -> Int { self.size }

pub fn DslistchunkedNode::get(self : DslistchunkedNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistchunkedNode::set(self : DslistchunkedNode, i : Int, v : Double) -> DslistchunkedNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistchunkedNode::sum(self : DslistchunkedNode) -> Double { @_common.sum(self.data) }

pub fn DslistchunkedNode::mean(self : DslistchunkedNode) -> Double { @_common.mean(self.data) }

pub fn DslistchunkedNode::scale(self : DslistchunkedNode, f : Double) -> DslistchunkedNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistchunkedNode::add(self : DslistchunkedNode, other : DslistchunkedNode) -> DslistchunkedNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistchunkedNode::copy(self : DslistchunkedNode) -> DslistchunkedNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistchunkedNode::fill(self : DslistchunkedNode, v : Double) -> DslistchunkedNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistchunkedNode::min(self : DslistchunkedNode) -> Double { @_common.min(self.data) }

pub fn DslistchunkedNode::max(self : DslistchunkedNode) -> Double { @_common.max(self.data) }

pub fn DslistchunkedNode::to_string(self : DslistchunkedNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistchunkedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_edge_make(size : Int) -> DslistchunkedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistchunkedEdge::len(self : DslistchunkedEdge) -> Int { self.size }

pub fn DslistchunkedEdge::get(self : DslistchunkedEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistchunkedEdge::set(self : DslistchunkedEdge, i : Int, v : Double) -> DslistchunkedEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistchunkedEdge::sum(self : DslistchunkedEdge) -> Double { @_common.sum(self.data) }

pub fn DslistchunkedEdge::mean(self : DslistchunkedEdge) -> Double { @_common.mean(self.data) }

pub fn DslistchunkedEdge::scale(self : DslistchunkedEdge, f : Double) -> DslistchunkedEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistchunkedEdge::add(self : DslistchunkedEdge, other : DslistchunkedEdge) -> DslistchunkedEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistchunkedEdge::copy(self : DslistchunkedEdge) -> DslistchunkedEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistchunkedEdge::fill(self : DslistchunkedEdge, v : Double) -> DslistchunkedEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistchunkedEdge::min(self : DslistchunkedEdge) -> Double { @_common.min(self.data) }

pub fn DslistchunkedEdge::max(self : DslistchunkedEdge) -> Double { @_common.max(self.data) }

pub fn DslistchunkedEdge::to_string(self : DslistchunkedEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistchunkedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_path_make(size : Int) -> DslistchunkedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistchunkedPath::len(self : DslistchunkedPath) -> Int { self.size }

pub fn DslistchunkedPath::get(self : DslistchunkedPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistchunkedPath::set(self : DslistchunkedPath, i : Int, v : Double) -> DslistchunkedPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistchunkedPath::sum(self : DslistchunkedPath) -> Double { @_common.sum(self.data) }

pub fn DslistchunkedPath::mean(self : DslistchunkedPath) -> Double { @_common.mean(self.data) }

pub fn DslistchunkedPath::scale(self : DslistchunkedPath, f : Double) -> DslistchunkedPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistchunkedPath::add(self : DslistchunkedPath, other : DslistchunkedPath) -> DslistchunkedPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistchunkedPath::copy(self : DslistchunkedPath) -> DslistchunkedPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistchunkedPath::fill(self : DslistchunkedPath, v : Double) -> DslistchunkedPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistchunkedPath::min(self : DslistchunkedPath) -> Double { @_common.min(self.data) }

pub fn DslistchunkedPath::max(self : DslistchunkedPath) -> Double { @_common.max(self.data) }

pub fn DslistchunkedPath::to_string(self : DslistchunkedPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistchunkedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_cluster_make(size : Int) -> DslistchunkedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistchunkedCluster::len(self : DslistchunkedCluster) -> Int { self.size }

pub fn DslistchunkedCluster::get(self : DslistchunkedCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistchunkedCluster::set(self : DslistchunkedCluster, i : Int, v : Double) -> DslistchunkedCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistchunkedCluster::sum(self : DslistchunkedCluster) -> Double { @_common.sum(self.data) }

pub fn DslistchunkedCluster::mean(self : DslistchunkedCluster) -> Double { @_common.mean(self.data) }

pub fn DslistchunkedCluster::scale(self : DslistchunkedCluster, f : Double) -> DslistchunkedCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistchunkedCluster::add(self : DslistchunkedCluster, other : DslistchunkedCluster) -> DslistchunkedCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistchunkedCluster::copy(self : DslistchunkedCluster) -> DslistchunkedCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistchunkedCluster::fill(self : DslistchunkedCluster, v : Double) -> DslistchunkedCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistchunkedCluster::min(self : DslistchunkedCluster) -> Double { @_common.min(self.data) }

pub fn DslistchunkedCluster::max(self : DslistchunkedCluster) -> Double { @_common.max(self.data) }

pub fn DslistchunkedCluster::to_string(self : DslistchunkedCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistchunkedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_model_make(size : Int) -> DslistchunkedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistchunkedModel::len(self : DslistchunkedModel) -> Int { self.size }

pub fn DslistchunkedModel::get(self : DslistchunkedModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistchunkedModel::set(self : DslistchunkedModel, i : Int, v : Double) -> DslistchunkedModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistchunkedModel::sum(self : DslistchunkedModel) -> Double { @_common.sum(self.data) }

pub fn DslistchunkedModel::mean(self : DslistchunkedModel) -> Double { @_common.mean(self.data) }

pub fn DslistchunkedModel::scale(self : DslistchunkedModel, f : Double) -> DslistchunkedModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistchunkedModel::add(self : DslistchunkedModel, other : DslistchunkedModel) -> DslistchunkedModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistchunkedModel::copy(self : DslistchunkedModel) -> DslistchunkedModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistchunkedModel::fill(self : DslistchunkedModel, v : Double) -> DslistchunkedModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistchunkedModel::min(self : DslistchunkedModel) -> Double { @_common.min(self.data) }

pub fn DslistchunkedModel::max(self : DslistchunkedModel) -> Double { @_common.max(self.data) }

pub fn DslistchunkedModel::to_string(self : DslistchunkedModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistchunkedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_layer_make(size : Int) -> DslistchunkedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistchunkedLayer::len(self : DslistchunkedLayer) -> Int { self.size }

pub fn DslistchunkedLayer::get(self : DslistchunkedLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistchunkedLayer::set(self : DslistchunkedLayer, i : Int, v : Double) -> DslistchunkedLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistchunkedLayer::sum(self : DslistchunkedLayer) -> Double { @_common.sum(self.data) }

pub fn DslistchunkedLayer::mean(self : DslistchunkedLayer) -> Double { @_common.mean(self.data) }

pub fn DslistchunkedLayer::scale(self : DslistchunkedLayer, f : Double) -> DslistchunkedLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistchunkedLayer::add(self : DslistchunkedLayer, other : DslistchunkedLayer) -> DslistchunkedLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistchunkedLayer::copy(self : DslistchunkedLayer) -> DslistchunkedLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistchunkedLayer::fill(self : DslistchunkedLayer, v : Double) -> DslistchunkedLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistchunkedLayer::min(self : DslistchunkedLayer) -> Double { @_common.min(self.data) }

pub fn DslistchunkedLayer::max(self : DslistchunkedLayer) -> Double { @_common.max(self.data) }

pub fn DslistchunkedLayer::to_string(self : DslistchunkedLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistchunkedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_buffer_make(size : Int) -> DslistchunkedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistchunkedBuffer::len(self : DslistchunkedBuffer) -> Int { self.size }

pub fn DslistchunkedBuffer::get(self : DslistchunkedBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistchunkedBuffer::set(self : DslistchunkedBuffer, i : Int, v : Double) -> DslistchunkedBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistchunkedBuffer::sum(self : DslistchunkedBuffer) -> Double { @_common.sum(self.data) }

pub fn DslistchunkedBuffer::mean(self : DslistchunkedBuffer) -> Double { @_common.mean(self.data) }

pub fn DslistchunkedBuffer::scale(self : DslistchunkedBuffer, f : Double) -> DslistchunkedBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistchunkedBuffer::add(self : DslistchunkedBuffer, other : DslistchunkedBuffer) -> DslistchunkedBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistchunkedBuffer::copy(self : DslistchunkedBuffer) -> DslistchunkedBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistchunkedBuffer::fill(self : DslistchunkedBuffer, v : Double) -> DslistchunkedBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistchunkedBuffer::min(self : DslistchunkedBuffer) -> Double { @_common.min(self.data) }

pub fn DslistchunkedBuffer::max(self : DslistchunkedBuffer) -> Double { @_common.max(self.data) }

pub fn DslistchunkedBuffer::to_string(self : DslistchunkedBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistchunkedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_cursor_make(size : Int) -> DslistchunkedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistchunkedCursor::len(self : DslistchunkedCursor) -> Int { self.size }

pub fn DslistchunkedCursor::get(self : DslistchunkedCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistchunkedCursor::set(self : DslistchunkedCursor, i : Int, v : Double) -> DslistchunkedCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistchunkedCursor::sum(self : DslistchunkedCursor) -> Double { @_common.sum(self.data) }

pub fn DslistchunkedCursor::mean(self : DslistchunkedCursor) -> Double { @_common.mean(self.data) }

pub fn DslistchunkedCursor::scale(self : DslistchunkedCursor, f : Double) -> DslistchunkedCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistchunkedCursor::add(self : DslistchunkedCursor, other : DslistchunkedCursor) -> DslistchunkedCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistchunkedCursor::copy(self : DslistchunkedCursor) -> DslistchunkedCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistchunkedCursor::fill(self : DslistchunkedCursor, v : Double) -> DslistchunkedCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistchunkedCursor::min(self : DslistchunkedCursor) -> Double { @_common.min(self.data) }

pub fn DslistchunkedCursor::max(self : DslistchunkedCursor) -> Double { @_common.max(self.data) }

pub fn DslistchunkedCursor::to_string(self : DslistchunkedCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistchunkedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_view_make(size : Int) -> DslistchunkedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistchunkedView::len(self : DslistchunkedView) -> Int { self.size }

pub fn DslistchunkedView::get(self : DslistchunkedView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistchunkedView::set(self : DslistchunkedView, i : Int, v : Double) -> DslistchunkedView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistchunkedView::sum(self : DslistchunkedView) -> Double { @_common.sum(self.data) }

pub fn DslistchunkedView::mean(self : DslistchunkedView) -> Double { @_common.mean(self.data) }

pub fn DslistchunkedView::scale(self : DslistchunkedView, f : Double) -> DslistchunkedView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistchunkedView::add(self : DslistchunkedView, other : DslistchunkedView) -> DslistchunkedView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistchunkedView::copy(self : DslistchunkedView) -> DslistchunkedView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistchunkedView::fill(self : DslistchunkedView, v : Double) -> DslistchunkedView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistchunkedView::min(self : DslistchunkedView) -> Double { @_common.min(self.data) }

pub fn DslistchunkedView::max(self : DslistchunkedView) -> Double { @_common.max(self.data) }

pub fn DslistchunkedView::to_string(self : DslistchunkedView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistchunkedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_range_make(size : Int) -> DslistchunkedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistchunkedRange::len(self : DslistchunkedRange) -> Int { self.size }

pub fn DslistchunkedRange::get(self : DslistchunkedRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistchunkedRange::set(self : DslistchunkedRange, i : Int, v : Double) -> DslistchunkedRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistchunkedRange::sum(self : DslistchunkedRange) -> Double { @_common.sum(self.data) }

pub fn DslistchunkedRange::mean(self : DslistchunkedRange) -> Double { @_common.mean(self.data) }

pub fn DslistchunkedRange::scale(self : DslistchunkedRange, f : Double) -> DslistchunkedRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistchunkedRange::add(self : DslistchunkedRange, other : DslistchunkedRange) -> DslistchunkedRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistchunkedRange::copy(self : DslistchunkedRange) -> DslistchunkedRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistchunkedRange::fill(self : DslistchunkedRange, v : Double) -> DslistchunkedRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistchunkedRange::min(self : DslistchunkedRange) -> Double { @_common.min(self.data) }

pub fn DslistchunkedRange::max(self : DslistchunkedRange) -> Double { @_common.max(self.data) }

pub fn DslistchunkedRange::to_string(self : DslistchunkedRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistchunkedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_chunked_slice_make(size : Int) -> DslistchunkedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistchunkedSlice::len(self : DslistchunkedSlice) -> Int { self.size }

pub fn DslistchunkedSlice::get(self : DslistchunkedSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistchunkedSlice::set(self : DslistchunkedSlice, i : Int, v : Double) -> DslistchunkedSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistchunkedSlice::sum(self : DslistchunkedSlice) -> Double { @_common.sum(self.data) }

pub fn DslistchunkedSlice::mean(self : DslistchunkedSlice) -> Double { @_common.mean(self.data) }

pub fn DslistchunkedSlice::scale(self : DslistchunkedSlice, f : Double) -> DslistchunkedSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistchunkedSlice::add(self : DslistchunkedSlice, other : DslistchunkedSlice) -> DslistchunkedSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistchunkedSlice::copy(self : DslistchunkedSlice) -> DslistchunkedSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistchunkedSlice::fill(self : DslistchunkedSlice, v : Double) -> DslistchunkedSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistchunkedSlice::min(self : DslistchunkedSlice) -> Double { @_common.min(self.data) }

pub fn DslistchunkedSlice::max(self : DslistchunkedSlice) -> Double { @_common.max(self.data) }

pub fn DslistchunkedSlice::to_string(self : DslistchunkedSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

