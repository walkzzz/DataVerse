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

pub fn GraphflowmcmfFrame::len(self : GraphflowmcmfFrame) -> Int { self.size }

pub fn GraphflowmcmfFrame::get(self : GraphflowmcmfFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmcmfFrame::set(self : GraphflowmcmfFrame, i : Int, v : Double) -> GraphflowmcmfFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfFrame::sum(self : GraphflowmcmfFrame) -> Double { @_common.sum(self.data) }

pub fn GraphflowmcmfFrame::mean(self : GraphflowmcmfFrame) -> Double { @_common.mean(self.data) }

pub fn GraphflowmcmfFrame::scale(self : GraphflowmcmfFrame, f : Double) -> GraphflowmcmfFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfFrame::add(self : GraphflowmcmfFrame, other : GraphflowmcmfFrame) -> GraphflowmcmfFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmcmfFrame::copy(self : GraphflowmcmfFrame) -> GraphflowmcmfFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfFrame::fill(self : GraphflowmcmfFrame, v : Double) -> GraphflowmcmfFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfFrame::min(self : GraphflowmcmfFrame) -> Double { @_common.min(self.data) }

pub fn GraphflowmcmfFrame::max(self : GraphflowmcmfFrame) -> Double { @_common.max(self.data) }

pub fn GraphflowmcmfFrame::to_string(self : GraphflowmcmfFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_table_make(size : Int) -> GraphflowmcmfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmcmfTable::len(self : GraphflowmcmfTable) -> Int { self.size }

pub fn GraphflowmcmfTable::get(self : GraphflowmcmfTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmcmfTable::set(self : GraphflowmcmfTable, i : Int, v : Double) -> GraphflowmcmfTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfTable::sum(self : GraphflowmcmfTable) -> Double { @_common.sum(self.data) }

pub fn GraphflowmcmfTable::mean(self : GraphflowmcmfTable) -> Double { @_common.mean(self.data) }

pub fn GraphflowmcmfTable::scale(self : GraphflowmcmfTable, f : Double) -> GraphflowmcmfTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfTable::add(self : GraphflowmcmfTable, other : GraphflowmcmfTable) -> GraphflowmcmfTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmcmfTable::copy(self : GraphflowmcmfTable) -> GraphflowmcmfTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfTable::fill(self : GraphflowmcmfTable, v : Double) -> GraphflowmcmfTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfTable::min(self : GraphflowmcmfTable) -> Double { @_common.min(self.data) }

pub fn GraphflowmcmfTable::max(self : GraphflowmcmfTable) -> Double { @_common.max(self.data) }

pub fn GraphflowmcmfTable::to_string(self : GraphflowmcmfTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_graphn_make(size : Int) -> GraphflowmcmfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmcmfGraphN::len(self : GraphflowmcmfGraphN) -> Int { self.size }

pub fn GraphflowmcmfGraphN::get(self : GraphflowmcmfGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmcmfGraphN::set(self : GraphflowmcmfGraphN, i : Int, v : Double) -> GraphflowmcmfGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfGraphN::sum(self : GraphflowmcmfGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphflowmcmfGraphN::mean(self : GraphflowmcmfGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphflowmcmfGraphN::scale(self : GraphflowmcmfGraphN, f : Double) -> GraphflowmcmfGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfGraphN::add(self : GraphflowmcmfGraphN, other : GraphflowmcmfGraphN) -> GraphflowmcmfGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmcmfGraphN::copy(self : GraphflowmcmfGraphN) -> GraphflowmcmfGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfGraphN::fill(self : GraphflowmcmfGraphN, v : Double) -> GraphflowmcmfGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfGraphN::min(self : GraphflowmcmfGraphN) -> Double { @_common.min(self.data) }

pub fn GraphflowmcmfGraphN::max(self : GraphflowmcmfGraphN) -> Double { @_common.max(self.data) }

pub fn GraphflowmcmfGraphN::to_string(self : GraphflowmcmfGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_node_make(size : Int) -> GraphflowmcmfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmcmfNode::len(self : GraphflowmcmfNode) -> Int { self.size }

pub fn GraphflowmcmfNode::get(self : GraphflowmcmfNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmcmfNode::set(self : GraphflowmcmfNode, i : Int, v : Double) -> GraphflowmcmfNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfNode::sum(self : GraphflowmcmfNode) -> Double { @_common.sum(self.data) }

pub fn GraphflowmcmfNode::mean(self : GraphflowmcmfNode) -> Double { @_common.mean(self.data) }

pub fn GraphflowmcmfNode::scale(self : GraphflowmcmfNode, f : Double) -> GraphflowmcmfNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfNode::add(self : GraphflowmcmfNode, other : GraphflowmcmfNode) -> GraphflowmcmfNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmcmfNode::copy(self : GraphflowmcmfNode) -> GraphflowmcmfNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfNode::fill(self : GraphflowmcmfNode, v : Double) -> GraphflowmcmfNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfNode::min(self : GraphflowmcmfNode) -> Double { @_common.min(self.data) }

pub fn GraphflowmcmfNode::max(self : GraphflowmcmfNode) -> Double { @_common.max(self.data) }

pub fn GraphflowmcmfNode::to_string(self : GraphflowmcmfNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_edge_make(size : Int) -> GraphflowmcmfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmcmfEdge::len(self : GraphflowmcmfEdge) -> Int { self.size }

pub fn GraphflowmcmfEdge::get(self : GraphflowmcmfEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmcmfEdge::set(self : GraphflowmcmfEdge, i : Int, v : Double) -> GraphflowmcmfEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfEdge::sum(self : GraphflowmcmfEdge) -> Double { @_common.sum(self.data) }

pub fn GraphflowmcmfEdge::mean(self : GraphflowmcmfEdge) -> Double { @_common.mean(self.data) }

pub fn GraphflowmcmfEdge::scale(self : GraphflowmcmfEdge, f : Double) -> GraphflowmcmfEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfEdge::add(self : GraphflowmcmfEdge, other : GraphflowmcmfEdge) -> GraphflowmcmfEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmcmfEdge::copy(self : GraphflowmcmfEdge) -> GraphflowmcmfEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfEdge::fill(self : GraphflowmcmfEdge, v : Double) -> GraphflowmcmfEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfEdge::min(self : GraphflowmcmfEdge) -> Double { @_common.min(self.data) }

pub fn GraphflowmcmfEdge::max(self : GraphflowmcmfEdge) -> Double { @_common.max(self.data) }

pub fn GraphflowmcmfEdge::to_string(self : GraphflowmcmfEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_path_make(size : Int) -> GraphflowmcmfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmcmfPath::len(self : GraphflowmcmfPath) -> Int { self.size }

pub fn GraphflowmcmfPath::get(self : GraphflowmcmfPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmcmfPath::set(self : GraphflowmcmfPath, i : Int, v : Double) -> GraphflowmcmfPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfPath::sum(self : GraphflowmcmfPath) -> Double { @_common.sum(self.data) }

pub fn GraphflowmcmfPath::mean(self : GraphflowmcmfPath) -> Double { @_common.mean(self.data) }

pub fn GraphflowmcmfPath::scale(self : GraphflowmcmfPath, f : Double) -> GraphflowmcmfPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfPath::add(self : GraphflowmcmfPath, other : GraphflowmcmfPath) -> GraphflowmcmfPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmcmfPath::copy(self : GraphflowmcmfPath) -> GraphflowmcmfPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfPath::fill(self : GraphflowmcmfPath, v : Double) -> GraphflowmcmfPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfPath::min(self : GraphflowmcmfPath) -> Double { @_common.min(self.data) }

pub fn GraphflowmcmfPath::max(self : GraphflowmcmfPath) -> Double { @_common.max(self.data) }

pub fn GraphflowmcmfPath::to_string(self : GraphflowmcmfPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_cluster_make(size : Int) -> GraphflowmcmfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmcmfCluster::len(self : GraphflowmcmfCluster) -> Int { self.size }

pub fn GraphflowmcmfCluster::get(self : GraphflowmcmfCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmcmfCluster::set(self : GraphflowmcmfCluster, i : Int, v : Double) -> GraphflowmcmfCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfCluster::sum(self : GraphflowmcmfCluster) -> Double { @_common.sum(self.data) }

pub fn GraphflowmcmfCluster::mean(self : GraphflowmcmfCluster) -> Double { @_common.mean(self.data) }

pub fn GraphflowmcmfCluster::scale(self : GraphflowmcmfCluster, f : Double) -> GraphflowmcmfCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfCluster::add(self : GraphflowmcmfCluster, other : GraphflowmcmfCluster) -> GraphflowmcmfCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmcmfCluster::copy(self : GraphflowmcmfCluster) -> GraphflowmcmfCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfCluster::fill(self : GraphflowmcmfCluster, v : Double) -> GraphflowmcmfCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfCluster::min(self : GraphflowmcmfCluster) -> Double { @_common.min(self.data) }

pub fn GraphflowmcmfCluster::max(self : GraphflowmcmfCluster) -> Double { @_common.max(self.data) }

pub fn GraphflowmcmfCluster::to_string(self : GraphflowmcmfCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_model_make(size : Int) -> GraphflowmcmfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmcmfModel::len(self : GraphflowmcmfModel) -> Int { self.size }

pub fn GraphflowmcmfModel::get(self : GraphflowmcmfModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmcmfModel::set(self : GraphflowmcmfModel, i : Int, v : Double) -> GraphflowmcmfModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfModel::sum(self : GraphflowmcmfModel) -> Double { @_common.sum(self.data) }

pub fn GraphflowmcmfModel::mean(self : GraphflowmcmfModel) -> Double { @_common.mean(self.data) }

pub fn GraphflowmcmfModel::scale(self : GraphflowmcmfModel, f : Double) -> GraphflowmcmfModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfModel::add(self : GraphflowmcmfModel, other : GraphflowmcmfModel) -> GraphflowmcmfModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmcmfModel::copy(self : GraphflowmcmfModel) -> GraphflowmcmfModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfModel::fill(self : GraphflowmcmfModel, v : Double) -> GraphflowmcmfModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfModel::min(self : GraphflowmcmfModel) -> Double { @_common.min(self.data) }

pub fn GraphflowmcmfModel::max(self : GraphflowmcmfModel) -> Double { @_common.max(self.data) }

pub fn GraphflowmcmfModel::to_string(self : GraphflowmcmfModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_layer_make(size : Int) -> GraphflowmcmfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmcmfLayer::len(self : GraphflowmcmfLayer) -> Int { self.size }

pub fn GraphflowmcmfLayer::get(self : GraphflowmcmfLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmcmfLayer::set(self : GraphflowmcmfLayer, i : Int, v : Double) -> GraphflowmcmfLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfLayer::sum(self : GraphflowmcmfLayer) -> Double { @_common.sum(self.data) }

pub fn GraphflowmcmfLayer::mean(self : GraphflowmcmfLayer) -> Double { @_common.mean(self.data) }

pub fn GraphflowmcmfLayer::scale(self : GraphflowmcmfLayer, f : Double) -> GraphflowmcmfLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfLayer::add(self : GraphflowmcmfLayer, other : GraphflowmcmfLayer) -> GraphflowmcmfLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmcmfLayer::copy(self : GraphflowmcmfLayer) -> GraphflowmcmfLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfLayer::fill(self : GraphflowmcmfLayer, v : Double) -> GraphflowmcmfLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfLayer::min(self : GraphflowmcmfLayer) -> Double { @_common.min(self.data) }

pub fn GraphflowmcmfLayer::max(self : GraphflowmcmfLayer) -> Double { @_common.max(self.data) }

pub fn GraphflowmcmfLayer::to_string(self : GraphflowmcmfLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_buffer_make(size : Int) -> GraphflowmcmfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmcmfBuffer::len(self : GraphflowmcmfBuffer) -> Int { self.size }

pub fn GraphflowmcmfBuffer::get(self : GraphflowmcmfBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmcmfBuffer::set(self : GraphflowmcmfBuffer, i : Int, v : Double) -> GraphflowmcmfBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfBuffer::sum(self : GraphflowmcmfBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphflowmcmfBuffer::mean(self : GraphflowmcmfBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphflowmcmfBuffer::scale(self : GraphflowmcmfBuffer, f : Double) -> GraphflowmcmfBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfBuffer::add(self : GraphflowmcmfBuffer, other : GraphflowmcmfBuffer) -> GraphflowmcmfBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmcmfBuffer::copy(self : GraphflowmcmfBuffer) -> GraphflowmcmfBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfBuffer::fill(self : GraphflowmcmfBuffer, v : Double) -> GraphflowmcmfBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfBuffer::min(self : GraphflowmcmfBuffer) -> Double { @_common.min(self.data) }

pub fn GraphflowmcmfBuffer::max(self : GraphflowmcmfBuffer) -> Double { @_common.max(self.data) }

pub fn GraphflowmcmfBuffer::to_string(self : GraphflowmcmfBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_cursor_make(size : Int) -> GraphflowmcmfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmcmfCursor::len(self : GraphflowmcmfCursor) -> Int { self.size }

pub fn GraphflowmcmfCursor::get(self : GraphflowmcmfCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmcmfCursor::set(self : GraphflowmcmfCursor, i : Int, v : Double) -> GraphflowmcmfCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfCursor::sum(self : GraphflowmcmfCursor) -> Double { @_common.sum(self.data) }

pub fn GraphflowmcmfCursor::mean(self : GraphflowmcmfCursor) -> Double { @_common.mean(self.data) }

pub fn GraphflowmcmfCursor::scale(self : GraphflowmcmfCursor, f : Double) -> GraphflowmcmfCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfCursor::add(self : GraphflowmcmfCursor, other : GraphflowmcmfCursor) -> GraphflowmcmfCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmcmfCursor::copy(self : GraphflowmcmfCursor) -> GraphflowmcmfCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfCursor::fill(self : GraphflowmcmfCursor, v : Double) -> GraphflowmcmfCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfCursor::min(self : GraphflowmcmfCursor) -> Double { @_common.min(self.data) }

pub fn GraphflowmcmfCursor::max(self : GraphflowmcmfCursor) -> Double { @_common.max(self.data) }

pub fn GraphflowmcmfCursor::to_string(self : GraphflowmcmfCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_view_make(size : Int) -> GraphflowmcmfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmcmfView::len(self : GraphflowmcmfView) -> Int { self.size }

pub fn GraphflowmcmfView::get(self : GraphflowmcmfView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmcmfView::set(self : GraphflowmcmfView, i : Int, v : Double) -> GraphflowmcmfView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfView::sum(self : GraphflowmcmfView) -> Double { @_common.sum(self.data) }

pub fn GraphflowmcmfView::mean(self : GraphflowmcmfView) -> Double { @_common.mean(self.data) }

pub fn GraphflowmcmfView::scale(self : GraphflowmcmfView, f : Double) -> GraphflowmcmfView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfView::add(self : GraphflowmcmfView, other : GraphflowmcmfView) -> GraphflowmcmfView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmcmfView::copy(self : GraphflowmcmfView) -> GraphflowmcmfView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfView::fill(self : GraphflowmcmfView, v : Double) -> GraphflowmcmfView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfView::min(self : GraphflowmcmfView) -> Double { @_common.min(self.data) }

pub fn GraphflowmcmfView::max(self : GraphflowmcmfView) -> Double { @_common.max(self.data) }

pub fn GraphflowmcmfView::to_string(self : GraphflowmcmfView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_range_make(size : Int) -> GraphflowmcmfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmcmfRange::len(self : GraphflowmcmfRange) -> Int { self.size }

pub fn GraphflowmcmfRange::get(self : GraphflowmcmfRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmcmfRange::set(self : GraphflowmcmfRange, i : Int, v : Double) -> GraphflowmcmfRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfRange::sum(self : GraphflowmcmfRange) -> Double { @_common.sum(self.data) }

pub fn GraphflowmcmfRange::mean(self : GraphflowmcmfRange) -> Double { @_common.mean(self.data) }

pub fn GraphflowmcmfRange::scale(self : GraphflowmcmfRange, f : Double) -> GraphflowmcmfRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfRange::add(self : GraphflowmcmfRange, other : GraphflowmcmfRange) -> GraphflowmcmfRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmcmfRange::copy(self : GraphflowmcmfRange) -> GraphflowmcmfRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfRange::fill(self : GraphflowmcmfRange, v : Double) -> GraphflowmcmfRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfRange::min(self : GraphflowmcmfRange) -> Double { @_common.min(self.data) }

pub fn GraphflowmcmfRange::max(self : GraphflowmcmfRange) -> Double { @_common.max(self.data) }

pub fn GraphflowmcmfRange::to_string(self : GraphflowmcmfRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_slice_make(size : Int) -> GraphflowmcmfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmcmfSlice::len(self : GraphflowmcmfSlice) -> Int { self.size }

pub fn GraphflowmcmfSlice::get(self : GraphflowmcmfSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmcmfSlice::set(self : GraphflowmcmfSlice, i : Int, v : Double) -> GraphflowmcmfSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfSlice::sum(self : GraphflowmcmfSlice) -> Double { @_common.sum(self.data) }

pub fn GraphflowmcmfSlice::mean(self : GraphflowmcmfSlice) -> Double { @_common.mean(self.data) }

pub fn GraphflowmcmfSlice::scale(self : GraphflowmcmfSlice, f : Double) -> GraphflowmcmfSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfSlice::add(self : GraphflowmcmfSlice, other : GraphflowmcmfSlice) -> GraphflowmcmfSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmcmfSlice::copy(self : GraphflowmcmfSlice) -> GraphflowmcmfSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfSlice::fill(self : GraphflowmcmfSlice, v : Double) -> GraphflowmcmfSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmcmfSlice::min(self : GraphflowmcmfSlice) -> Double { @_common.min(self.data) }

pub fn GraphflowmcmfSlice::max(self : GraphflowmcmfSlice) -> Double { @_common.max(self.data) }

pub fn GraphflowmcmfSlice::to_string(self : GraphflowmcmfSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

