///===
/// extcore/finance_time_egarch

pub(all) struct FinancetimeegarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_egarch_make_point(x : Double, y : Double) -> FinancetimeegarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_egarch_make_point3(x : Double, y : Double, z : Double) -> FinancetimeegarchPoint {
  { x, y, z, label: 0 }
}

pub fn FinancetimeegarchPoint::x(self : FinancetimeegarchPoint) -> Double { self.x }

pub fn FinancetimeegarchPoint::y(self : FinancetimeegarchPoint) -> Double { self.y }

pub fn FinancetimeegarchPoint::z(self : FinancetimeegarchPoint) -> Double { self.z }

pub fn FinancetimeegarchPoint::label(self : FinancetimeegarchPoint) -> Int { self.label }

pub fn FinancetimeegarchPoint::dist(self : FinancetimeegarchPoint, other : FinancetimeegarchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancetimeegarchPoint::add(self : FinancetimeegarchPoint, other : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancetimeegarchPoint::sub(self : FinancetimeegarchPoint, other : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancetimeegarchPoint::scale(self : FinancetimeegarchPoint, s : Double) -> FinancetimeegarchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancetimeegarchPoint::dot(self : FinancetimeegarchPoint, other : FinancetimeegarchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancetimeegarchPoint::cross(self : FinancetimeegarchPoint, other : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancetimeegarchPoint::norm(self : FinancetimeegarchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancetimeegarchPoint::normalize(self : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimeegarchPoint::negate(self : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancetimeegarchPoint::mid(self : FinancetimeegarchPoint, other : FinancetimeegarchPoint) -> FinancetimeegarchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancetimeegarchPoint::lerp(self : FinancetimeegarchPoint, other : FinancetimeegarchPoint, t : Double) -> FinancetimeegarchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancetimeegarchPoint::to_string(self : FinancetimeegarchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancetimeegarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_egarch_make_series(vals : Array[Double], name : String) -> FinancetimeegarchSeries {
  { vals, name, meta: 0 }
}

pub fn FinancetimeegarchSeries::len(self : FinancetimeegarchSeries) -> Int { self.vals.length() }

pub fn FinancetimeegarchSeries::sum(self : FinancetimeegarchSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancetimeegarchSeries::mean(self : FinancetimeegarchSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancetimeegarchSeries::min(self : FinancetimeegarchSeries) -> Double { @_common.min(self.vals) }

pub fn FinancetimeegarchSeries::max(self : FinancetimeegarchSeries) -> Double { @_common.max(self.vals) }

pub fn FinancetimeegarchSeries::range(self : FinancetimeegarchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancetimeegarchSeries::variance(self : FinancetimeegarchSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancetimeegarchSeries::std(self : FinancetimeegarchSeries) -> Double { @_common.std(self.vals) }

pub fn FinancetimeegarchSeries::median(self : FinancetimeegarchSeries) -> Double { @_common.median(self.vals) }

pub fn FinancetimeegarchSeries::scale(self : FinancetimeegarchSeries, f : Double) -> FinancetimeegarchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancetimeegarchSeries::add(self : FinancetimeegarchSeries, other : FinancetimeegarchSeries) -> FinancetimeegarchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancetimeegarchSeries::sub(self : FinancetimeegarchSeries, other : FinancetimeegarchSeries) -> FinancetimeegarchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancetimeegarchSeries::normalize(self : FinancetimeegarchSeries) -> FinancetimeegarchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancetimeegarchSeries::cumsum(self : FinancetimeegarchSeries) -> FinancetimeegarchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancetimeegarchSeries::to_string(self : FinancetimeegarchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimeegarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_egarch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimeegarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_egarch_matrix_identity(n : Int) -> FinancetimeegarchMatrix {
  let m = finance_time_egarch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancetimeegarchMatrix::get(self : FinancetimeegarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancetimeegarchMatrix::transpose(self : FinancetimeegarchMatrix) -> FinancetimeegarchMatrix {
  let result = finance_time_egarch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancetimeegarchMatrix::add(self : FinancetimeegarchMatrix, other : FinancetimeegarchMatrix) -> FinancetimeegarchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_time_egarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancetimeegarchMatrix::scale(self : FinancetimeegarchMatrix, s : Double) -> FinancetimeegarchMatrix {
  let result = finance_time_egarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancetimeegarchMatrix::multiply(self : FinancetimeegarchMatrix, other : FinancetimeegarchMatrix) -> FinancetimeegarchMatrix {
  if self.cols != other.rows { return finance_time_egarch_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_time_egarch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn FinancetimeegarchMatrix::trace(self : FinancetimeegarchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancetimeegarchMatrix::det(self : FinancetimeegarchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancetimeegarchMatrix::norm(self : FinancetimeegarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancetimeegarchMatrix::to_string(self : FinancetimeegarchMatrix) -> String {
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

pub(all) struct FinancetimeegarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_egarch_make_vector(comps : Array[Double]) -> FinancetimeegarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_egarch_vector_zero(dim : Int) -> FinancetimeegarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancetimeegarchVector::add(self : FinancetimeegarchVector, other : FinancetimeegarchVector) -> FinancetimeegarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimeegarchVector::sub(self : FinancetimeegarchVector, other : FinancetimeegarchVector) -> FinancetimeegarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimeegarchVector::scale(self : FinancetimeegarchVector, s : Double) -> FinancetimeegarchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancetimeegarchVector::dot(self : FinancetimeegarchVector, other : FinancetimeegarchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancetimeegarchVector::norm(self : FinancetimeegarchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancetimeegarchVector::normalize(self : FinancetimeegarchVector) -> FinancetimeegarchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimeegarchVector::dist(self : FinancetimeegarchVector, other : FinancetimeegarchVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancetimeegarchVector::to_string(self : FinancetimeegarchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimeegarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_frame_make(size : Int) -> FinancetimeegarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeegarchFrame::len(self : FinancetimeegarchFrame) -> Int { self.size }

pub fn FinancetimeegarchFrame::get(self : FinancetimeegarchFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeegarchFrame::set(self : FinancetimeegarchFrame, i : Int, v : Double) -> FinancetimeegarchFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchFrame::sum(self : FinancetimeegarchFrame) -> Double { @_common.sum(self.data) }

pub fn FinancetimeegarchFrame::mean(self : FinancetimeegarchFrame) -> Double { @_common.mean(self.data) }

pub fn FinancetimeegarchFrame::scale(self : FinancetimeegarchFrame, f : Double) -> FinancetimeegarchFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchFrame::add(self : FinancetimeegarchFrame, other : FinancetimeegarchFrame) -> FinancetimeegarchFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeegarchFrame::copy(self : FinancetimeegarchFrame) -> FinancetimeegarchFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchFrame::fill(self : FinancetimeegarchFrame, v : Double) -> FinancetimeegarchFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchFrame::min(self : FinancetimeegarchFrame) -> Double { @_common.min(self.data) }

pub fn FinancetimeegarchFrame::max(self : FinancetimeegarchFrame) -> Double { @_common.max(self.data) }

pub fn FinancetimeegarchFrame::to_string(self : FinancetimeegarchFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_table_make(size : Int) -> FinancetimeegarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeegarchTable::len(self : FinancetimeegarchTable) -> Int { self.size }

pub fn FinancetimeegarchTable::get(self : FinancetimeegarchTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeegarchTable::set(self : FinancetimeegarchTable, i : Int, v : Double) -> FinancetimeegarchTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchTable::sum(self : FinancetimeegarchTable) -> Double { @_common.sum(self.data) }

pub fn FinancetimeegarchTable::mean(self : FinancetimeegarchTable) -> Double { @_common.mean(self.data) }

pub fn FinancetimeegarchTable::scale(self : FinancetimeegarchTable, f : Double) -> FinancetimeegarchTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchTable::add(self : FinancetimeegarchTable, other : FinancetimeegarchTable) -> FinancetimeegarchTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeegarchTable::copy(self : FinancetimeegarchTable) -> FinancetimeegarchTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchTable::fill(self : FinancetimeegarchTable, v : Double) -> FinancetimeegarchTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchTable::min(self : FinancetimeegarchTable) -> Double { @_common.min(self.data) }

pub fn FinancetimeegarchTable::max(self : FinancetimeegarchTable) -> Double { @_common.max(self.data) }

pub fn FinancetimeegarchTable::to_string(self : FinancetimeegarchTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_graphn_make(size : Int) -> FinancetimeegarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeegarchGraphN::len(self : FinancetimeegarchGraphN) -> Int { self.size }

pub fn FinancetimeegarchGraphN::get(self : FinancetimeegarchGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeegarchGraphN::set(self : FinancetimeegarchGraphN, i : Int, v : Double) -> FinancetimeegarchGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchGraphN::sum(self : FinancetimeegarchGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancetimeegarchGraphN::mean(self : FinancetimeegarchGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancetimeegarchGraphN::scale(self : FinancetimeegarchGraphN, f : Double) -> FinancetimeegarchGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchGraphN::add(self : FinancetimeegarchGraphN, other : FinancetimeegarchGraphN) -> FinancetimeegarchGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeegarchGraphN::copy(self : FinancetimeegarchGraphN) -> FinancetimeegarchGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchGraphN::fill(self : FinancetimeegarchGraphN, v : Double) -> FinancetimeegarchGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchGraphN::min(self : FinancetimeegarchGraphN) -> Double { @_common.min(self.data) }

pub fn FinancetimeegarchGraphN::max(self : FinancetimeegarchGraphN) -> Double { @_common.max(self.data) }

pub fn FinancetimeegarchGraphN::to_string(self : FinancetimeegarchGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_node_make(size : Int) -> FinancetimeegarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeegarchNode::len(self : FinancetimeegarchNode) -> Int { self.size }

pub fn FinancetimeegarchNode::get(self : FinancetimeegarchNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeegarchNode::set(self : FinancetimeegarchNode, i : Int, v : Double) -> FinancetimeegarchNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchNode::sum(self : FinancetimeegarchNode) -> Double { @_common.sum(self.data) }

pub fn FinancetimeegarchNode::mean(self : FinancetimeegarchNode) -> Double { @_common.mean(self.data) }

pub fn FinancetimeegarchNode::scale(self : FinancetimeegarchNode, f : Double) -> FinancetimeegarchNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchNode::add(self : FinancetimeegarchNode, other : FinancetimeegarchNode) -> FinancetimeegarchNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeegarchNode::copy(self : FinancetimeegarchNode) -> FinancetimeegarchNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchNode::fill(self : FinancetimeegarchNode, v : Double) -> FinancetimeegarchNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchNode::min(self : FinancetimeegarchNode) -> Double { @_common.min(self.data) }

pub fn FinancetimeegarchNode::max(self : FinancetimeegarchNode) -> Double { @_common.max(self.data) }

pub fn FinancetimeegarchNode::to_string(self : FinancetimeegarchNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_edge_make(size : Int) -> FinancetimeegarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeegarchEdge::len(self : FinancetimeegarchEdge) -> Int { self.size }

pub fn FinancetimeegarchEdge::get(self : FinancetimeegarchEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeegarchEdge::set(self : FinancetimeegarchEdge, i : Int, v : Double) -> FinancetimeegarchEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchEdge::sum(self : FinancetimeegarchEdge) -> Double { @_common.sum(self.data) }

pub fn FinancetimeegarchEdge::mean(self : FinancetimeegarchEdge) -> Double { @_common.mean(self.data) }

pub fn FinancetimeegarchEdge::scale(self : FinancetimeegarchEdge, f : Double) -> FinancetimeegarchEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchEdge::add(self : FinancetimeegarchEdge, other : FinancetimeegarchEdge) -> FinancetimeegarchEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeegarchEdge::copy(self : FinancetimeegarchEdge) -> FinancetimeegarchEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchEdge::fill(self : FinancetimeegarchEdge, v : Double) -> FinancetimeegarchEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchEdge::min(self : FinancetimeegarchEdge) -> Double { @_common.min(self.data) }

pub fn FinancetimeegarchEdge::max(self : FinancetimeegarchEdge) -> Double { @_common.max(self.data) }

pub fn FinancetimeegarchEdge::to_string(self : FinancetimeegarchEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_path_make(size : Int) -> FinancetimeegarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeegarchPath::len(self : FinancetimeegarchPath) -> Int { self.size }

pub fn FinancetimeegarchPath::get(self : FinancetimeegarchPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeegarchPath::set(self : FinancetimeegarchPath, i : Int, v : Double) -> FinancetimeegarchPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchPath::sum(self : FinancetimeegarchPath) -> Double { @_common.sum(self.data) }

pub fn FinancetimeegarchPath::mean(self : FinancetimeegarchPath) -> Double { @_common.mean(self.data) }

pub fn FinancetimeegarchPath::scale(self : FinancetimeegarchPath, f : Double) -> FinancetimeegarchPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchPath::add(self : FinancetimeegarchPath, other : FinancetimeegarchPath) -> FinancetimeegarchPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeegarchPath::copy(self : FinancetimeegarchPath) -> FinancetimeegarchPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchPath::fill(self : FinancetimeegarchPath, v : Double) -> FinancetimeegarchPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchPath::min(self : FinancetimeegarchPath) -> Double { @_common.min(self.data) }

pub fn FinancetimeegarchPath::max(self : FinancetimeegarchPath) -> Double { @_common.max(self.data) }

pub fn FinancetimeegarchPath::to_string(self : FinancetimeegarchPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_cluster_make(size : Int) -> FinancetimeegarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeegarchCluster::len(self : FinancetimeegarchCluster) -> Int { self.size }

pub fn FinancetimeegarchCluster::get(self : FinancetimeegarchCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeegarchCluster::set(self : FinancetimeegarchCluster, i : Int, v : Double) -> FinancetimeegarchCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchCluster::sum(self : FinancetimeegarchCluster) -> Double { @_common.sum(self.data) }

pub fn FinancetimeegarchCluster::mean(self : FinancetimeegarchCluster) -> Double { @_common.mean(self.data) }

pub fn FinancetimeegarchCluster::scale(self : FinancetimeegarchCluster, f : Double) -> FinancetimeegarchCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchCluster::add(self : FinancetimeegarchCluster, other : FinancetimeegarchCluster) -> FinancetimeegarchCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeegarchCluster::copy(self : FinancetimeegarchCluster) -> FinancetimeegarchCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchCluster::fill(self : FinancetimeegarchCluster, v : Double) -> FinancetimeegarchCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchCluster::min(self : FinancetimeegarchCluster) -> Double { @_common.min(self.data) }

pub fn FinancetimeegarchCluster::max(self : FinancetimeegarchCluster) -> Double { @_common.max(self.data) }

pub fn FinancetimeegarchCluster::to_string(self : FinancetimeegarchCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_model_make(size : Int) -> FinancetimeegarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeegarchModel::len(self : FinancetimeegarchModel) -> Int { self.size }

pub fn FinancetimeegarchModel::get(self : FinancetimeegarchModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeegarchModel::set(self : FinancetimeegarchModel, i : Int, v : Double) -> FinancetimeegarchModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchModel::sum(self : FinancetimeegarchModel) -> Double { @_common.sum(self.data) }

pub fn FinancetimeegarchModel::mean(self : FinancetimeegarchModel) -> Double { @_common.mean(self.data) }

pub fn FinancetimeegarchModel::scale(self : FinancetimeegarchModel, f : Double) -> FinancetimeegarchModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchModel::add(self : FinancetimeegarchModel, other : FinancetimeegarchModel) -> FinancetimeegarchModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeegarchModel::copy(self : FinancetimeegarchModel) -> FinancetimeegarchModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchModel::fill(self : FinancetimeegarchModel, v : Double) -> FinancetimeegarchModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchModel::min(self : FinancetimeegarchModel) -> Double { @_common.min(self.data) }

pub fn FinancetimeegarchModel::max(self : FinancetimeegarchModel) -> Double { @_common.max(self.data) }

pub fn FinancetimeegarchModel::to_string(self : FinancetimeegarchModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_layer_make(size : Int) -> FinancetimeegarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeegarchLayer::len(self : FinancetimeegarchLayer) -> Int { self.size }

pub fn FinancetimeegarchLayer::get(self : FinancetimeegarchLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeegarchLayer::set(self : FinancetimeegarchLayer, i : Int, v : Double) -> FinancetimeegarchLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchLayer::sum(self : FinancetimeegarchLayer) -> Double { @_common.sum(self.data) }

pub fn FinancetimeegarchLayer::mean(self : FinancetimeegarchLayer) -> Double { @_common.mean(self.data) }

pub fn FinancetimeegarchLayer::scale(self : FinancetimeegarchLayer, f : Double) -> FinancetimeegarchLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchLayer::add(self : FinancetimeegarchLayer, other : FinancetimeegarchLayer) -> FinancetimeegarchLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeegarchLayer::copy(self : FinancetimeegarchLayer) -> FinancetimeegarchLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchLayer::fill(self : FinancetimeegarchLayer, v : Double) -> FinancetimeegarchLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchLayer::min(self : FinancetimeegarchLayer) -> Double { @_common.min(self.data) }

pub fn FinancetimeegarchLayer::max(self : FinancetimeegarchLayer) -> Double { @_common.max(self.data) }

pub fn FinancetimeegarchLayer::to_string(self : FinancetimeegarchLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_buffer_make(size : Int) -> FinancetimeegarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeegarchBuffer::len(self : FinancetimeegarchBuffer) -> Int { self.size }

pub fn FinancetimeegarchBuffer::get(self : FinancetimeegarchBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeegarchBuffer::set(self : FinancetimeegarchBuffer, i : Int, v : Double) -> FinancetimeegarchBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchBuffer::sum(self : FinancetimeegarchBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancetimeegarchBuffer::mean(self : FinancetimeegarchBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancetimeegarchBuffer::scale(self : FinancetimeegarchBuffer, f : Double) -> FinancetimeegarchBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchBuffer::add(self : FinancetimeegarchBuffer, other : FinancetimeegarchBuffer) -> FinancetimeegarchBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeegarchBuffer::copy(self : FinancetimeegarchBuffer) -> FinancetimeegarchBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchBuffer::fill(self : FinancetimeegarchBuffer, v : Double) -> FinancetimeegarchBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchBuffer::min(self : FinancetimeegarchBuffer) -> Double { @_common.min(self.data) }

pub fn FinancetimeegarchBuffer::max(self : FinancetimeegarchBuffer) -> Double { @_common.max(self.data) }

pub fn FinancetimeegarchBuffer::to_string(self : FinancetimeegarchBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_cursor_make(size : Int) -> FinancetimeegarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeegarchCursor::len(self : FinancetimeegarchCursor) -> Int { self.size }

pub fn FinancetimeegarchCursor::get(self : FinancetimeegarchCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeegarchCursor::set(self : FinancetimeegarchCursor, i : Int, v : Double) -> FinancetimeegarchCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchCursor::sum(self : FinancetimeegarchCursor) -> Double { @_common.sum(self.data) }

pub fn FinancetimeegarchCursor::mean(self : FinancetimeegarchCursor) -> Double { @_common.mean(self.data) }

pub fn FinancetimeegarchCursor::scale(self : FinancetimeegarchCursor, f : Double) -> FinancetimeegarchCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchCursor::add(self : FinancetimeegarchCursor, other : FinancetimeegarchCursor) -> FinancetimeegarchCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeegarchCursor::copy(self : FinancetimeegarchCursor) -> FinancetimeegarchCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchCursor::fill(self : FinancetimeegarchCursor, v : Double) -> FinancetimeegarchCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchCursor::min(self : FinancetimeegarchCursor) -> Double { @_common.min(self.data) }

pub fn FinancetimeegarchCursor::max(self : FinancetimeegarchCursor) -> Double { @_common.max(self.data) }

pub fn FinancetimeegarchCursor::to_string(self : FinancetimeegarchCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_view_make(size : Int) -> FinancetimeegarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeegarchView::len(self : FinancetimeegarchView) -> Int { self.size }

pub fn FinancetimeegarchView::get(self : FinancetimeegarchView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeegarchView::set(self : FinancetimeegarchView, i : Int, v : Double) -> FinancetimeegarchView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchView::sum(self : FinancetimeegarchView) -> Double { @_common.sum(self.data) }

pub fn FinancetimeegarchView::mean(self : FinancetimeegarchView) -> Double { @_common.mean(self.data) }

pub fn FinancetimeegarchView::scale(self : FinancetimeegarchView, f : Double) -> FinancetimeegarchView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchView::add(self : FinancetimeegarchView, other : FinancetimeegarchView) -> FinancetimeegarchView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeegarchView::copy(self : FinancetimeegarchView) -> FinancetimeegarchView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchView::fill(self : FinancetimeegarchView, v : Double) -> FinancetimeegarchView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchView::min(self : FinancetimeegarchView) -> Double { @_common.min(self.data) }

pub fn FinancetimeegarchView::max(self : FinancetimeegarchView) -> Double { @_common.max(self.data) }

pub fn FinancetimeegarchView::to_string(self : FinancetimeegarchView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_range_make(size : Int) -> FinancetimeegarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeegarchRange::len(self : FinancetimeegarchRange) -> Int { self.size }

pub fn FinancetimeegarchRange::get(self : FinancetimeegarchRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeegarchRange::set(self : FinancetimeegarchRange, i : Int, v : Double) -> FinancetimeegarchRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchRange::sum(self : FinancetimeegarchRange) -> Double { @_common.sum(self.data) }

pub fn FinancetimeegarchRange::mean(self : FinancetimeegarchRange) -> Double { @_common.mean(self.data) }

pub fn FinancetimeegarchRange::scale(self : FinancetimeegarchRange, f : Double) -> FinancetimeegarchRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchRange::add(self : FinancetimeegarchRange, other : FinancetimeegarchRange) -> FinancetimeegarchRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeegarchRange::copy(self : FinancetimeegarchRange) -> FinancetimeegarchRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchRange::fill(self : FinancetimeegarchRange, v : Double) -> FinancetimeegarchRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchRange::min(self : FinancetimeegarchRange) -> Double { @_common.min(self.data) }

pub fn FinancetimeegarchRange::max(self : FinancetimeegarchRange) -> Double { @_common.max(self.data) }

pub fn FinancetimeegarchRange::to_string(self : FinancetimeegarchRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimeegarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_egarch_slice_make(size : Int) -> FinancetimeegarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimeegarchSlice::len(self : FinancetimeegarchSlice) -> Int { self.size }

pub fn FinancetimeegarchSlice::get(self : FinancetimeegarchSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimeegarchSlice::set(self : FinancetimeegarchSlice, i : Int, v : Double) -> FinancetimeegarchSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchSlice::sum(self : FinancetimeegarchSlice) -> Double { @_common.sum(self.data) }

pub fn FinancetimeegarchSlice::mean(self : FinancetimeegarchSlice) -> Double { @_common.mean(self.data) }

pub fn FinancetimeegarchSlice::scale(self : FinancetimeegarchSlice, f : Double) -> FinancetimeegarchSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchSlice::add(self : FinancetimeegarchSlice, other : FinancetimeegarchSlice) -> FinancetimeegarchSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimeegarchSlice::copy(self : FinancetimeegarchSlice) -> FinancetimeegarchSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchSlice::fill(self : FinancetimeegarchSlice, v : Double) -> FinancetimeegarchSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimeegarchSlice::min(self : FinancetimeegarchSlice) -> Double { @_common.min(self.data) }

pub fn FinancetimeegarchSlice::max(self : FinancetimeegarchSlice) -> Double { @_common.max(self.data) }

pub fn FinancetimeegarchSlice::to_string(self : FinancetimeegarchSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

