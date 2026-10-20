///===
/// extcore/graph_flow_mcmf

pub(all) struct GraphflowmcmfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_mcmf_make_point(x : Double, y : Double) -> GraphflowmcmfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_mcmf_make_point3(x : Double, y : Double, z : Double) -> GraphflowmcmfPoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowmcmfPoint::x(self : GraphflowmcmfPoint) -> Double { self.x }

pub fn GraphflowmcmfPoint::y(self : GraphflowmcmfPoint) -> Double { self.y }

pub fn GraphflowmcmfPoint::z(self : GraphflowmcmfPoint) -> Double { self.z }

pub fn GraphflowmcmfPoint::label(self : GraphflowmcmfPoint) -> Int { self.label }

pub fn GraphflowmcmfPoint::dist(self : GraphflowmcmfPoint, other : GraphflowmcmfPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowmcmfPoint::add(self : GraphflowmcmfPoint, other : GraphflowmcmfPoint) -> GraphflowmcmfPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowmcmfPoint::sub(self : GraphflowmcmfPoint, other : GraphflowmcmfPoint) -> GraphflowmcmfPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowmcmfPoint::scale(self : GraphflowmcmfPoint, s : Double) -> GraphflowmcmfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowmcmfPoint::dot(self : GraphflowmcmfPoint, other : GraphflowmcmfPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowmcmfPoint::cross(self : GraphflowmcmfPoint, other : GraphflowmcmfPoint) -> GraphflowmcmfPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowmcmfPoint::norm(self : GraphflowmcmfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowmcmfPoint::normalize(self : GraphflowmcmfPoint) -> GraphflowmcmfPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowmcmfPoint::negate(self : GraphflowmcmfPoint) -> GraphflowmcmfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowmcmfPoint::mid(self : GraphflowmcmfPoint, other : GraphflowmcmfPoint) -> GraphflowmcmfPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowmcmfPoint::lerp(self : GraphflowmcmfPoint, other : GraphflowmcmfPoint, t : Double) -> GraphflowmcmfPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowmcmfPoint::to_string(self : GraphflowmcmfPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowmcmfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_mcmf_make_series(vals : Array[Double], name : String) -> GraphflowmcmfSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowmcmfSeries::len(self : GraphflowmcmfSeries) -> Int { self.vals.length() }

pub fn GraphflowmcmfSeries::sum(self : GraphflowmcmfSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowmcmfSeries::mean(self : GraphflowmcmfSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowmcmfSeries::min(self : GraphflowmcmfSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowmcmfSeries::max(self : GraphflowmcmfSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowmcmfSeries::range(self : GraphflowmcmfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowmcmfSeries::variance(self : GraphflowmcmfSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowmcmfSeries::std(self : GraphflowmcmfSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowmcmfSeries::median(self : GraphflowmcmfSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowmcmfSeries::scale(self : GraphflowmcmfSeries, f : Double) -> GraphflowmcmfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowmcmfSeries::add(self : GraphflowmcmfSeries, other : GraphflowmcmfSeries) -> GraphflowmcmfSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowmcmfSeries::sub(self : GraphflowmcmfSeries, other : GraphflowmcmfSeries) -> GraphflowmcmfSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowmcmfSeries::normalize(self : GraphflowmcmfSeries) -> GraphflowmcmfSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowmcmfSeries::cumsum(self : GraphflowmcmfSeries) -> GraphflowmcmfSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowmcmfSeries::to_string(self : GraphflowmcmfSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowmcmfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_mcmf_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowmcmfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_mcmf_matrix_identity(n : Int) -> GraphflowmcmfMatrix {
  let m = graph_flow_mcmf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowmcmfMatrix::get(self : GraphflowmcmfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowmcmfMatrix::transpose(self : GraphflowmcmfMatrix) -> GraphflowmcmfMatrix {
  let result = graph_flow_mcmf_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowmcmfMatrix::add(self : GraphflowmcmfMatrix, other : GraphflowmcmfMatrix) -> GraphflowmcmfMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_mcmf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowmcmfMatrix::scale(self : GraphflowmcmfMatrix, s : Double) -> GraphflowmcmfMatrix {
  let result = graph_flow_mcmf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowmcmfMatrix::multiply(self : GraphflowmcmfMatrix, other : GraphflowmcmfMatrix) -> GraphflowmcmfMatrix {
  if self.cols != other.rows { return graph_flow_mcmf_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_mcmf_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphflowmcmfMatrix::trace(self : GraphflowmcmfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowmcmfMatrix::det(self : GraphflowmcmfMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowmcmfMatrix::norm(self : GraphflowmcmfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowmcmfMatrix::to_string(self : GraphflowmcmfMatrix) -> String {
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

pub(all) struct GraphflowmcmfVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_mcmf_make_vector(comps : Array[Double]) -> GraphflowmcmfVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_mcmf_vector_zero(dim : Int) -> GraphflowmcmfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowmcmfVector::add(self : GraphflowmcmfVector, other : GraphflowmcmfVector) -> GraphflowmcmfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowmcmfVector::sub(self : GraphflowmcmfVector, other : GraphflowmcmfVector) -> GraphflowmcmfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowmcmfVector::scale(self : GraphflowmcmfVector, s : Double) -> GraphflowmcmfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowmcmfVector::dot(self : GraphflowmcmfVector, other : GraphflowmcmfVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowmcmfVector::norm(self : GraphflowmcmfVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowmcmfVector::normalize(self : GraphflowmcmfVector) -> GraphflowmcmfVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowmcmfVector::dist(self : GraphflowmcmfVector, other : GraphflowmcmfVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowmcmfVector::to_string(self : GraphflowmcmfVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_mcmf_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_mcmf_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_mcmf_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_mcmf_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_mcmf_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_mcmf_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_mcmf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_mcmf_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_mcmf_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_mcmf_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_mcmf_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_mcmf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_mcmf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_mcmf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_mcmf_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_mcmf_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_mcmf_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_mcmf_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_mcmf_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_mcmf_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_mcmf_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_mcmf_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_mcmf_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_mcmf_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_mcmf_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_mcmf_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_mcmf_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_mcmf_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_mcmf_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowmcmfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_frame_make(size : Int) -> GraphflowmcmfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_frame_len(s : GraphflowmcmfFrame) -> Int { s.size }

pub fn graph_flow_mcmf_frame_get(s : GraphflowmcmfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_frame_set(s : GraphflowmcmfFrame, i : Int, v : Double) -> GraphflowmcmfFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_frame_sum(s : GraphflowmcmfFrame) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_frame_mean(s : GraphflowmcmfFrame) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_frame_scale(s : GraphflowmcmfFrame, f : Double) -> GraphflowmcmfFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_frame_add(a : GraphflowmcmfFrame, b : GraphflowmcmfFrame) -> GraphflowmcmfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mcmf_frame_copy(s : GraphflowmcmfFrame) -> GraphflowmcmfFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_frame_fill(s : GraphflowmcmfFrame, v : Double) -> GraphflowmcmfFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_frame_min(s : GraphflowmcmfFrame) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_frame_max(s : GraphflowmcmfFrame) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_frame_to_string(s : GraphflowmcmfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_table_make(size : Int) -> GraphflowmcmfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_table_len(s : GraphflowmcmfTable) -> Int { s.size }

pub fn graph_flow_mcmf_table_get(s : GraphflowmcmfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_table_set(s : GraphflowmcmfTable, i : Int, v : Double) -> GraphflowmcmfTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_table_sum(s : GraphflowmcmfTable) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_table_mean(s : GraphflowmcmfTable) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_table_scale(s : GraphflowmcmfTable, f : Double) -> GraphflowmcmfTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_table_add(a : GraphflowmcmfTable, b : GraphflowmcmfTable) -> GraphflowmcmfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mcmf_table_copy(s : GraphflowmcmfTable) -> GraphflowmcmfTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_table_fill(s : GraphflowmcmfTable, v : Double) -> GraphflowmcmfTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_table_min(s : GraphflowmcmfTable) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_table_max(s : GraphflowmcmfTable) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_table_to_string(s : GraphflowmcmfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_graphn_make(size : Int) -> GraphflowmcmfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_graphn_len(s : GraphflowmcmfGraphN) -> Int { s.size }

pub fn graph_flow_mcmf_graphn_get(s : GraphflowmcmfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_graphn_set(s : GraphflowmcmfGraphN, i : Int, v : Double) -> GraphflowmcmfGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_graphn_sum(s : GraphflowmcmfGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_graphn_mean(s : GraphflowmcmfGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_graphn_scale(s : GraphflowmcmfGraphN, f : Double) -> GraphflowmcmfGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_graphn_add(a : GraphflowmcmfGraphN, b : GraphflowmcmfGraphN) -> GraphflowmcmfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mcmf_graphn_copy(s : GraphflowmcmfGraphN) -> GraphflowmcmfGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_graphn_fill(s : GraphflowmcmfGraphN, v : Double) -> GraphflowmcmfGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_graphn_min(s : GraphflowmcmfGraphN) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_graphn_max(s : GraphflowmcmfGraphN) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_graphn_to_string(s : GraphflowmcmfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_node_make(size : Int) -> GraphflowmcmfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_node_len(s : GraphflowmcmfNode) -> Int { s.size }

pub fn graph_flow_mcmf_node_get(s : GraphflowmcmfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_node_set(s : GraphflowmcmfNode, i : Int, v : Double) -> GraphflowmcmfNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_node_sum(s : GraphflowmcmfNode) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_node_mean(s : GraphflowmcmfNode) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_node_scale(s : GraphflowmcmfNode, f : Double) -> GraphflowmcmfNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_node_add(a : GraphflowmcmfNode, b : GraphflowmcmfNode) -> GraphflowmcmfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mcmf_node_copy(s : GraphflowmcmfNode) -> GraphflowmcmfNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_node_fill(s : GraphflowmcmfNode, v : Double) -> GraphflowmcmfNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_node_min(s : GraphflowmcmfNode) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_node_max(s : GraphflowmcmfNode) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_node_to_string(s : GraphflowmcmfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_edge_make(size : Int) -> GraphflowmcmfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_edge_len(s : GraphflowmcmfEdge) -> Int { s.size }

pub fn graph_flow_mcmf_edge_get(s : GraphflowmcmfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_edge_set(s : GraphflowmcmfEdge, i : Int, v : Double) -> GraphflowmcmfEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_edge_sum(s : GraphflowmcmfEdge) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_edge_mean(s : GraphflowmcmfEdge) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_edge_scale(s : GraphflowmcmfEdge, f : Double) -> GraphflowmcmfEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_edge_add(a : GraphflowmcmfEdge, b : GraphflowmcmfEdge) -> GraphflowmcmfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mcmf_edge_copy(s : GraphflowmcmfEdge) -> GraphflowmcmfEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_edge_fill(s : GraphflowmcmfEdge, v : Double) -> GraphflowmcmfEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_edge_min(s : GraphflowmcmfEdge) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_edge_max(s : GraphflowmcmfEdge) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_edge_to_string(s : GraphflowmcmfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_path_make(size : Int) -> GraphflowmcmfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_path_len(s : GraphflowmcmfPath) -> Int { s.size }

pub fn graph_flow_mcmf_path_get(s : GraphflowmcmfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_path_set(s : GraphflowmcmfPath, i : Int, v : Double) -> GraphflowmcmfPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_path_sum(s : GraphflowmcmfPath) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_path_mean(s : GraphflowmcmfPath) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_path_scale(s : GraphflowmcmfPath, f : Double) -> GraphflowmcmfPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_path_add(a : GraphflowmcmfPath, b : GraphflowmcmfPath) -> GraphflowmcmfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mcmf_path_copy(s : GraphflowmcmfPath) -> GraphflowmcmfPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_path_fill(s : GraphflowmcmfPath, v : Double) -> GraphflowmcmfPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_path_min(s : GraphflowmcmfPath) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_path_max(s : GraphflowmcmfPath) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_path_to_string(s : GraphflowmcmfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_cluster_make(size : Int) -> GraphflowmcmfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_cluster_len(s : GraphflowmcmfCluster) -> Int { s.size }

pub fn graph_flow_mcmf_cluster_get(s : GraphflowmcmfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_cluster_set(s : GraphflowmcmfCluster, i : Int, v : Double) -> GraphflowmcmfCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_cluster_sum(s : GraphflowmcmfCluster) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_cluster_mean(s : GraphflowmcmfCluster) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_cluster_scale(s : GraphflowmcmfCluster, f : Double) -> GraphflowmcmfCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_cluster_add(a : GraphflowmcmfCluster, b : GraphflowmcmfCluster) -> GraphflowmcmfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mcmf_cluster_copy(s : GraphflowmcmfCluster) -> GraphflowmcmfCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_cluster_fill(s : GraphflowmcmfCluster, v : Double) -> GraphflowmcmfCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_cluster_min(s : GraphflowmcmfCluster) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_cluster_max(s : GraphflowmcmfCluster) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_cluster_to_string(s : GraphflowmcmfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_model_make(size : Int) -> GraphflowmcmfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_model_len(s : GraphflowmcmfModel) -> Int { s.size }

pub fn graph_flow_mcmf_model_get(s : GraphflowmcmfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_model_set(s : GraphflowmcmfModel, i : Int, v : Double) -> GraphflowmcmfModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_model_sum(s : GraphflowmcmfModel) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_model_mean(s : GraphflowmcmfModel) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_model_scale(s : GraphflowmcmfModel, f : Double) -> GraphflowmcmfModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_model_add(a : GraphflowmcmfModel, b : GraphflowmcmfModel) -> GraphflowmcmfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mcmf_model_copy(s : GraphflowmcmfModel) -> GraphflowmcmfModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_model_fill(s : GraphflowmcmfModel, v : Double) -> GraphflowmcmfModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_model_min(s : GraphflowmcmfModel) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_model_max(s : GraphflowmcmfModel) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_model_to_string(s : GraphflowmcmfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_layer_make(size : Int) -> GraphflowmcmfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_layer_len(s : GraphflowmcmfLayer) -> Int { s.size }

pub fn graph_flow_mcmf_layer_get(s : GraphflowmcmfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_layer_set(s : GraphflowmcmfLayer, i : Int, v : Double) -> GraphflowmcmfLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_layer_sum(s : GraphflowmcmfLayer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_layer_mean(s : GraphflowmcmfLayer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_layer_scale(s : GraphflowmcmfLayer, f : Double) -> GraphflowmcmfLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_layer_add(a : GraphflowmcmfLayer, b : GraphflowmcmfLayer) -> GraphflowmcmfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mcmf_layer_copy(s : GraphflowmcmfLayer) -> GraphflowmcmfLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_layer_fill(s : GraphflowmcmfLayer, v : Double) -> GraphflowmcmfLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_layer_min(s : GraphflowmcmfLayer) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_layer_max(s : GraphflowmcmfLayer) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_layer_to_string(s : GraphflowmcmfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_buffer_make(size : Int) -> GraphflowmcmfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_buffer_len(s : GraphflowmcmfBuffer) -> Int { s.size }

pub fn graph_flow_mcmf_buffer_get(s : GraphflowmcmfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_buffer_set(s : GraphflowmcmfBuffer, i : Int, v : Double) -> GraphflowmcmfBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_buffer_sum(s : GraphflowmcmfBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_buffer_mean(s : GraphflowmcmfBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_buffer_scale(s : GraphflowmcmfBuffer, f : Double) -> GraphflowmcmfBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_buffer_add(a : GraphflowmcmfBuffer, b : GraphflowmcmfBuffer) -> GraphflowmcmfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mcmf_buffer_copy(s : GraphflowmcmfBuffer) -> GraphflowmcmfBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_buffer_fill(s : GraphflowmcmfBuffer, v : Double) -> GraphflowmcmfBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_buffer_min(s : GraphflowmcmfBuffer) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_buffer_max(s : GraphflowmcmfBuffer) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_buffer_to_string(s : GraphflowmcmfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_cursor_make(size : Int) -> GraphflowmcmfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_cursor_len(s : GraphflowmcmfCursor) -> Int { s.size }

pub fn graph_flow_mcmf_cursor_get(s : GraphflowmcmfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_cursor_set(s : GraphflowmcmfCursor, i : Int, v : Double) -> GraphflowmcmfCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_cursor_sum(s : GraphflowmcmfCursor) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_cursor_mean(s : GraphflowmcmfCursor) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_cursor_scale(s : GraphflowmcmfCursor, f : Double) -> GraphflowmcmfCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_cursor_add(a : GraphflowmcmfCursor, b : GraphflowmcmfCursor) -> GraphflowmcmfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mcmf_cursor_copy(s : GraphflowmcmfCursor) -> GraphflowmcmfCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_cursor_fill(s : GraphflowmcmfCursor, v : Double) -> GraphflowmcmfCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_cursor_min(s : GraphflowmcmfCursor) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_cursor_max(s : GraphflowmcmfCursor) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_cursor_to_string(s : GraphflowmcmfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_view_make(size : Int) -> GraphflowmcmfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_view_len(s : GraphflowmcmfView) -> Int { s.size }

pub fn graph_flow_mcmf_view_get(s : GraphflowmcmfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_view_set(s : GraphflowmcmfView, i : Int, v : Double) -> GraphflowmcmfView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_view_sum(s : GraphflowmcmfView) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_view_mean(s : GraphflowmcmfView) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_view_scale(s : GraphflowmcmfView, f : Double) -> GraphflowmcmfView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_view_add(a : GraphflowmcmfView, b : GraphflowmcmfView) -> GraphflowmcmfView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mcmf_view_copy(s : GraphflowmcmfView) -> GraphflowmcmfView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_view_fill(s : GraphflowmcmfView, v : Double) -> GraphflowmcmfView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_view_min(s : GraphflowmcmfView) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_view_max(s : GraphflowmcmfView) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_view_to_string(s : GraphflowmcmfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_range_make(size : Int) -> GraphflowmcmfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_range_len(s : GraphflowmcmfRange) -> Int { s.size }

pub fn graph_flow_mcmf_range_get(s : GraphflowmcmfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_range_set(s : GraphflowmcmfRange, i : Int, v : Double) -> GraphflowmcmfRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_range_sum(s : GraphflowmcmfRange) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_range_mean(s : GraphflowmcmfRange) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_range_scale(s : GraphflowmcmfRange, f : Double) -> GraphflowmcmfRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_range_add(a : GraphflowmcmfRange, b : GraphflowmcmfRange) -> GraphflowmcmfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mcmf_range_copy(s : GraphflowmcmfRange) -> GraphflowmcmfRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_range_fill(s : GraphflowmcmfRange, v : Double) -> GraphflowmcmfRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_range_min(s : GraphflowmcmfRange) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_range_max(s : GraphflowmcmfRange) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_range_to_string(s : GraphflowmcmfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_slice_make(size : Int) -> GraphflowmcmfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_slice_len(s : GraphflowmcmfSlice) -> Int { s.size }

pub fn graph_flow_mcmf_slice_get(s : GraphflowmcmfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_slice_set(s : GraphflowmcmfSlice, i : Int, v : Double) -> GraphflowmcmfSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_slice_sum(s : GraphflowmcmfSlice) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_slice_mean(s : GraphflowmcmfSlice) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_slice_scale(s : GraphflowmcmfSlice, f : Double) -> GraphflowmcmfSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_slice_add(a : GraphflowmcmfSlice, b : GraphflowmcmfSlice) -> GraphflowmcmfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mcmf_slice_copy(s : GraphflowmcmfSlice) -> GraphflowmcmfSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_slice_fill(s : GraphflowmcmfSlice, v : Double) -> GraphflowmcmfSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mcmf_slice_min(s : GraphflowmcmfSlice) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_slice_max(s : GraphflowmcmfSlice) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_slice_to_string(s : GraphflowmcmfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

