///===
/// extcore/finance_time_tgarch

pub(all) struct FinancetimetgarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_tgarch_make_point(x : Double, y : Double) -> FinancetimetgarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_tgarch_make_point3(x : Double, y : Double, z : Double) -> FinancetimetgarchPoint {
  { x, y, z, label: 0 }
}

pub fn FinancetimetgarchPoint::x(self : FinancetimetgarchPoint) -> Double { self.x }

pub fn FinancetimetgarchPoint::y(self : FinancetimetgarchPoint) -> Double { self.y }

pub fn FinancetimetgarchPoint::z(self : FinancetimetgarchPoint) -> Double { self.z }

pub fn FinancetimetgarchPoint::label(self : FinancetimetgarchPoint) -> Int { self.label }

pub fn FinancetimetgarchPoint::dist(self : FinancetimetgarchPoint, other : FinancetimetgarchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancetimetgarchPoint::add(self : FinancetimetgarchPoint, other : FinancetimetgarchPoint) -> FinancetimetgarchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancetimetgarchPoint::sub(self : FinancetimetgarchPoint, other : FinancetimetgarchPoint) -> FinancetimetgarchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancetimetgarchPoint::scale(self : FinancetimetgarchPoint, s : Double) -> FinancetimetgarchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancetimetgarchPoint::dot(self : FinancetimetgarchPoint, other : FinancetimetgarchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancetimetgarchPoint::cross(self : FinancetimetgarchPoint, other : FinancetimetgarchPoint) -> FinancetimetgarchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancetimetgarchPoint::norm(self : FinancetimetgarchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancetimetgarchPoint::normalize(self : FinancetimetgarchPoint) -> FinancetimetgarchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimetgarchPoint::negate(self : FinancetimetgarchPoint) -> FinancetimetgarchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancetimetgarchPoint::mid(self : FinancetimetgarchPoint, other : FinancetimetgarchPoint) -> FinancetimetgarchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancetimetgarchPoint::lerp(self : FinancetimetgarchPoint, other : FinancetimetgarchPoint, t : Double) -> FinancetimetgarchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancetimetgarchPoint::to_string(self : FinancetimetgarchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancetimetgarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_tgarch_make_series(vals : Array[Double], name : String) -> FinancetimetgarchSeries {
  { vals, name, meta: 0 }
}

pub fn FinancetimetgarchSeries::len(self : FinancetimetgarchSeries) -> Int { self.vals.length() }

pub fn FinancetimetgarchSeries::sum(self : FinancetimetgarchSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancetimetgarchSeries::mean(self : FinancetimetgarchSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancetimetgarchSeries::min(self : FinancetimetgarchSeries) -> Double { @_common.min(self.vals) }

pub fn FinancetimetgarchSeries::max(self : FinancetimetgarchSeries) -> Double { @_common.max(self.vals) }

pub fn FinancetimetgarchSeries::range(self : FinancetimetgarchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancetimetgarchSeries::variance(self : FinancetimetgarchSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancetimetgarchSeries::std(self : FinancetimetgarchSeries) -> Double { @_common.std(self.vals) }

pub fn FinancetimetgarchSeries::median(self : FinancetimetgarchSeries) -> Double { @_common.median(self.vals) }

pub fn FinancetimetgarchSeries::scale(self : FinancetimetgarchSeries, f : Double) -> FinancetimetgarchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancetimetgarchSeries::add(self : FinancetimetgarchSeries, other : FinancetimetgarchSeries) -> FinancetimetgarchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancetimetgarchSeries::sub(self : FinancetimetgarchSeries, other : FinancetimetgarchSeries) -> FinancetimetgarchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancetimetgarchSeries::normalize(self : FinancetimetgarchSeries) -> FinancetimetgarchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancetimetgarchSeries::cumsum(self : FinancetimetgarchSeries) -> FinancetimetgarchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancetimetgarchSeries::to_string(self : FinancetimetgarchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimetgarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_tgarch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimetgarchMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn finance_time_tgarch_matrix_identity(n : Int) -> FinancetimetgarchMatrix {
  let m = finance_time_tgarch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancetimetgarchMatrix::get(self : FinancetimetgarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancetimetgarchMatrix::transpose(self : FinancetimetgarchMatrix) -> FinancetimetgarchMatrix {
  let result = finance_time_tgarch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancetimetgarchMatrix::add(self : FinancetimetgarchMatrix, other : FinancetimetgarchMatrix) -> FinancetimetgarchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_time_tgarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancetimetgarchMatrix::scale(self : FinancetimetgarchMatrix, s : Double) -> FinancetimetgarchMatrix {
  let result = finance_time_tgarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancetimetgarchMatrix::multiply(self : FinancetimetgarchMatrix, other : FinancetimetgarchMatrix) -> FinancetimetgarchMatrix {
  if self.cols != other.rows { return finance_time_tgarch_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_time_tgarch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn FinancetimetgarchMatrix::trace(self : FinancetimetgarchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancetimetgarchMatrix::det(self : FinancetimetgarchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancetimetgarchMatrix::norm(self : FinancetimetgarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancetimetgarchMatrix::to_string(self : FinancetimetgarchMatrix) -> String {
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

pub(all) struct FinancetimetgarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_tgarch_make_vector(comps : Array[Double]) -> FinancetimetgarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_tgarch_vector_zero(dim : Int) -> FinancetimetgarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancetimetgarchVector::add(self : FinancetimetgarchVector, other : FinancetimetgarchVector) -> FinancetimetgarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimetgarchVector::sub(self : FinancetimetgarchVector, other : FinancetimetgarchVector) -> FinancetimetgarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimetgarchVector::scale(self : FinancetimetgarchVector, s : Double) -> FinancetimetgarchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancetimetgarchVector::dot(self : FinancetimetgarchVector, other : FinancetimetgarchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancetimetgarchVector::norm(self : FinancetimetgarchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancetimetgarchVector::normalize(self : FinancetimetgarchVector) -> FinancetimetgarchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimetgarchVector::dist(self : FinancetimetgarchVector, other : FinancetimetgarchVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancetimetgarchVector::to_string(self : FinancetimetgarchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimetgarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_frame_make(size : Int) -> FinancetimetgarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimetgarchFrame::len(self : FinancetimetgarchFrame) -> Int { self.size }

pub fn FinancetimetgarchFrame::get(self : FinancetimetgarchFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimetgarchFrame::set(self : FinancetimetgarchFrame, i : Int, v : Double) -> FinancetimetgarchFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchFrame::sum(self : FinancetimetgarchFrame) -> Double { @_common.sum(self.data) }

pub fn FinancetimetgarchFrame::mean(self : FinancetimetgarchFrame) -> Double { @_common.mean(self.data) }

pub fn FinancetimetgarchFrame::scale(self : FinancetimetgarchFrame, f : Double) -> FinancetimetgarchFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchFrame::add(self : FinancetimetgarchFrame, other : FinancetimetgarchFrame) -> FinancetimetgarchFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimetgarchFrame::copy(self : FinancetimetgarchFrame) -> FinancetimetgarchFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchFrame::fill(self : FinancetimetgarchFrame, v : Double) -> FinancetimetgarchFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchFrame::min(self : FinancetimetgarchFrame) -> Double { @_common.min(self.data) }

pub fn FinancetimetgarchFrame::max(self : FinancetimetgarchFrame) -> Double { @_common.max(self.data) }

pub fn FinancetimetgarchFrame::to_string(self : FinancetimetgarchFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_table_make(size : Int) -> FinancetimetgarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimetgarchTable::len(self : FinancetimetgarchTable) -> Int { self.size }

pub fn FinancetimetgarchTable::get(self : FinancetimetgarchTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimetgarchTable::set(self : FinancetimetgarchTable, i : Int, v : Double) -> FinancetimetgarchTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchTable::sum(self : FinancetimetgarchTable) -> Double { @_common.sum(self.data) }

pub fn FinancetimetgarchTable::mean(self : FinancetimetgarchTable) -> Double { @_common.mean(self.data) }

pub fn FinancetimetgarchTable::scale(self : FinancetimetgarchTable, f : Double) -> FinancetimetgarchTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchTable::add(self : FinancetimetgarchTable, other : FinancetimetgarchTable) -> FinancetimetgarchTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimetgarchTable::copy(self : FinancetimetgarchTable) -> FinancetimetgarchTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchTable::fill(self : FinancetimetgarchTable, v : Double) -> FinancetimetgarchTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchTable::min(self : FinancetimetgarchTable) -> Double { @_common.min(self.data) }

pub fn FinancetimetgarchTable::max(self : FinancetimetgarchTable) -> Double { @_common.max(self.data) }

pub fn FinancetimetgarchTable::to_string(self : FinancetimetgarchTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_graphn_make(size : Int) -> FinancetimetgarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimetgarchGraphN::len(self : FinancetimetgarchGraphN) -> Int { self.size }

pub fn FinancetimetgarchGraphN::get(self : FinancetimetgarchGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimetgarchGraphN::set(self : FinancetimetgarchGraphN, i : Int, v : Double) -> FinancetimetgarchGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchGraphN::sum(self : FinancetimetgarchGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancetimetgarchGraphN::mean(self : FinancetimetgarchGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancetimetgarchGraphN::scale(self : FinancetimetgarchGraphN, f : Double) -> FinancetimetgarchGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchGraphN::add(self : FinancetimetgarchGraphN, other : FinancetimetgarchGraphN) -> FinancetimetgarchGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimetgarchGraphN::copy(self : FinancetimetgarchGraphN) -> FinancetimetgarchGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchGraphN::fill(self : FinancetimetgarchGraphN, v : Double) -> FinancetimetgarchGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchGraphN::min(self : FinancetimetgarchGraphN) -> Double { @_common.min(self.data) }

pub fn FinancetimetgarchGraphN::max(self : FinancetimetgarchGraphN) -> Double { @_common.max(self.data) }

pub fn FinancetimetgarchGraphN::to_string(self : FinancetimetgarchGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_node_make(size : Int) -> FinancetimetgarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimetgarchNode::len(self : FinancetimetgarchNode) -> Int { self.size }

pub fn FinancetimetgarchNode::get(self : FinancetimetgarchNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimetgarchNode::set(self : FinancetimetgarchNode, i : Int, v : Double) -> FinancetimetgarchNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchNode::sum(self : FinancetimetgarchNode) -> Double { @_common.sum(self.data) }

pub fn FinancetimetgarchNode::mean(self : FinancetimetgarchNode) -> Double { @_common.mean(self.data) }

pub fn FinancetimetgarchNode::scale(self : FinancetimetgarchNode, f : Double) -> FinancetimetgarchNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchNode::add(self : FinancetimetgarchNode, other : FinancetimetgarchNode) -> FinancetimetgarchNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimetgarchNode::copy(self : FinancetimetgarchNode) -> FinancetimetgarchNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchNode::fill(self : FinancetimetgarchNode, v : Double) -> FinancetimetgarchNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchNode::min(self : FinancetimetgarchNode) -> Double { @_common.min(self.data) }

pub fn FinancetimetgarchNode::max(self : FinancetimetgarchNode) -> Double { @_common.max(self.data) }

pub fn FinancetimetgarchNode::to_string(self : FinancetimetgarchNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_edge_make(size : Int) -> FinancetimetgarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimetgarchEdge::len(self : FinancetimetgarchEdge) -> Int { self.size }

pub fn FinancetimetgarchEdge::get(self : FinancetimetgarchEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimetgarchEdge::set(self : FinancetimetgarchEdge, i : Int, v : Double) -> FinancetimetgarchEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchEdge::sum(self : FinancetimetgarchEdge) -> Double { @_common.sum(self.data) }

pub fn FinancetimetgarchEdge::mean(self : FinancetimetgarchEdge) -> Double { @_common.mean(self.data) }

pub fn FinancetimetgarchEdge::scale(self : FinancetimetgarchEdge, f : Double) -> FinancetimetgarchEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchEdge::add(self : FinancetimetgarchEdge, other : FinancetimetgarchEdge) -> FinancetimetgarchEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimetgarchEdge::copy(self : FinancetimetgarchEdge) -> FinancetimetgarchEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchEdge::fill(self : FinancetimetgarchEdge, v : Double) -> FinancetimetgarchEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchEdge::min(self : FinancetimetgarchEdge) -> Double { @_common.min(self.data) }

pub fn FinancetimetgarchEdge::max(self : FinancetimetgarchEdge) -> Double { @_common.max(self.data) }

pub fn FinancetimetgarchEdge::to_string(self : FinancetimetgarchEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_path_make(size : Int) -> FinancetimetgarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimetgarchPath::len(self : FinancetimetgarchPath) -> Int { self.size }

pub fn FinancetimetgarchPath::get(self : FinancetimetgarchPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimetgarchPath::set(self : FinancetimetgarchPath, i : Int, v : Double) -> FinancetimetgarchPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchPath::sum(self : FinancetimetgarchPath) -> Double { @_common.sum(self.data) }

pub fn FinancetimetgarchPath::mean(self : FinancetimetgarchPath) -> Double { @_common.mean(self.data) }

pub fn FinancetimetgarchPath::scale(self : FinancetimetgarchPath, f : Double) -> FinancetimetgarchPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchPath::add(self : FinancetimetgarchPath, other : FinancetimetgarchPath) -> FinancetimetgarchPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimetgarchPath::copy(self : FinancetimetgarchPath) -> FinancetimetgarchPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchPath::fill(self : FinancetimetgarchPath, v : Double) -> FinancetimetgarchPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchPath::min(self : FinancetimetgarchPath) -> Double { @_common.min(self.data) }

pub fn FinancetimetgarchPath::max(self : FinancetimetgarchPath) -> Double { @_common.max(self.data) }

pub fn FinancetimetgarchPath::to_string(self : FinancetimetgarchPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_cluster_make(size : Int) -> FinancetimetgarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimetgarchCluster::len(self : FinancetimetgarchCluster) -> Int { self.size }

pub fn FinancetimetgarchCluster::get(self : FinancetimetgarchCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimetgarchCluster::set(self : FinancetimetgarchCluster, i : Int, v : Double) -> FinancetimetgarchCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchCluster::sum(self : FinancetimetgarchCluster) -> Double { @_common.sum(self.data) }

pub fn FinancetimetgarchCluster::mean(self : FinancetimetgarchCluster) -> Double { @_common.mean(self.data) }

pub fn FinancetimetgarchCluster::scale(self : FinancetimetgarchCluster, f : Double) -> FinancetimetgarchCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchCluster::add(self : FinancetimetgarchCluster, other : FinancetimetgarchCluster) -> FinancetimetgarchCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimetgarchCluster::copy(self : FinancetimetgarchCluster) -> FinancetimetgarchCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchCluster::fill(self : FinancetimetgarchCluster, v : Double) -> FinancetimetgarchCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchCluster::min(self : FinancetimetgarchCluster) -> Double { @_common.min(self.data) }

pub fn FinancetimetgarchCluster::max(self : FinancetimetgarchCluster) -> Double { @_common.max(self.data) }

pub fn FinancetimetgarchCluster::to_string(self : FinancetimetgarchCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_model_make(size : Int) -> FinancetimetgarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimetgarchModel::len(self : FinancetimetgarchModel) -> Int { self.size }

pub fn FinancetimetgarchModel::get(self : FinancetimetgarchModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimetgarchModel::set(self : FinancetimetgarchModel, i : Int, v : Double) -> FinancetimetgarchModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchModel::sum(self : FinancetimetgarchModel) -> Double { @_common.sum(self.data) }

pub fn FinancetimetgarchModel::mean(self : FinancetimetgarchModel) -> Double { @_common.mean(self.data) }

pub fn FinancetimetgarchModel::scale(self : FinancetimetgarchModel, f : Double) -> FinancetimetgarchModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchModel::add(self : FinancetimetgarchModel, other : FinancetimetgarchModel) -> FinancetimetgarchModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimetgarchModel::copy(self : FinancetimetgarchModel) -> FinancetimetgarchModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchModel::fill(self : FinancetimetgarchModel, v : Double) -> FinancetimetgarchModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchModel::min(self : FinancetimetgarchModel) -> Double { @_common.min(self.data) }

pub fn FinancetimetgarchModel::max(self : FinancetimetgarchModel) -> Double { @_common.max(self.data) }

pub fn FinancetimetgarchModel::to_string(self : FinancetimetgarchModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_layer_make(size : Int) -> FinancetimetgarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimetgarchLayer::len(self : FinancetimetgarchLayer) -> Int { self.size }

pub fn FinancetimetgarchLayer::get(self : FinancetimetgarchLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimetgarchLayer::set(self : FinancetimetgarchLayer, i : Int, v : Double) -> FinancetimetgarchLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchLayer::sum(self : FinancetimetgarchLayer) -> Double { @_common.sum(self.data) }

pub fn FinancetimetgarchLayer::mean(self : FinancetimetgarchLayer) -> Double { @_common.mean(self.data) }

pub fn FinancetimetgarchLayer::scale(self : FinancetimetgarchLayer, f : Double) -> FinancetimetgarchLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchLayer::add(self : FinancetimetgarchLayer, other : FinancetimetgarchLayer) -> FinancetimetgarchLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimetgarchLayer::copy(self : FinancetimetgarchLayer) -> FinancetimetgarchLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchLayer::fill(self : FinancetimetgarchLayer, v : Double) -> FinancetimetgarchLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchLayer::min(self : FinancetimetgarchLayer) -> Double { @_common.min(self.data) }

pub fn FinancetimetgarchLayer::max(self : FinancetimetgarchLayer) -> Double { @_common.max(self.data) }

pub fn FinancetimetgarchLayer::to_string(self : FinancetimetgarchLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_buffer_make(size : Int) -> FinancetimetgarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimetgarchBuffer::len(self : FinancetimetgarchBuffer) -> Int { self.size }

pub fn FinancetimetgarchBuffer::get(self : FinancetimetgarchBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimetgarchBuffer::set(self : FinancetimetgarchBuffer, i : Int, v : Double) -> FinancetimetgarchBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchBuffer::sum(self : FinancetimetgarchBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancetimetgarchBuffer::mean(self : FinancetimetgarchBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancetimetgarchBuffer::scale(self : FinancetimetgarchBuffer, f : Double) -> FinancetimetgarchBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchBuffer::add(self : FinancetimetgarchBuffer, other : FinancetimetgarchBuffer) -> FinancetimetgarchBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimetgarchBuffer::copy(self : FinancetimetgarchBuffer) -> FinancetimetgarchBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchBuffer::fill(self : FinancetimetgarchBuffer, v : Double) -> FinancetimetgarchBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchBuffer::min(self : FinancetimetgarchBuffer) -> Double { @_common.min(self.data) }

pub fn FinancetimetgarchBuffer::max(self : FinancetimetgarchBuffer) -> Double { @_common.max(self.data) }

pub fn FinancetimetgarchBuffer::to_string(self : FinancetimetgarchBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_cursor_make(size : Int) -> FinancetimetgarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimetgarchCursor::len(self : FinancetimetgarchCursor) -> Int { self.size }

pub fn FinancetimetgarchCursor::get(self : FinancetimetgarchCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimetgarchCursor::set(self : FinancetimetgarchCursor, i : Int, v : Double) -> FinancetimetgarchCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchCursor::sum(self : FinancetimetgarchCursor) -> Double { @_common.sum(self.data) }

pub fn FinancetimetgarchCursor::mean(self : FinancetimetgarchCursor) -> Double { @_common.mean(self.data) }

pub fn FinancetimetgarchCursor::scale(self : FinancetimetgarchCursor, f : Double) -> FinancetimetgarchCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchCursor::add(self : FinancetimetgarchCursor, other : FinancetimetgarchCursor) -> FinancetimetgarchCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimetgarchCursor::copy(self : FinancetimetgarchCursor) -> FinancetimetgarchCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchCursor::fill(self : FinancetimetgarchCursor, v : Double) -> FinancetimetgarchCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchCursor::min(self : FinancetimetgarchCursor) -> Double { @_common.min(self.data) }

pub fn FinancetimetgarchCursor::max(self : FinancetimetgarchCursor) -> Double { @_common.max(self.data) }

pub fn FinancetimetgarchCursor::to_string(self : FinancetimetgarchCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_view_make(size : Int) -> FinancetimetgarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimetgarchView::len(self : FinancetimetgarchView) -> Int { self.size }

pub fn FinancetimetgarchView::get(self : FinancetimetgarchView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimetgarchView::set(self : FinancetimetgarchView, i : Int, v : Double) -> FinancetimetgarchView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchView::sum(self : FinancetimetgarchView) -> Double { @_common.sum(self.data) }

pub fn FinancetimetgarchView::mean(self : FinancetimetgarchView) -> Double { @_common.mean(self.data) }

pub fn FinancetimetgarchView::scale(self : FinancetimetgarchView, f : Double) -> FinancetimetgarchView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchView::add(self : FinancetimetgarchView, other : FinancetimetgarchView) -> FinancetimetgarchView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimetgarchView::copy(self : FinancetimetgarchView) -> FinancetimetgarchView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchView::fill(self : FinancetimetgarchView, v : Double) -> FinancetimetgarchView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchView::min(self : FinancetimetgarchView) -> Double { @_common.min(self.data) }

pub fn FinancetimetgarchView::max(self : FinancetimetgarchView) -> Double { @_common.max(self.data) }

pub fn FinancetimetgarchView::to_string(self : FinancetimetgarchView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_range_make(size : Int) -> FinancetimetgarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimetgarchRange::len(self : FinancetimetgarchRange) -> Int { self.size }

pub fn FinancetimetgarchRange::get(self : FinancetimetgarchRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimetgarchRange::set(self : FinancetimetgarchRange, i : Int, v : Double) -> FinancetimetgarchRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchRange::sum(self : FinancetimetgarchRange) -> Double { @_common.sum(self.data) }

pub fn FinancetimetgarchRange::mean(self : FinancetimetgarchRange) -> Double { @_common.mean(self.data) }

pub fn FinancetimetgarchRange::scale(self : FinancetimetgarchRange, f : Double) -> FinancetimetgarchRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchRange::add(self : FinancetimetgarchRange, other : FinancetimetgarchRange) -> FinancetimetgarchRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimetgarchRange::copy(self : FinancetimetgarchRange) -> FinancetimetgarchRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchRange::fill(self : FinancetimetgarchRange, v : Double) -> FinancetimetgarchRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchRange::min(self : FinancetimetgarchRange) -> Double { @_common.min(self.data) }

pub fn FinancetimetgarchRange::max(self : FinancetimetgarchRange) -> Double { @_common.max(self.data) }

pub fn FinancetimetgarchRange::to_string(self : FinancetimetgarchRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimetgarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_tgarch_slice_make(size : Int) -> FinancetimetgarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimetgarchSlice::len(self : FinancetimetgarchSlice) -> Int { self.size }

pub fn FinancetimetgarchSlice::get(self : FinancetimetgarchSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimetgarchSlice::set(self : FinancetimetgarchSlice, i : Int, v : Double) -> FinancetimetgarchSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchSlice::sum(self : FinancetimetgarchSlice) -> Double { @_common.sum(self.data) }

pub fn FinancetimetgarchSlice::mean(self : FinancetimetgarchSlice) -> Double { @_common.mean(self.data) }

pub fn FinancetimetgarchSlice::scale(self : FinancetimetgarchSlice, f : Double) -> FinancetimetgarchSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchSlice::add(self : FinancetimetgarchSlice, other : FinancetimetgarchSlice) -> FinancetimetgarchSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimetgarchSlice::copy(self : FinancetimetgarchSlice) -> FinancetimetgarchSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchSlice::fill(self : FinancetimetgarchSlice, v : Double) -> FinancetimetgarchSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimetgarchSlice::min(self : FinancetimetgarchSlice) -> Double { @_common.min(self.data) }

pub fn FinancetimetgarchSlice::max(self : FinancetimetgarchSlice) -> Double { @_common.max(self.data) }

pub fn FinancetimetgarchSlice::to_string(self : FinancetimetgarchSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

