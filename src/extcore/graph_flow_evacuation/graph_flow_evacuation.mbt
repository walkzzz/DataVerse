///===
/// extcore/graph_flow_evacuation

pub(all) struct GraphflowevacuationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_evacuation_make_point(x : Double, y : Double) -> GraphflowevacuationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_evacuation_make_point3(x : Double, y : Double, z : Double) -> GraphflowevacuationPoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowevacuationPoint::x(self : GraphflowevacuationPoint) -> Double { self.x }

pub fn GraphflowevacuationPoint::y(self : GraphflowevacuationPoint) -> Double { self.y }

pub fn GraphflowevacuationPoint::z(self : GraphflowevacuationPoint) -> Double { self.z }

pub fn GraphflowevacuationPoint::label(self : GraphflowevacuationPoint) -> Int { self.label }

pub fn GraphflowevacuationPoint::dist(self : GraphflowevacuationPoint, other : GraphflowevacuationPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowevacuationPoint::add(self : GraphflowevacuationPoint, other : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowevacuationPoint::sub(self : GraphflowevacuationPoint, other : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowevacuationPoint::scale(self : GraphflowevacuationPoint, s : Double) -> GraphflowevacuationPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowevacuationPoint::dot(self : GraphflowevacuationPoint, other : GraphflowevacuationPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowevacuationPoint::cross(self : GraphflowevacuationPoint, other : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowevacuationPoint::norm(self : GraphflowevacuationPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowevacuationPoint::normalize(self : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowevacuationPoint::negate(self : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowevacuationPoint::mid(self : GraphflowevacuationPoint, other : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowevacuationPoint::lerp(self : GraphflowevacuationPoint, other : GraphflowevacuationPoint, t : Double) -> GraphflowevacuationPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowevacuationPoint::to_string(self : GraphflowevacuationPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowevacuationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_evacuation_make_series(vals : Array[Double], name : String) -> GraphflowevacuationSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowevacuationSeries::len(self : GraphflowevacuationSeries) -> Int { self.vals.length() }

pub fn GraphflowevacuationSeries::sum(self : GraphflowevacuationSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowevacuationSeries::mean(self : GraphflowevacuationSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowevacuationSeries::min(self : GraphflowevacuationSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowevacuationSeries::max(self : GraphflowevacuationSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowevacuationSeries::range(self : GraphflowevacuationSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowevacuationSeries::variance(self : GraphflowevacuationSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowevacuationSeries::std(self : GraphflowevacuationSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowevacuationSeries::median(self : GraphflowevacuationSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowevacuationSeries::scale(self : GraphflowevacuationSeries, f : Double) -> GraphflowevacuationSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowevacuationSeries::add(self : GraphflowevacuationSeries, other : GraphflowevacuationSeries) -> GraphflowevacuationSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowevacuationSeries::sub(self : GraphflowevacuationSeries, other : GraphflowevacuationSeries) -> GraphflowevacuationSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowevacuationSeries::normalize(self : GraphflowevacuationSeries) -> GraphflowevacuationSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowevacuationSeries::cumsum(self : GraphflowevacuationSeries) -> GraphflowevacuationSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowevacuationSeries::to_string(self : GraphflowevacuationSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowevacuationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_evacuation_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowevacuationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_evacuation_matrix_identity(n : Int) -> GraphflowevacuationMatrix {
  let m = graph_flow_evacuation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowevacuationMatrix::get(self : GraphflowevacuationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowevacuationMatrix::transpose(self : GraphflowevacuationMatrix) -> GraphflowevacuationMatrix {
  let result = graph_flow_evacuation_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowevacuationMatrix::add(self : GraphflowevacuationMatrix, other : GraphflowevacuationMatrix) -> GraphflowevacuationMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_evacuation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowevacuationMatrix::scale(self : GraphflowevacuationMatrix, s : Double) -> GraphflowevacuationMatrix {
  let result = graph_flow_evacuation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowevacuationMatrix::multiply(self : GraphflowevacuationMatrix, other : GraphflowevacuationMatrix) -> GraphflowevacuationMatrix {
  if self.cols != other.rows { return graph_flow_evacuation_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_evacuation_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphflowevacuationMatrix::trace(self : GraphflowevacuationMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowevacuationMatrix::det(self : GraphflowevacuationMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowevacuationMatrix::norm(self : GraphflowevacuationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowevacuationMatrix::to_string(self : GraphflowevacuationMatrix) -> String {
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

pub(all) struct GraphflowevacuationVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_evacuation_make_vector(comps : Array[Double]) -> GraphflowevacuationVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_evacuation_vector_zero(dim : Int) -> GraphflowevacuationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowevacuationVector::add(self : GraphflowevacuationVector, other : GraphflowevacuationVector) -> GraphflowevacuationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowevacuationVector::sub(self : GraphflowevacuationVector, other : GraphflowevacuationVector) -> GraphflowevacuationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowevacuationVector::scale(self : GraphflowevacuationVector, s : Double) -> GraphflowevacuationVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowevacuationVector::dot(self : GraphflowevacuationVector, other : GraphflowevacuationVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowevacuationVector::norm(self : GraphflowevacuationVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowevacuationVector::normalize(self : GraphflowevacuationVector) -> GraphflowevacuationVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowevacuationVector::dist(self : GraphflowevacuationVector, other : GraphflowevacuationVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowevacuationVector::to_string(self : GraphflowevacuationVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_evacuation_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_evacuation_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_evacuation_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_evacuation_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_evacuation_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_evacuation_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_evacuation_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_evacuation_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_evacuation_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_evacuation_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_evacuation_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_evacuation_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_evacuation_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_evacuation_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_evacuation_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_evacuation_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_evacuation_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_evacuation_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_evacuation_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_evacuation_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_evacuation_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_evacuation_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_evacuation_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_evacuation_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_evacuation_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_evacuation_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_evacuation_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_evacuation_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_evacuation_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowevacuationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_frame_make(size : Int) -> GraphflowevacuationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowevacuationFrame::len(self : GraphflowevacuationFrame) -> Int { self.size }

pub fn GraphflowevacuationFrame::get(self : GraphflowevacuationFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowevacuationFrame::set(self : GraphflowevacuationFrame, i : Int, v : Double) -> GraphflowevacuationFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationFrame::sum(self : GraphflowevacuationFrame) -> Double { @_common.sum(self.data) }

pub fn GraphflowevacuationFrame::mean(self : GraphflowevacuationFrame) -> Double { @_common.mean(self.data) }

pub fn GraphflowevacuationFrame::scale(self : GraphflowevacuationFrame, f : Double) -> GraphflowevacuationFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationFrame::add(self : GraphflowevacuationFrame, other : GraphflowevacuationFrame) -> GraphflowevacuationFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowevacuationFrame::copy(self : GraphflowevacuationFrame) -> GraphflowevacuationFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationFrame::fill(self : GraphflowevacuationFrame, v : Double) -> GraphflowevacuationFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationFrame::min(self : GraphflowevacuationFrame) -> Double { @_common.min(self.data) }

pub fn GraphflowevacuationFrame::max(self : GraphflowevacuationFrame) -> Double { @_common.max(self.data) }

pub fn GraphflowevacuationFrame::to_string(self : GraphflowevacuationFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_table_make(size : Int) -> GraphflowevacuationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowevacuationTable::len(self : GraphflowevacuationTable) -> Int { self.size }

pub fn GraphflowevacuationTable::get(self : GraphflowevacuationTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowevacuationTable::set(self : GraphflowevacuationTable, i : Int, v : Double) -> GraphflowevacuationTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationTable::sum(self : GraphflowevacuationTable) -> Double { @_common.sum(self.data) }

pub fn GraphflowevacuationTable::mean(self : GraphflowevacuationTable) -> Double { @_common.mean(self.data) }

pub fn GraphflowevacuationTable::scale(self : GraphflowevacuationTable, f : Double) -> GraphflowevacuationTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationTable::add(self : GraphflowevacuationTable, other : GraphflowevacuationTable) -> GraphflowevacuationTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowevacuationTable::copy(self : GraphflowevacuationTable) -> GraphflowevacuationTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationTable::fill(self : GraphflowevacuationTable, v : Double) -> GraphflowevacuationTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationTable::min(self : GraphflowevacuationTable) -> Double { @_common.min(self.data) }

pub fn GraphflowevacuationTable::max(self : GraphflowevacuationTable) -> Double { @_common.max(self.data) }

pub fn GraphflowevacuationTable::to_string(self : GraphflowevacuationTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_graphn_make(size : Int) -> GraphflowevacuationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowevacuationGraphN::len(self : GraphflowevacuationGraphN) -> Int { self.size }

pub fn GraphflowevacuationGraphN::get(self : GraphflowevacuationGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowevacuationGraphN::set(self : GraphflowevacuationGraphN, i : Int, v : Double) -> GraphflowevacuationGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationGraphN::sum(self : GraphflowevacuationGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphflowevacuationGraphN::mean(self : GraphflowevacuationGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphflowevacuationGraphN::scale(self : GraphflowevacuationGraphN, f : Double) -> GraphflowevacuationGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationGraphN::add(self : GraphflowevacuationGraphN, other : GraphflowevacuationGraphN) -> GraphflowevacuationGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowevacuationGraphN::copy(self : GraphflowevacuationGraphN) -> GraphflowevacuationGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationGraphN::fill(self : GraphflowevacuationGraphN, v : Double) -> GraphflowevacuationGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationGraphN::min(self : GraphflowevacuationGraphN) -> Double { @_common.min(self.data) }

pub fn GraphflowevacuationGraphN::max(self : GraphflowevacuationGraphN) -> Double { @_common.max(self.data) }

pub fn GraphflowevacuationGraphN::to_string(self : GraphflowevacuationGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_node_make(size : Int) -> GraphflowevacuationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowevacuationNode::len(self : GraphflowevacuationNode) -> Int { self.size }

pub fn GraphflowevacuationNode::get(self : GraphflowevacuationNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowevacuationNode::set(self : GraphflowevacuationNode, i : Int, v : Double) -> GraphflowevacuationNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationNode::sum(self : GraphflowevacuationNode) -> Double { @_common.sum(self.data) }

pub fn GraphflowevacuationNode::mean(self : GraphflowevacuationNode) -> Double { @_common.mean(self.data) }

pub fn GraphflowevacuationNode::scale(self : GraphflowevacuationNode, f : Double) -> GraphflowevacuationNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationNode::add(self : GraphflowevacuationNode, other : GraphflowevacuationNode) -> GraphflowevacuationNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowevacuationNode::copy(self : GraphflowevacuationNode) -> GraphflowevacuationNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationNode::fill(self : GraphflowevacuationNode, v : Double) -> GraphflowevacuationNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationNode::min(self : GraphflowevacuationNode) -> Double { @_common.min(self.data) }

pub fn GraphflowevacuationNode::max(self : GraphflowevacuationNode) -> Double { @_common.max(self.data) }

pub fn GraphflowevacuationNode::to_string(self : GraphflowevacuationNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_edge_make(size : Int) -> GraphflowevacuationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowevacuationEdge::len(self : GraphflowevacuationEdge) -> Int { self.size }

pub fn GraphflowevacuationEdge::get(self : GraphflowevacuationEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowevacuationEdge::set(self : GraphflowevacuationEdge, i : Int, v : Double) -> GraphflowevacuationEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationEdge::sum(self : GraphflowevacuationEdge) -> Double { @_common.sum(self.data) }

pub fn GraphflowevacuationEdge::mean(self : GraphflowevacuationEdge) -> Double { @_common.mean(self.data) }

pub fn GraphflowevacuationEdge::scale(self : GraphflowevacuationEdge, f : Double) -> GraphflowevacuationEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationEdge::add(self : GraphflowevacuationEdge, other : GraphflowevacuationEdge) -> GraphflowevacuationEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowevacuationEdge::copy(self : GraphflowevacuationEdge) -> GraphflowevacuationEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationEdge::fill(self : GraphflowevacuationEdge, v : Double) -> GraphflowevacuationEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationEdge::min(self : GraphflowevacuationEdge) -> Double { @_common.min(self.data) }

pub fn GraphflowevacuationEdge::max(self : GraphflowevacuationEdge) -> Double { @_common.max(self.data) }

pub fn GraphflowevacuationEdge::to_string(self : GraphflowevacuationEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_path_make(size : Int) -> GraphflowevacuationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowevacuationPath::len(self : GraphflowevacuationPath) -> Int { self.size }

pub fn GraphflowevacuationPath::get(self : GraphflowevacuationPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowevacuationPath::set(self : GraphflowevacuationPath, i : Int, v : Double) -> GraphflowevacuationPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationPath::sum(self : GraphflowevacuationPath) -> Double { @_common.sum(self.data) }

pub fn GraphflowevacuationPath::mean(self : GraphflowevacuationPath) -> Double { @_common.mean(self.data) }

pub fn GraphflowevacuationPath::scale(self : GraphflowevacuationPath, f : Double) -> GraphflowevacuationPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationPath::add(self : GraphflowevacuationPath, other : GraphflowevacuationPath) -> GraphflowevacuationPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowevacuationPath::copy(self : GraphflowevacuationPath) -> GraphflowevacuationPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationPath::fill(self : GraphflowevacuationPath, v : Double) -> GraphflowevacuationPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationPath::min(self : GraphflowevacuationPath) -> Double { @_common.min(self.data) }

pub fn GraphflowevacuationPath::max(self : GraphflowevacuationPath) -> Double { @_common.max(self.data) }

pub fn GraphflowevacuationPath::to_string(self : GraphflowevacuationPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_cluster_make(size : Int) -> GraphflowevacuationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowevacuationCluster::len(self : GraphflowevacuationCluster) -> Int { self.size }

pub fn GraphflowevacuationCluster::get(self : GraphflowevacuationCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowevacuationCluster::set(self : GraphflowevacuationCluster, i : Int, v : Double) -> GraphflowevacuationCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationCluster::sum(self : GraphflowevacuationCluster) -> Double { @_common.sum(self.data) }

pub fn GraphflowevacuationCluster::mean(self : GraphflowevacuationCluster) -> Double { @_common.mean(self.data) }

pub fn GraphflowevacuationCluster::scale(self : GraphflowevacuationCluster, f : Double) -> GraphflowevacuationCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationCluster::add(self : GraphflowevacuationCluster, other : GraphflowevacuationCluster) -> GraphflowevacuationCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowevacuationCluster::copy(self : GraphflowevacuationCluster) -> GraphflowevacuationCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationCluster::fill(self : GraphflowevacuationCluster, v : Double) -> GraphflowevacuationCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationCluster::min(self : GraphflowevacuationCluster) -> Double { @_common.min(self.data) }

pub fn GraphflowevacuationCluster::max(self : GraphflowevacuationCluster) -> Double { @_common.max(self.data) }

pub fn GraphflowevacuationCluster::to_string(self : GraphflowevacuationCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_model_make(size : Int) -> GraphflowevacuationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowevacuationModel::len(self : GraphflowevacuationModel) -> Int { self.size }

pub fn GraphflowevacuationModel::get(self : GraphflowevacuationModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowevacuationModel::set(self : GraphflowevacuationModel, i : Int, v : Double) -> GraphflowevacuationModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationModel::sum(self : GraphflowevacuationModel) -> Double { @_common.sum(self.data) }

pub fn GraphflowevacuationModel::mean(self : GraphflowevacuationModel) -> Double { @_common.mean(self.data) }

pub fn GraphflowevacuationModel::scale(self : GraphflowevacuationModel, f : Double) -> GraphflowevacuationModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationModel::add(self : GraphflowevacuationModel, other : GraphflowevacuationModel) -> GraphflowevacuationModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowevacuationModel::copy(self : GraphflowevacuationModel) -> GraphflowevacuationModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationModel::fill(self : GraphflowevacuationModel, v : Double) -> GraphflowevacuationModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationModel::min(self : GraphflowevacuationModel) -> Double { @_common.min(self.data) }

pub fn GraphflowevacuationModel::max(self : GraphflowevacuationModel) -> Double { @_common.max(self.data) }

pub fn GraphflowevacuationModel::to_string(self : GraphflowevacuationModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_layer_make(size : Int) -> GraphflowevacuationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowevacuationLayer::len(self : GraphflowevacuationLayer) -> Int { self.size }

pub fn GraphflowevacuationLayer::get(self : GraphflowevacuationLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowevacuationLayer::set(self : GraphflowevacuationLayer, i : Int, v : Double) -> GraphflowevacuationLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationLayer::sum(self : GraphflowevacuationLayer) -> Double { @_common.sum(self.data) }

pub fn GraphflowevacuationLayer::mean(self : GraphflowevacuationLayer) -> Double { @_common.mean(self.data) }

pub fn GraphflowevacuationLayer::scale(self : GraphflowevacuationLayer, f : Double) -> GraphflowevacuationLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationLayer::add(self : GraphflowevacuationLayer, other : GraphflowevacuationLayer) -> GraphflowevacuationLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowevacuationLayer::copy(self : GraphflowevacuationLayer) -> GraphflowevacuationLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationLayer::fill(self : GraphflowevacuationLayer, v : Double) -> GraphflowevacuationLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationLayer::min(self : GraphflowevacuationLayer) -> Double { @_common.min(self.data) }

pub fn GraphflowevacuationLayer::max(self : GraphflowevacuationLayer) -> Double { @_common.max(self.data) }

pub fn GraphflowevacuationLayer::to_string(self : GraphflowevacuationLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_buffer_make(size : Int) -> GraphflowevacuationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowevacuationBuffer::len(self : GraphflowevacuationBuffer) -> Int { self.size }

pub fn GraphflowevacuationBuffer::get(self : GraphflowevacuationBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowevacuationBuffer::set(self : GraphflowevacuationBuffer, i : Int, v : Double) -> GraphflowevacuationBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationBuffer::sum(self : GraphflowevacuationBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphflowevacuationBuffer::mean(self : GraphflowevacuationBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphflowevacuationBuffer::scale(self : GraphflowevacuationBuffer, f : Double) -> GraphflowevacuationBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationBuffer::add(self : GraphflowevacuationBuffer, other : GraphflowevacuationBuffer) -> GraphflowevacuationBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowevacuationBuffer::copy(self : GraphflowevacuationBuffer) -> GraphflowevacuationBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationBuffer::fill(self : GraphflowevacuationBuffer, v : Double) -> GraphflowevacuationBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationBuffer::min(self : GraphflowevacuationBuffer) -> Double { @_common.min(self.data) }

pub fn GraphflowevacuationBuffer::max(self : GraphflowevacuationBuffer) -> Double { @_common.max(self.data) }

pub fn GraphflowevacuationBuffer::to_string(self : GraphflowevacuationBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_cursor_make(size : Int) -> GraphflowevacuationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowevacuationCursor::len(self : GraphflowevacuationCursor) -> Int { self.size }

pub fn GraphflowevacuationCursor::get(self : GraphflowevacuationCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowevacuationCursor::set(self : GraphflowevacuationCursor, i : Int, v : Double) -> GraphflowevacuationCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationCursor::sum(self : GraphflowevacuationCursor) -> Double { @_common.sum(self.data) }

pub fn GraphflowevacuationCursor::mean(self : GraphflowevacuationCursor) -> Double { @_common.mean(self.data) }

pub fn GraphflowevacuationCursor::scale(self : GraphflowevacuationCursor, f : Double) -> GraphflowevacuationCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationCursor::add(self : GraphflowevacuationCursor, other : GraphflowevacuationCursor) -> GraphflowevacuationCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowevacuationCursor::copy(self : GraphflowevacuationCursor) -> GraphflowevacuationCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationCursor::fill(self : GraphflowevacuationCursor, v : Double) -> GraphflowevacuationCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationCursor::min(self : GraphflowevacuationCursor) -> Double { @_common.min(self.data) }

pub fn GraphflowevacuationCursor::max(self : GraphflowevacuationCursor) -> Double { @_common.max(self.data) }

pub fn GraphflowevacuationCursor::to_string(self : GraphflowevacuationCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_view_make(size : Int) -> GraphflowevacuationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowevacuationView::len(self : GraphflowevacuationView) -> Int { self.size }

pub fn GraphflowevacuationView::get(self : GraphflowevacuationView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowevacuationView::set(self : GraphflowevacuationView, i : Int, v : Double) -> GraphflowevacuationView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationView::sum(self : GraphflowevacuationView) -> Double { @_common.sum(self.data) }

pub fn GraphflowevacuationView::mean(self : GraphflowevacuationView) -> Double { @_common.mean(self.data) }

pub fn GraphflowevacuationView::scale(self : GraphflowevacuationView, f : Double) -> GraphflowevacuationView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationView::add(self : GraphflowevacuationView, other : GraphflowevacuationView) -> GraphflowevacuationView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowevacuationView::copy(self : GraphflowevacuationView) -> GraphflowevacuationView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationView::fill(self : GraphflowevacuationView, v : Double) -> GraphflowevacuationView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationView::min(self : GraphflowevacuationView) -> Double { @_common.min(self.data) }

pub fn GraphflowevacuationView::max(self : GraphflowevacuationView) -> Double { @_common.max(self.data) }

pub fn GraphflowevacuationView::to_string(self : GraphflowevacuationView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_range_make(size : Int) -> GraphflowevacuationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowevacuationRange::len(self : GraphflowevacuationRange) -> Int { self.size }

pub fn GraphflowevacuationRange::get(self : GraphflowevacuationRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowevacuationRange::set(self : GraphflowevacuationRange, i : Int, v : Double) -> GraphflowevacuationRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationRange::sum(self : GraphflowevacuationRange) -> Double { @_common.sum(self.data) }

pub fn GraphflowevacuationRange::mean(self : GraphflowevacuationRange) -> Double { @_common.mean(self.data) }

pub fn GraphflowevacuationRange::scale(self : GraphflowevacuationRange, f : Double) -> GraphflowevacuationRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationRange::add(self : GraphflowevacuationRange, other : GraphflowevacuationRange) -> GraphflowevacuationRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowevacuationRange::copy(self : GraphflowevacuationRange) -> GraphflowevacuationRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationRange::fill(self : GraphflowevacuationRange, v : Double) -> GraphflowevacuationRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationRange::min(self : GraphflowevacuationRange) -> Double { @_common.min(self.data) }

pub fn GraphflowevacuationRange::max(self : GraphflowevacuationRange) -> Double { @_common.max(self.data) }

pub fn GraphflowevacuationRange::to_string(self : GraphflowevacuationRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_slice_make(size : Int) -> GraphflowevacuationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowevacuationSlice::len(self : GraphflowevacuationSlice) -> Int { self.size }

pub fn GraphflowevacuationSlice::get(self : GraphflowevacuationSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowevacuationSlice::set(self : GraphflowevacuationSlice, i : Int, v : Double) -> GraphflowevacuationSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationSlice::sum(self : GraphflowevacuationSlice) -> Double { @_common.sum(self.data) }

pub fn GraphflowevacuationSlice::mean(self : GraphflowevacuationSlice) -> Double { @_common.mean(self.data) }

pub fn GraphflowevacuationSlice::scale(self : GraphflowevacuationSlice, f : Double) -> GraphflowevacuationSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationSlice::add(self : GraphflowevacuationSlice, other : GraphflowevacuationSlice) -> GraphflowevacuationSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowevacuationSlice::copy(self : GraphflowevacuationSlice) -> GraphflowevacuationSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationSlice::fill(self : GraphflowevacuationSlice, v : Double) -> GraphflowevacuationSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowevacuationSlice::min(self : GraphflowevacuationSlice) -> Double { @_common.min(self.data) }

pub fn GraphflowevacuationSlice::max(self : GraphflowevacuationSlice) -> Double { @_common.max(self.data) }

pub fn GraphflowevacuationSlice::to_string(self : GraphflowevacuationSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

