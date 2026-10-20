///===
/// extcore/finance_time_mgarch

pub(all) struct FinancetimemgarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_mgarch_make_point(x : Double, y : Double) -> FinancetimemgarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_mgarch_make_point3(x : Double, y : Double, z : Double) -> FinancetimemgarchPoint {
  { x, y, z, label: 0 }
}

pub fn FinancetimemgarchPoint::x(self : FinancetimemgarchPoint) -> Double { self.x }

pub fn FinancetimemgarchPoint::y(self : FinancetimemgarchPoint) -> Double { self.y }

pub fn FinancetimemgarchPoint::z(self : FinancetimemgarchPoint) -> Double { self.z }

pub fn FinancetimemgarchPoint::label(self : FinancetimemgarchPoint) -> Int { self.label }

pub fn FinancetimemgarchPoint::dist(self : FinancetimemgarchPoint, other : FinancetimemgarchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancetimemgarchPoint::add(self : FinancetimemgarchPoint, other : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancetimemgarchPoint::sub(self : FinancetimemgarchPoint, other : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancetimemgarchPoint::scale(self : FinancetimemgarchPoint, s : Double) -> FinancetimemgarchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancetimemgarchPoint::dot(self : FinancetimemgarchPoint, other : FinancetimemgarchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancetimemgarchPoint::cross(self : FinancetimemgarchPoint, other : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancetimemgarchPoint::norm(self : FinancetimemgarchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancetimemgarchPoint::normalize(self : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimemgarchPoint::negate(self : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancetimemgarchPoint::mid(self : FinancetimemgarchPoint, other : FinancetimemgarchPoint) -> FinancetimemgarchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancetimemgarchPoint::lerp(self : FinancetimemgarchPoint, other : FinancetimemgarchPoint, t : Double) -> FinancetimemgarchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancetimemgarchPoint::to_string(self : FinancetimemgarchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancetimemgarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_mgarch_make_series(vals : Array[Double], name : String) -> FinancetimemgarchSeries {
  { vals, name, meta: 0 }
}

pub fn FinancetimemgarchSeries::len(self : FinancetimemgarchSeries) -> Int { self.vals.length() }

pub fn FinancetimemgarchSeries::sum(self : FinancetimemgarchSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancetimemgarchSeries::mean(self : FinancetimemgarchSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancetimemgarchSeries::min(self : FinancetimemgarchSeries) -> Double { @_common.min(self.vals) }

pub fn FinancetimemgarchSeries::max(self : FinancetimemgarchSeries) -> Double { @_common.max(self.vals) }

pub fn FinancetimemgarchSeries::range(self : FinancetimemgarchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancetimemgarchSeries::variance(self : FinancetimemgarchSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancetimemgarchSeries::std(self : FinancetimemgarchSeries) -> Double { @_common.std(self.vals) }

pub fn FinancetimemgarchSeries::median(self : FinancetimemgarchSeries) -> Double { @_common.median(self.vals) }

pub fn FinancetimemgarchSeries::scale(self : FinancetimemgarchSeries, f : Double) -> FinancetimemgarchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancetimemgarchSeries::add(self : FinancetimemgarchSeries, other : FinancetimemgarchSeries) -> FinancetimemgarchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancetimemgarchSeries::sub(self : FinancetimemgarchSeries, other : FinancetimemgarchSeries) -> FinancetimemgarchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancetimemgarchSeries::normalize(self : FinancetimemgarchSeries) -> FinancetimemgarchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancetimemgarchSeries::cumsum(self : FinancetimemgarchSeries) -> FinancetimemgarchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancetimemgarchSeries::to_string(self : FinancetimemgarchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimemgarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_mgarch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimemgarchMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn finance_time_mgarch_matrix_identity(n : Int) -> FinancetimemgarchMatrix {
  let m = finance_time_mgarch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancetimemgarchMatrix::get(self : FinancetimemgarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancetimemgarchMatrix::transpose(self : FinancetimemgarchMatrix) -> FinancetimemgarchMatrix {
  let result = finance_time_mgarch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancetimemgarchMatrix::add(self : FinancetimemgarchMatrix, other : FinancetimemgarchMatrix) -> FinancetimemgarchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_time_mgarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancetimemgarchMatrix::scale(self : FinancetimemgarchMatrix, s : Double) -> FinancetimemgarchMatrix {
  let result = finance_time_mgarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancetimemgarchMatrix::multiply(self : FinancetimemgarchMatrix, other : FinancetimemgarchMatrix) -> FinancetimemgarchMatrix {
  if self.cols != other.rows { return finance_time_mgarch_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_time_mgarch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn FinancetimemgarchMatrix::trace(self : FinancetimemgarchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancetimemgarchMatrix::det(self : FinancetimemgarchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancetimemgarchMatrix::norm(self : FinancetimemgarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancetimemgarchMatrix::to_string(self : FinancetimemgarchMatrix) -> String {
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

pub(all) struct FinancetimemgarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_mgarch_make_vector(comps : Array[Double]) -> FinancetimemgarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_mgarch_vector_zero(dim : Int) -> FinancetimemgarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancetimemgarchVector::add(self : FinancetimemgarchVector, other : FinancetimemgarchVector) -> FinancetimemgarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimemgarchVector::sub(self : FinancetimemgarchVector, other : FinancetimemgarchVector) -> FinancetimemgarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimemgarchVector::scale(self : FinancetimemgarchVector, s : Double) -> FinancetimemgarchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancetimemgarchVector::dot(self : FinancetimemgarchVector, other : FinancetimemgarchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancetimemgarchVector::norm(self : FinancetimemgarchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancetimemgarchVector::normalize(self : FinancetimemgarchVector) -> FinancetimemgarchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimemgarchVector::dist(self : FinancetimemgarchVector, other : FinancetimemgarchVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancetimemgarchVector::to_string(self : FinancetimemgarchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimemgarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_frame_make(size : Int) -> FinancetimemgarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimemgarchFrame::len(self : FinancetimemgarchFrame) -> Int { self.size }

pub fn FinancetimemgarchFrame::get(self : FinancetimemgarchFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimemgarchFrame::set(self : FinancetimemgarchFrame, i : Int, v : Double) -> FinancetimemgarchFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchFrame::sum(self : FinancetimemgarchFrame) -> Double { @_common.sum(self.data) }

pub fn FinancetimemgarchFrame::mean(self : FinancetimemgarchFrame) -> Double { @_common.mean(self.data) }

pub fn FinancetimemgarchFrame::scale(self : FinancetimemgarchFrame, f : Double) -> FinancetimemgarchFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchFrame::add(self : FinancetimemgarchFrame, other : FinancetimemgarchFrame) -> FinancetimemgarchFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimemgarchFrame::copy(self : FinancetimemgarchFrame) -> FinancetimemgarchFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchFrame::fill(self : FinancetimemgarchFrame, v : Double) -> FinancetimemgarchFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchFrame::min(self : FinancetimemgarchFrame) -> Double { @_common.min(self.data) }

pub fn FinancetimemgarchFrame::max(self : FinancetimemgarchFrame) -> Double { @_common.max(self.data) }

pub fn FinancetimemgarchFrame::to_string(self : FinancetimemgarchFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_table_make(size : Int) -> FinancetimemgarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimemgarchTable::len(self : FinancetimemgarchTable) -> Int { self.size }

pub fn FinancetimemgarchTable::get(self : FinancetimemgarchTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimemgarchTable::set(self : FinancetimemgarchTable, i : Int, v : Double) -> FinancetimemgarchTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchTable::sum(self : FinancetimemgarchTable) -> Double { @_common.sum(self.data) }

pub fn FinancetimemgarchTable::mean(self : FinancetimemgarchTable) -> Double { @_common.mean(self.data) }

pub fn FinancetimemgarchTable::scale(self : FinancetimemgarchTable, f : Double) -> FinancetimemgarchTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchTable::add(self : FinancetimemgarchTable, other : FinancetimemgarchTable) -> FinancetimemgarchTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimemgarchTable::copy(self : FinancetimemgarchTable) -> FinancetimemgarchTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchTable::fill(self : FinancetimemgarchTable, v : Double) -> FinancetimemgarchTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchTable::min(self : FinancetimemgarchTable) -> Double { @_common.min(self.data) }

pub fn FinancetimemgarchTable::max(self : FinancetimemgarchTable) -> Double { @_common.max(self.data) }

pub fn FinancetimemgarchTable::to_string(self : FinancetimemgarchTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_graphn_make(size : Int) -> FinancetimemgarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimemgarchGraphN::len(self : FinancetimemgarchGraphN) -> Int { self.size }

pub fn FinancetimemgarchGraphN::get(self : FinancetimemgarchGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimemgarchGraphN::set(self : FinancetimemgarchGraphN, i : Int, v : Double) -> FinancetimemgarchGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchGraphN::sum(self : FinancetimemgarchGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancetimemgarchGraphN::mean(self : FinancetimemgarchGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancetimemgarchGraphN::scale(self : FinancetimemgarchGraphN, f : Double) -> FinancetimemgarchGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchGraphN::add(self : FinancetimemgarchGraphN, other : FinancetimemgarchGraphN) -> FinancetimemgarchGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimemgarchGraphN::copy(self : FinancetimemgarchGraphN) -> FinancetimemgarchGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchGraphN::fill(self : FinancetimemgarchGraphN, v : Double) -> FinancetimemgarchGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchGraphN::min(self : FinancetimemgarchGraphN) -> Double { @_common.min(self.data) }

pub fn FinancetimemgarchGraphN::max(self : FinancetimemgarchGraphN) -> Double { @_common.max(self.data) }

pub fn FinancetimemgarchGraphN::to_string(self : FinancetimemgarchGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_node_make(size : Int) -> FinancetimemgarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimemgarchNode::len(self : FinancetimemgarchNode) -> Int { self.size }

pub fn FinancetimemgarchNode::get(self : FinancetimemgarchNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimemgarchNode::set(self : FinancetimemgarchNode, i : Int, v : Double) -> FinancetimemgarchNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchNode::sum(self : FinancetimemgarchNode) -> Double { @_common.sum(self.data) }

pub fn FinancetimemgarchNode::mean(self : FinancetimemgarchNode) -> Double { @_common.mean(self.data) }

pub fn FinancetimemgarchNode::scale(self : FinancetimemgarchNode, f : Double) -> FinancetimemgarchNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchNode::add(self : FinancetimemgarchNode, other : FinancetimemgarchNode) -> FinancetimemgarchNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimemgarchNode::copy(self : FinancetimemgarchNode) -> FinancetimemgarchNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchNode::fill(self : FinancetimemgarchNode, v : Double) -> FinancetimemgarchNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchNode::min(self : FinancetimemgarchNode) -> Double { @_common.min(self.data) }

pub fn FinancetimemgarchNode::max(self : FinancetimemgarchNode) -> Double { @_common.max(self.data) }

pub fn FinancetimemgarchNode::to_string(self : FinancetimemgarchNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_edge_make(size : Int) -> FinancetimemgarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimemgarchEdge::len(self : FinancetimemgarchEdge) -> Int { self.size }

pub fn FinancetimemgarchEdge::get(self : FinancetimemgarchEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimemgarchEdge::set(self : FinancetimemgarchEdge, i : Int, v : Double) -> FinancetimemgarchEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchEdge::sum(self : FinancetimemgarchEdge) -> Double { @_common.sum(self.data) }

pub fn FinancetimemgarchEdge::mean(self : FinancetimemgarchEdge) -> Double { @_common.mean(self.data) }

pub fn FinancetimemgarchEdge::scale(self : FinancetimemgarchEdge, f : Double) -> FinancetimemgarchEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchEdge::add(self : FinancetimemgarchEdge, other : FinancetimemgarchEdge) -> FinancetimemgarchEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimemgarchEdge::copy(self : FinancetimemgarchEdge) -> FinancetimemgarchEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchEdge::fill(self : FinancetimemgarchEdge, v : Double) -> FinancetimemgarchEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchEdge::min(self : FinancetimemgarchEdge) -> Double { @_common.min(self.data) }

pub fn FinancetimemgarchEdge::max(self : FinancetimemgarchEdge) -> Double { @_common.max(self.data) }

pub fn FinancetimemgarchEdge::to_string(self : FinancetimemgarchEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_path_make(size : Int) -> FinancetimemgarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimemgarchPath::len(self : FinancetimemgarchPath) -> Int { self.size }

pub fn FinancetimemgarchPath::get(self : FinancetimemgarchPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimemgarchPath::set(self : FinancetimemgarchPath, i : Int, v : Double) -> FinancetimemgarchPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchPath::sum(self : FinancetimemgarchPath) -> Double { @_common.sum(self.data) }

pub fn FinancetimemgarchPath::mean(self : FinancetimemgarchPath) -> Double { @_common.mean(self.data) }

pub fn FinancetimemgarchPath::scale(self : FinancetimemgarchPath, f : Double) -> FinancetimemgarchPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchPath::add(self : FinancetimemgarchPath, other : FinancetimemgarchPath) -> FinancetimemgarchPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimemgarchPath::copy(self : FinancetimemgarchPath) -> FinancetimemgarchPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchPath::fill(self : FinancetimemgarchPath, v : Double) -> FinancetimemgarchPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchPath::min(self : FinancetimemgarchPath) -> Double { @_common.min(self.data) }

pub fn FinancetimemgarchPath::max(self : FinancetimemgarchPath) -> Double { @_common.max(self.data) }

pub fn FinancetimemgarchPath::to_string(self : FinancetimemgarchPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_cluster_make(size : Int) -> FinancetimemgarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimemgarchCluster::len(self : FinancetimemgarchCluster) -> Int { self.size }

pub fn FinancetimemgarchCluster::get(self : FinancetimemgarchCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimemgarchCluster::set(self : FinancetimemgarchCluster, i : Int, v : Double) -> FinancetimemgarchCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchCluster::sum(self : FinancetimemgarchCluster) -> Double { @_common.sum(self.data) }

pub fn FinancetimemgarchCluster::mean(self : FinancetimemgarchCluster) -> Double { @_common.mean(self.data) }

pub fn FinancetimemgarchCluster::scale(self : FinancetimemgarchCluster, f : Double) -> FinancetimemgarchCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchCluster::add(self : FinancetimemgarchCluster, other : FinancetimemgarchCluster) -> FinancetimemgarchCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimemgarchCluster::copy(self : FinancetimemgarchCluster) -> FinancetimemgarchCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchCluster::fill(self : FinancetimemgarchCluster, v : Double) -> FinancetimemgarchCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchCluster::min(self : FinancetimemgarchCluster) -> Double { @_common.min(self.data) }

pub fn FinancetimemgarchCluster::max(self : FinancetimemgarchCluster) -> Double { @_common.max(self.data) }

pub fn FinancetimemgarchCluster::to_string(self : FinancetimemgarchCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_model_make(size : Int) -> FinancetimemgarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimemgarchModel::len(self : FinancetimemgarchModel) -> Int { self.size }

pub fn FinancetimemgarchModel::get(self : FinancetimemgarchModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimemgarchModel::set(self : FinancetimemgarchModel, i : Int, v : Double) -> FinancetimemgarchModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchModel::sum(self : FinancetimemgarchModel) -> Double { @_common.sum(self.data) }

pub fn FinancetimemgarchModel::mean(self : FinancetimemgarchModel) -> Double { @_common.mean(self.data) }

pub fn FinancetimemgarchModel::scale(self : FinancetimemgarchModel, f : Double) -> FinancetimemgarchModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchModel::add(self : FinancetimemgarchModel, other : FinancetimemgarchModel) -> FinancetimemgarchModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimemgarchModel::copy(self : FinancetimemgarchModel) -> FinancetimemgarchModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchModel::fill(self : FinancetimemgarchModel, v : Double) -> FinancetimemgarchModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchModel::min(self : FinancetimemgarchModel) -> Double { @_common.min(self.data) }

pub fn FinancetimemgarchModel::max(self : FinancetimemgarchModel) -> Double { @_common.max(self.data) }

pub fn FinancetimemgarchModel::to_string(self : FinancetimemgarchModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_layer_make(size : Int) -> FinancetimemgarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimemgarchLayer::len(self : FinancetimemgarchLayer) -> Int { self.size }

pub fn FinancetimemgarchLayer::get(self : FinancetimemgarchLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimemgarchLayer::set(self : FinancetimemgarchLayer, i : Int, v : Double) -> FinancetimemgarchLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchLayer::sum(self : FinancetimemgarchLayer) -> Double { @_common.sum(self.data) }

pub fn FinancetimemgarchLayer::mean(self : FinancetimemgarchLayer) -> Double { @_common.mean(self.data) }

pub fn FinancetimemgarchLayer::scale(self : FinancetimemgarchLayer, f : Double) -> FinancetimemgarchLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchLayer::add(self : FinancetimemgarchLayer, other : FinancetimemgarchLayer) -> FinancetimemgarchLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimemgarchLayer::copy(self : FinancetimemgarchLayer) -> FinancetimemgarchLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchLayer::fill(self : FinancetimemgarchLayer, v : Double) -> FinancetimemgarchLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchLayer::min(self : FinancetimemgarchLayer) -> Double { @_common.min(self.data) }

pub fn FinancetimemgarchLayer::max(self : FinancetimemgarchLayer) -> Double { @_common.max(self.data) }

pub fn FinancetimemgarchLayer::to_string(self : FinancetimemgarchLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_buffer_make(size : Int) -> FinancetimemgarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimemgarchBuffer::len(self : FinancetimemgarchBuffer) -> Int { self.size }

pub fn FinancetimemgarchBuffer::get(self : FinancetimemgarchBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimemgarchBuffer::set(self : FinancetimemgarchBuffer, i : Int, v : Double) -> FinancetimemgarchBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchBuffer::sum(self : FinancetimemgarchBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancetimemgarchBuffer::mean(self : FinancetimemgarchBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancetimemgarchBuffer::scale(self : FinancetimemgarchBuffer, f : Double) -> FinancetimemgarchBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchBuffer::add(self : FinancetimemgarchBuffer, other : FinancetimemgarchBuffer) -> FinancetimemgarchBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimemgarchBuffer::copy(self : FinancetimemgarchBuffer) -> FinancetimemgarchBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchBuffer::fill(self : FinancetimemgarchBuffer, v : Double) -> FinancetimemgarchBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchBuffer::min(self : FinancetimemgarchBuffer) -> Double { @_common.min(self.data) }

pub fn FinancetimemgarchBuffer::max(self : FinancetimemgarchBuffer) -> Double { @_common.max(self.data) }

pub fn FinancetimemgarchBuffer::to_string(self : FinancetimemgarchBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_cursor_make(size : Int) -> FinancetimemgarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimemgarchCursor::len(self : FinancetimemgarchCursor) -> Int { self.size }

pub fn FinancetimemgarchCursor::get(self : FinancetimemgarchCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimemgarchCursor::set(self : FinancetimemgarchCursor, i : Int, v : Double) -> FinancetimemgarchCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchCursor::sum(self : FinancetimemgarchCursor) -> Double { @_common.sum(self.data) }

pub fn FinancetimemgarchCursor::mean(self : FinancetimemgarchCursor) -> Double { @_common.mean(self.data) }

pub fn FinancetimemgarchCursor::scale(self : FinancetimemgarchCursor, f : Double) -> FinancetimemgarchCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchCursor::add(self : FinancetimemgarchCursor, other : FinancetimemgarchCursor) -> FinancetimemgarchCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimemgarchCursor::copy(self : FinancetimemgarchCursor) -> FinancetimemgarchCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchCursor::fill(self : FinancetimemgarchCursor, v : Double) -> FinancetimemgarchCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchCursor::min(self : FinancetimemgarchCursor) -> Double { @_common.min(self.data) }

pub fn FinancetimemgarchCursor::max(self : FinancetimemgarchCursor) -> Double { @_common.max(self.data) }

pub fn FinancetimemgarchCursor::to_string(self : FinancetimemgarchCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_view_make(size : Int) -> FinancetimemgarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimemgarchView::len(self : FinancetimemgarchView) -> Int { self.size }

pub fn FinancetimemgarchView::get(self : FinancetimemgarchView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimemgarchView::set(self : FinancetimemgarchView, i : Int, v : Double) -> FinancetimemgarchView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchView::sum(self : FinancetimemgarchView) -> Double { @_common.sum(self.data) }

pub fn FinancetimemgarchView::mean(self : FinancetimemgarchView) -> Double { @_common.mean(self.data) }

pub fn FinancetimemgarchView::scale(self : FinancetimemgarchView, f : Double) -> FinancetimemgarchView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchView::add(self : FinancetimemgarchView, other : FinancetimemgarchView) -> FinancetimemgarchView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimemgarchView::copy(self : FinancetimemgarchView) -> FinancetimemgarchView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchView::fill(self : FinancetimemgarchView, v : Double) -> FinancetimemgarchView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchView::min(self : FinancetimemgarchView) -> Double { @_common.min(self.data) }

pub fn FinancetimemgarchView::max(self : FinancetimemgarchView) -> Double { @_common.max(self.data) }

pub fn FinancetimemgarchView::to_string(self : FinancetimemgarchView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_range_make(size : Int) -> FinancetimemgarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimemgarchRange::len(self : FinancetimemgarchRange) -> Int { self.size }

pub fn FinancetimemgarchRange::get(self : FinancetimemgarchRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimemgarchRange::set(self : FinancetimemgarchRange, i : Int, v : Double) -> FinancetimemgarchRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchRange::sum(self : FinancetimemgarchRange) -> Double { @_common.sum(self.data) }

pub fn FinancetimemgarchRange::mean(self : FinancetimemgarchRange) -> Double { @_common.mean(self.data) }

pub fn FinancetimemgarchRange::scale(self : FinancetimemgarchRange, f : Double) -> FinancetimemgarchRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchRange::add(self : FinancetimemgarchRange, other : FinancetimemgarchRange) -> FinancetimemgarchRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimemgarchRange::copy(self : FinancetimemgarchRange) -> FinancetimemgarchRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchRange::fill(self : FinancetimemgarchRange, v : Double) -> FinancetimemgarchRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchRange::min(self : FinancetimemgarchRange) -> Double { @_common.min(self.data) }

pub fn FinancetimemgarchRange::max(self : FinancetimemgarchRange) -> Double { @_common.max(self.data) }

pub fn FinancetimemgarchRange::to_string(self : FinancetimemgarchRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimemgarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_mgarch_slice_make(size : Int) -> FinancetimemgarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimemgarchSlice::len(self : FinancetimemgarchSlice) -> Int { self.size }

pub fn FinancetimemgarchSlice::get(self : FinancetimemgarchSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimemgarchSlice::set(self : FinancetimemgarchSlice, i : Int, v : Double) -> FinancetimemgarchSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchSlice::sum(self : FinancetimemgarchSlice) -> Double { @_common.sum(self.data) }

pub fn FinancetimemgarchSlice::mean(self : FinancetimemgarchSlice) -> Double { @_common.mean(self.data) }

pub fn FinancetimemgarchSlice::scale(self : FinancetimemgarchSlice, f : Double) -> FinancetimemgarchSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchSlice::add(self : FinancetimemgarchSlice, other : FinancetimemgarchSlice) -> FinancetimemgarchSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimemgarchSlice::copy(self : FinancetimemgarchSlice) -> FinancetimemgarchSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchSlice::fill(self : FinancetimemgarchSlice, v : Double) -> FinancetimemgarchSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimemgarchSlice::min(self : FinancetimemgarchSlice) -> Double { @_common.min(self.data) }

pub fn FinancetimemgarchSlice::max(self : FinancetimemgarchSlice) -> Double { @_common.max(self.data) }

pub fn FinancetimemgarchSlice::to_string(self : FinancetimemgarchSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

