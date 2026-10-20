///===
/// extcore/finance_time_figarch

pub(all) struct FinancetimefigarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_figarch_make_point(x : Double, y : Double) -> FinancetimefigarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_figarch_make_point3(x : Double, y : Double, z : Double) -> FinancetimefigarchPoint {
  { x, y, z, label: 0 }
}

pub fn FinancetimefigarchPoint::x(self : FinancetimefigarchPoint) -> Double { self.x }

pub fn FinancetimefigarchPoint::y(self : FinancetimefigarchPoint) -> Double { self.y }

pub fn FinancetimefigarchPoint::z(self : FinancetimefigarchPoint) -> Double { self.z }

pub fn FinancetimefigarchPoint::label(self : FinancetimefigarchPoint) -> Int { self.label }

pub fn FinancetimefigarchPoint::dist(self : FinancetimefigarchPoint, other : FinancetimefigarchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancetimefigarchPoint::add(self : FinancetimefigarchPoint, other : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancetimefigarchPoint::sub(self : FinancetimefigarchPoint, other : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancetimefigarchPoint::scale(self : FinancetimefigarchPoint, s : Double) -> FinancetimefigarchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancetimefigarchPoint::dot(self : FinancetimefigarchPoint, other : FinancetimefigarchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancetimefigarchPoint::cross(self : FinancetimefigarchPoint, other : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancetimefigarchPoint::norm(self : FinancetimefigarchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancetimefigarchPoint::normalize(self : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimefigarchPoint::negate(self : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancetimefigarchPoint::mid(self : FinancetimefigarchPoint, other : FinancetimefigarchPoint) -> FinancetimefigarchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancetimefigarchPoint::lerp(self : FinancetimefigarchPoint, other : FinancetimefigarchPoint, t : Double) -> FinancetimefigarchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancetimefigarchPoint::to_string(self : FinancetimefigarchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancetimefigarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_figarch_make_series(vals : Array[Double], name : String) -> FinancetimefigarchSeries {
  { vals, name, meta: 0 }
}

pub fn FinancetimefigarchSeries::len(self : FinancetimefigarchSeries) -> Int { self.vals.length() }

pub fn FinancetimefigarchSeries::sum(self : FinancetimefigarchSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancetimefigarchSeries::mean(self : FinancetimefigarchSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancetimefigarchSeries::min(self : FinancetimefigarchSeries) -> Double { @_common.min(self.vals) }

pub fn FinancetimefigarchSeries::max(self : FinancetimefigarchSeries) -> Double { @_common.max(self.vals) }

pub fn FinancetimefigarchSeries::range(self : FinancetimefigarchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancetimefigarchSeries::variance(self : FinancetimefigarchSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancetimefigarchSeries::std(self : FinancetimefigarchSeries) -> Double { @_common.std(self.vals) }

pub fn FinancetimefigarchSeries::median(self : FinancetimefigarchSeries) -> Double { @_common.median(self.vals) }

pub fn FinancetimefigarchSeries::scale(self : FinancetimefigarchSeries, f : Double) -> FinancetimefigarchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancetimefigarchSeries::add(self : FinancetimefigarchSeries, other : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancetimefigarchSeries::sub(self : FinancetimefigarchSeries, other : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancetimefigarchSeries::normalize(self : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancetimefigarchSeries::cumsum(self : FinancetimefigarchSeries) -> FinancetimefigarchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancetimefigarchSeries::to_string(self : FinancetimefigarchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimefigarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_figarch_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimefigarchMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn finance_time_figarch_matrix_identity(n : Int) -> FinancetimefigarchMatrix {
  let m = finance_time_figarch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancetimefigarchMatrix::get(self : FinancetimefigarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancetimefigarchMatrix::transpose(self : FinancetimefigarchMatrix) -> FinancetimefigarchMatrix {
  let result = finance_time_figarch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancetimefigarchMatrix::add(self : FinancetimefigarchMatrix, other : FinancetimefigarchMatrix) -> FinancetimefigarchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_time_figarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancetimefigarchMatrix::scale(self : FinancetimefigarchMatrix, s : Double) -> FinancetimefigarchMatrix {
  let result = finance_time_figarch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancetimefigarchMatrix::multiply(self : FinancetimefigarchMatrix, other : FinancetimefigarchMatrix) -> FinancetimefigarchMatrix {
  if self.cols != other.rows { return finance_time_figarch_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_time_figarch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn FinancetimefigarchMatrix::trace(self : FinancetimefigarchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancetimefigarchMatrix::det(self : FinancetimefigarchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancetimefigarchMatrix::norm(self : FinancetimefigarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancetimefigarchMatrix::to_string(self : FinancetimefigarchMatrix) -> String {
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

pub(all) struct FinancetimefigarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_figarch_make_vector(comps : Array[Double]) -> FinancetimefigarchVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_figarch_vector_zero(dim : Int) -> FinancetimefigarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancetimefigarchVector::add(self : FinancetimefigarchVector, other : FinancetimefigarchVector) -> FinancetimefigarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimefigarchVector::sub(self : FinancetimefigarchVector, other : FinancetimefigarchVector) -> FinancetimefigarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimefigarchVector::scale(self : FinancetimefigarchVector, s : Double) -> FinancetimefigarchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancetimefigarchVector::dot(self : FinancetimefigarchVector, other : FinancetimefigarchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancetimefigarchVector::norm(self : FinancetimefigarchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancetimefigarchVector::normalize(self : FinancetimefigarchVector) -> FinancetimefigarchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimefigarchVector::dist(self : FinancetimefigarchVector, other : FinancetimefigarchVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancetimefigarchVector::to_string(self : FinancetimefigarchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimefigarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_frame_make(size : Int) -> FinancetimefigarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimefigarchFrame::len(self : FinancetimefigarchFrame) -> Int { self.size }

pub fn FinancetimefigarchFrame::get(self : FinancetimefigarchFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimefigarchFrame::set(self : FinancetimefigarchFrame, i : Int, v : Double) -> FinancetimefigarchFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchFrame::sum(self : FinancetimefigarchFrame) -> Double { @_common.sum(self.data) }

pub fn FinancetimefigarchFrame::mean(self : FinancetimefigarchFrame) -> Double { @_common.mean(self.data) }

pub fn FinancetimefigarchFrame::scale(self : FinancetimefigarchFrame, f : Double) -> FinancetimefigarchFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchFrame::add(self : FinancetimefigarchFrame, other : FinancetimefigarchFrame) -> FinancetimefigarchFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimefigarchFrame::copy(self : FinancetimefigarchFrame) -> FinancetimefigarchFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchFrame::fill(self : FinancetimefigarchFrame, v : Double) -> FinancetimefigarchFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchFrame::min(self : FinancetimefigarchFrame) -> Double { @_common.min(self.data) }

pub fn FinancetimefigarchFrame::max(self : FinancetimefigarchFrame) -> Double { @_common.max(self.data) }

pub fn FinancetimefigarchFrame::to_string(self : FinancetimefigarchFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_table_make(size : Int) -> FinancetimefigarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimefigarchTable::len(self : FinancetimefigarchTable) -> Int { self.size }

pub fn FinancetimefigarchTable::get(self : FinancetimefigarchTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimefigarchTable::set(self : FinancetimefigarchTable, i : Int, v : Double) -> FinancetimefigarchTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchTable::sum(self : FinancetimefigarchTable) -> Double { @_common.sum(self.data) }

pub fn FinancetimefigarchTable::mean(self : FinancetimefigarchTable) -> Double { @_common.mean(self.data) }

pub fn FinancetimefigarchTable::scale(self : FinancetimefigarchTable, f : Double) -> FinancetimefigarchTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchTable::add(self : FinancetimefigarchTable, other : FinancetimefigarchTable) -> FinancetimefigarchTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimefigarchTable::copy(self : FinancetimefigarchTable) -> FinancetimefigarchTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchTable::fill(self : FinancetimefigarchTable, v : Double) -> FinancetimefigarchTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchTable::min(self : FinancetimefigarchTable) -> Double { @_common.min(self.data) }

pub fn FinancetimefigarchTable::max(self : FinancetimefigarchTable) -> Double { @_common.max(self.data) }

pub fn FinancetimefigarchTable::to_string(self : FinancetimefigarchTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_graphn_make(size : Int) -> FinancetimefigarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimefigarchGraphN::len(self : FinancetimefigarchGraphN) -> Int { self.size }

pub fn FinancetimefigarchGraphN::get(self : FinancetimefigarchGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimefigarchGraphN::set(self : FinancetimefigarchGraphN, i : Int, v : Double) -> FinancetimefigarchGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchGraphN::sum(self : FinancetimefigarchGraphN) -> Double { @_common.sum(self.data) }

pub fn FinancetimefigarchGraphN::mean(self : FinancetimefigarchGraphN) -> Double { @_common.mean(self.data) }

pub fn FinancetimefigarchGraphN::scale(self : FinancetimefigarchGraphN, f : Double) -> FinancetimefigarchGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchGraphN::add(self : FinancetimefigarchGraphN, other : FinancetimefigarchGraphN) -> FinancetimefigarchGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimefigarchGraphN::copy(self : FinancetimefigarchGraphN) -> FinancetimefigarchGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchGraphN::fill(self : FinancetimefigarchGraphN, v : Double) -> FinancetimefigarchGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchGraphN::min(self : FinancetimefigarchGraphN) -> Double { @_common.min(self.data) }

pub fn FinancetimefigarchGraphN::max(self : FinancetimefigarchGraphN) -> Double { @_common.max(self.data) }

pub fn FinancetimefigarchGraphN::to_string(self : FinancetimefigarchGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_node_make(size : Int) -> FinancetimefigarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimefigarchNode::len(self : FinancetimefigarchNode) -> Int { self.size }

pub fn FinancetimefigarchNode::get(self : FinancetimefigarchNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimefigarchNode::set(self : FinancetimefigarchNode, i : Int, v : Double) -> FinancetimefigarchNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchNode::sum(self : FinancetimefigarchNode) -> Double { @_common.sum(self.data) }

pub fn FinancetimefigarchNode::mean(self : FinancetimefigarchNode) -> Double { @_common.mean(self.data) }

pub fn FinancetimefigarchNode::scale(self : FinancetimefigarchNode, f : Double) -> FinancetimefigarchNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchNode::add(self : FinancetimefigarchNode, other : FinancetimefigarchNode) -> FinancetimefigarchNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimefigarchNode::copy(self : FinancetimefigarchNode) -> FinancetimefigarchNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchNode::fill(self : FinancetimefigarchNode, v : Double) -> FinancetimefigarchNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchNode::min(self : FinancetimefigarchNode) -> Double { @_common.min(self.data) }

pub fn FinancetimefigarchNode::max(self : FinancetimefigarchNode) -> Double { @_common.max(self.data) }

pub fn FinancetimefigarchNode::to_string(self : FinancetimefigarchNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_edge_make(size : Int) -> FinancetimefigarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimefigarchEdge::len(self : FinancetimefigarchEdge) -> Int { self.size }

pub fn FinancetimefigarchEdge::get(self : FinancetimefigarchEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimefigarchEdge::set(self : FinancetimefigarchEdge, i : Int, v : Double) -> FinancetimefigarchEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchEdge::sum(self : FinancetimefigarchEdge) -> Double { @_common.sum(self.data) }

pub fn FinancetimefigarchEdge::mean(self : FinancetimefigarchEdge) -> Double { @_common.mean(self.data) }

pub fn FinancetimefigarchEdge::scale(self : FinancetimefigarchEdge, f : Double) -> FinancetimefigarchEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchEdge::add(self : FinancetimefigarchEdge, other : FinancetimefigarchEdge) -> FinancetimefigarchEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimefigarchEdge::copy(self : FinancetimefigarchEdge) -> FinancetimefigarchEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchEdge::fill(self : FinancetimefigarchEdge, v : Double) -> FinancetimefigarchEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchEdge::min(self : FinancetimefigarchEdge) -> Double { @_common.min(self.data) }

pub fn FinancetimefigarchEdge::max(self : FinancetimefigarchEdge) -> Double { @_common.max(self.data) }

pub fn FinancetimefigarchEdge::to_string(self : FinancetimefigarchEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_path_make(size : Int) -> FinancetimefigarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimefigarchPath::len(self : FinancetimefigarchPath) -> Int { self.size }

pub fn FinancetimefigarchPath::get(self : FinancetimefigarchPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimefigarchPath::set(self : FinancetimefigarchPath, i : Int, v : Double) -> FinancetimefigarchPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchPath::sum(self : FinancetimefigarchPath) -> Double { @_common.sum(self.data) }

pub fn FinancetimefigarchPath::mean(self : FinancetimefigarchPath) -> Double { @_common.mean(self.data) }

pub fn FinancetimefigarchPath::scale(self : FinancetimefigarchPath, f : Double) -> FinancetimefigarchPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchPath::add(self : FinancetimefigarchPath, other : FinancetimefigarchPath) -> FinancetimefigarchPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimefigarchPath::copy(self : FinancetimefigarchPath) -> FinancetimefigarchPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchPath::fill(self : FinancetimefigarchPath, v : Double) -> FinancetimefigarchPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchPath::min(self : FinancetimefigarchPath) -> Double { @_common.min(self.data) }

pub fn FinancetimefigarchPath::max(self : FinancetimefigarchPath) -> Double { @_common.max(self.data) }

pub fn FinancetimefigarchPath::to_string(self : FinancetimefigarchPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_cluster_make(size : Int) -> FinancetimefigarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimefigarchCluster::len(self : FinancetimefigarchCluster) -> Int { self.size }

pub fn FinancetimefigarchCluster::get(self : FinancetimefigarchCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimefigarchCluster::set(self : FinancetimefigarchCluster, i : Int, v : Double) -> FinancetimefigarchCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchCluster::sum(self : FinancetimefigarchCluster) -> Double { @_common.sum(self.data) }

pub fn FinancetimefigarchCluster::mean(self : FinancetimefigarchCluster) -> Double { @_common.mean(self.data) }

pub fn FinancetimefigarchCluster::scale(self : FinancetimefigarchCluster, f : Double) -> FinancetimefigarchCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchCluster::add(self : FinancetimefigarchCluster, other : FinancetimefigarchCluster) -> FinancetimefigarchCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimefigarchCluster::copy(self : FinancetimefigarchCluster) -> FinancetimefigarchCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchCluster::fill(self : FinancetimefigarchCluster, v : Double) -> FinancetimefigarchCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchCluster::min(self : FinancetimefigarchCluster) -> Double { @_common.min(self.data) }

pub fn FinancetimefigarchCluster::max(self : FinancetimefigarchCluster) -> Double { @_common.max(self.data) }

pub fn FinancetimefigarchCluster::to_string(self : FinancetimefigarchCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_model_make(size : Int) -> FinancetimefigarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimefigarchModel::len(self : FinancetimefigarchModel) -> Int { self.size }

pub fn FinancetimefigarchModel::get(self : FinancetimefigarchModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimefigarchModel::set(self : FinancetimefigarchModel, i : Int, v : Double) -> FinancetimefigarchModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchModel::sum(self : FinancetimefigarchModel) -> Double { @_common.sum(self.data) }

pub fn FinancetimefigarchModel::mean(self : FinancetimefigarchModel) -> Double { @_common.mean(self.data) }

pub fn FinancetimefigarchModel::scale(self : FinancetimefigarchModel, f : Double) -> FinancetimefigarchModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchModel::add(self : FinancetimefigarchModel, other : FinancetimefigarchModel) -> FinancetimefigarchModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimefigarchModel::copy(self : FinancetimefigarchModel) -> FinancetimefigarchModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchModel::fill(self : FinancetimefigarchModel, v : Double) -> FinancetimefigarchModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchModel::min(self : FinancetimefigarchModel) -> Double { @_common.min(self.data) }

pub fn FinancetimefigarchModel::max(self : FinancetimefigarchModel) -> Double { @_common.max(self.data) }

pub fn FinancetimefigarchModel::to_string(self : FinancetimefigarchModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_layer_make(size : Int) -> FinancetimefigarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimefigarchLayer::len(self : FinancetimefigarchLayer) -> Int { self.size }

pub fn FinancetimefigarchLayer::get(self : FinancetimefigarchLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimefigarchLayer::set(self : FinancetimefigarchLayer, i : Int, v : Double) -> FinancetimefigarchLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchLayer::sum(self : FinancetimefigarchLayer) -> Double { @_common.sum(self.data) }

pub fn FinancetimefigarchLayer::mean(self : FinancetimefigarchLayer) -> Double { @_common.mean(self.data) }

pub fn FinancetimefigarchLayer::scale(self : FinancetimefigarchLayer, f : Double) -> FinancetimefigarchLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchLayer::add(self : FinancetimefigarchLayer, other : FinancetimefigarchLayer) -> FinancetimefigarchLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimefigarchLayer::copy(self : FinancetimefigarchLayer) -> FinancetimefigarchLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchLayer::fill(self : FinancetimefigarchLayer, v : Double) -> FinancetimefigarchLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchLayer::min(self : FinancetimefigarchLayer) -> Double { @_common.min(self.data) }

pub fn FinancetimefigarchLayer::max(self : FinancetimefigarchLayer) -> Double { @_common.max(self.data) }

pub fn FinancetimefigarchLayer::to_string(self : FinancetimefigarchLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_buffer_make(size : Int) -> FinancetimefigarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimefigarchBuffer::len(self : FinancetimefigarchBuffer) -> Int { self.size }

pub fn FinancetimefigarchBuffer::get(self : FinancetimefigarchBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimefigarchBuffer::set(self : FinancetimefigarchBuffer, i : Int, v : Double) -> FinancetimefigarchBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchBuffer::sum(self : FinancetimefigarchBuffer) -> Double { @_common.sum(self.data) }

pub fn FinancetimefigarchBuffer::mean(self : FinancetimefigarchBuffer) -> Double { @_common.mean(self.data) }

pub fn FinancetimefigarchBuffer::scale(self : FinancetimefigarchBuffer, f : Double) -> FinancetimefigarchBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchBuffer::add(self : FinancetimefigarchBuffer, other : FinancetimefigarchBuffer) -> FinancetimefigarchBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimefigarchBuffer::copy(self : FinancetimefigarchBuffer) -> FinancetimefigarchBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchBuffer::fill(self : FinancetimefigarchBuffer, v : Double) -> FinancetimefigarchBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchBuffer::min(self : FinancetimefigarchBuffer) -> Double { @_common.min(self.data) }

pub fn FinancetimefigarchBuffer::max(self : FinancetimefigarchBuffer) -> Double { @_common.max(self.data) }

pub fn FinancetimefigarchBuffer::to_string(self : FinancetimefigarchBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_cursor_make(size : Int) -> FinancetimefigarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimefigarchCursor::len(self : FinancetimefigarchCursor) -> Int { self.size }

pub fn FinancetimefigarchCursor::get(self : FinancetimefigarchCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimefigarchCursor::set(self : FinancetimefigarchCursor, i : Int, v : Double) -> FinancetimefigarchCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchCursor::sum(self : FinancetimefigarchCursor) -> Double { @_common.sum(self.data) }

pub fn FinancetimefigarchCursor::mean(self : FinancetimefigarchCursor) -> Double { @_common.mean(self.data) }

pub fn FinancetimefigarchCursor::scale(self : FinancetimefigarchCursor, f : Double) -> FinancetimefigarchCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchCursor::add(self : FinancetimefigarchCursor, other : FinancetimefigarchCursor) -> FinancetimefigarchCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimefigarchCursor::copy(self : FinancetimefigarchCursor) -> FinancetimefigarchCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchCursor::fill(self : FinancetimefigarchCursor, v : Double) -> FinancetimefigarchCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchCursor::min(self : FinancetimefigarchCursor) -> Double { @_common.min(self.data) }

pub fn FinancetimefigarchCursor::max(self : FinancetimefigarchCursor) -> Double { @_common.max(self.data) }

pub fn FinancetimefigarchCursor::to_string(self : FinancetimefigarchCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_view_make(size : Int) -> FinancetimefigarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimefigarchView::len(self : FinancetimefigarchView) -> Int { self.size }

pub fn FinancetimefigarchView::get(self : FinancetimefigarchView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimefigarchView::set(self : FinancetimefigarchView, i : Int, v : Double) -> FinancetimefigarchView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchView::sum(self : FinancetimefigarchView) -> Double { @_common.sum(self.data) }

pub fn FinancetimefigarchView::mean(self : FinancetimefigarchView) -> Double { @_common.mean(self.data) }

pub fn FinancetimefigarchView::scale(self : FinancetimefigarchView, f : Double) -> FinancetimefigarchView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchView::add(self : FinancetimefigarchView, other : FinancetimefigarchView) -> FinancetimefigarchView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimefigarchView::copy(self : FinancetimefigarchView) -> FinancetimefigarchView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchView::fill(self : FinancetimefigarchView, v : Double) -> FinancetimefigarchView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchView::min(self : FinancetimefigarchView) -> Double { @_common.min(self.data) }

pub fn FinancetimefigarchView::max(self : FinancetimefigarchView) -> Double { @_common.max(self.data) }

pub fn FinancetimefigarchView::to_string(self : FinancetimefigarchView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_range_make(size : Int) -> FinancetimefigarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimefigarchRange::len(self : FinancetimefigarchRange) -> Int { self.size }

pub fn FinancetimefigarchRange::get(self : FinancetimefigarchRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimefigarchRange::set(self : FinancetimefigarchRange, i : Int, v : Double) -> FinancetimefigarchRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchRange::sum(self : FinancetimefigarchRange) -> Double { @_common.sum(self.data) }

pub fn FinancetimefigarchRange::mean(self : FinancetimefigarchRange) -> Double { @_common.mean(self.data) }

pub fn FinancetimefigarchRange::scale(self : FinancetimefigarchRange, f : Double) -> FinancetimefigarchRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchRange::add(self : FinancetimefigarchRange, other : FinancetimefigarchRange) -> FinancetimefigarchRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimefigarchRange::copy(self : FinancetimefigarchRange) -> FinancetimefigarchRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchRange::fill(self : FinancetimefigarchRange, v : Double) -> FinancetimefigarchRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchRange::min(self : FinancetimefigarchRange) -> Double { @_common.min(self.data) }

pub fn FinancetimefigarchRange::max(self : FinancetimefigarchRange) -> Double { @_common.max(self.data) }

pub fn FinancetimefigarchRange::to_string(self : FinancetimefigarchRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct FinancetimefigarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_figarch_slice_make(size : Int) -> FinancetimefigarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn FinancetimefigarchSlice::len(self : FinancetimefigarchSlice) -> Int { self.size }

pub fn FinancetimefigarchSlice::get(self : FinancetimefigarchSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn FinancetimefigarchSlice::set(self : FinancetimefigarchSlice, i : Int, v : Double) -> FinancetimefigarchSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchSlice::sum(self : FinancetimefigarchSlice) -> Double { @_common.sum(self.data) }

pub fn FinancetimefigarchSlice::mean(self : FinancetimefigarchSlice) -> Double { @_common.mean(self.data) }

pub fn FinancetimefigarchSlice::scale(self : FinancetimefigarchSlice, f : Double) -> FinancetimefigarchSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchSlice::add(self : FinancetimefigarchSlice, other : FinancetimefigarchSlice) -> FinancetimefigarchSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn FinancetimefigarchSlice::copy(self : FinancetimefigarchSlice) -> FinancetimefigarchSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchSlice::fill(self : FinancetimefigarchSlice, v : Double) -> FinancetimefigarchSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn FinancetimefigarchSlice::min(self : FinancetimefigarchSlice) -> Double { @_common.min(self.data) }

pub fn FinancetimefigarchSlice::max(self : FinancetimefigarchSlice) -> Double { @_common.max(self.data) }

pub fn FinancetimefigarchSlice::to_string(self : FinancetimefigarchSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

