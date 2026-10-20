///===
/// extcore/timeseries_garch

pub(all) struct TimeseriesgarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_garch_make_point(x : Double, y : Double) -> TimeseriesgarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_garch_make_point3(x : Double, y : Double, z : Double) -> TimeseriesgarchPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesgarchPoint::x(self : TimeseriesgarchPoint) -> Double { self.x }

pub fn TimeseriesgarchPoint::y(self : TimeseriesgarchPoint) -> Double { self.y }

pub fn TimeseriesgarchPoint::z(self : TimeseriesgarchPoint) -> Double { self.z }

pub fn TimeseriesgarchPoint::label(self : TimeseriesgarchPoint) -> Int { self.label }

pub fn TimeseriesgarchPoint::dist(self : TimeseriesgarchPoint, other : TimeseriesgarchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesgarchPoint::add(self : TimeseriesgarchPoint, other : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesgarchPoint::sub(self : TimeseriesgarchPoint, other : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesgarchPoint::scale(self : TimeseriesgarchPoint, s : Double) -> TimeseriesgarchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesgarchPoint::dot(self : TimeseriesgarchPoint, other : TimeseriesgarchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesgarchPoint::cross(self : TimeseriesgarchPoint, other : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesgarchPoint::norm(self : TimeseriesgarchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesgarchPoint::normalize(self : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesgarchPoint::negate(self : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesgarchPoint::mid(self : TimeseriesgarchPoint, other : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesgarchPoint::lerp(self : TimeseriesgarchPoint, other : TimeseriesgarchPoint, t : Double) -> TimeseriesgarchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesgarchPoint::to_string(self : TimeseriesgarchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesgarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_garch_make_series(vals : Array[Double], name : String) -> TimeseriesgarchSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesgarchSeries::len(self : TimeseriesgarchSeries) -> Int { self.vals.length() }

pub fn TimeseriesgarchSeries::sum(self : TimeseriesgarchSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesgarchSeries::mean(self : TimeseriesgarchSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesgarchSeries::min(self : TimeseriesgarchSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesgarchSeries::max(self : TimeseriesgarchSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesgarchSeries::range(self : TimeseriesgarchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesgarchSeries::variance(self : TimeseriesgarchSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesgarchSeries::std(self : TimeseriesgarchSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesgarchSeries::median(self : TimeseriesgarchSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesgarchSeries::scale(self : TimeseriesgarchSeries, f : Double) -> TimeseriesgarchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesgarchSeries::add(self : TimeseriesgarchSeries, other : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesgarchSeries::sub(self : TimeseriesgarchSeries, other : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesgarchSeries::normalize(self : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesgarchSeries::cumsum(self : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesgarchSeries::to_string(self : TimeseriesgarchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesgarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_garch_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesgarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_garch_matrix_identity(n : Int) -> TimeseriesgarchMatrix {
  let m = timeseries_garch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesgarchMatrix::get(self : TimeseriesgarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesgarchMatrix::transpose(self : TimeseriesgarchMatrix) -> TimeseriesgarchMatrix {
  let result = timeseries_garch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesgarchMatrix::add(self : TimeseriesgarchMatrix, other : TimeseriesgarchMatrix) -> TimeseriesgarchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_garch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesgarchMatrix::scale(self : TimeseriesgarchMatrix, s : Double) -> TimeseriesgarchMatrix {
  let result = timeseries_garch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesgarchMatrix::multiply(self : TimeseriesgarchMatrix, other : TimeseriesgarchMatrix) -> TimeseriesgarchMatrix {
  if self.cols != other.rows { return timeseries_garch_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_garch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn TimeseriesgarchMatrix::trace(self : TimeseriesgarchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesgarchMatrix::det(self : TimeseriesgarchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesgarchMatrix::norm(self : TimeseriesgarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesgarchMatrix::to_string(self : TimeseriesgarchMatrix) -> String {
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

pub(all) struct TimeseriesgarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_garch_make_vector(comps : Array[Double]) -> TimeseriesgarchVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_garch_vector_zero(dim : Int) -> TimeseriesgarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesgarchVector::add(self : TimeseriesgarchVector, other : TimeseriesgarchVector) -> TimeseriesgarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesgarchVector::sub(self : TimeseriesgarchVector, other : TimeseriesgarchVector) -> TimeseriesgarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesgarchVector::scale(self : TimeseriesgarchVector, s : Double) -> TimeseriesgarchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesgarchVector::dot(self : TimeseriesgarchVector, other : TimeseriesgarchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesgarchVector::norm(self : TimeseriesgarchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesgarchVector::normalize(self : TimeseriesgarchVector) -> TimeseriesgarchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesgarchVector::dist(self : TimeseriesgarchVector, other : TimeseriesgarchVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesgarchVector::to_string(self : TimeseriesgarchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesgarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_frame_make(size : Int) -> TimeseriesgarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesgarchFrame::len(self : TimeseriesgarchFrame) -> Int { self.size }

pub fn TimeseriesgarchFrame::get(self : TimeseriesgarchFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesgarchFrame::set(self : TimeseriesgarchFrame, i : Int, v : Double) -> TimeseriesgarchFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchFrame::sum(self : TimeseriesgarchFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesgarchFrame::mean(self : TimeseriesgarchFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesgarchFrame::scale(self : TimeseriesgarchFrame, f : Double) -> TimeseriesgarchFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchFrame::add(self : TimeseriesgarchFrame, other : TimeseriesgarchFrame) -> TimeseriesgarchFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesgarchFrame::copy(self : TimeseriesgarchFrame) -> TimeseriesgarchFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchFrame::fill(self : TimeseriesgarchFrame, v : Double) -> TimeseriesgarchFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchFrame::min(self : TimeseriesgarchFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesgarchFrame::max(self : TimeseriesgarchFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesgarchFrame::to_string(self : TimeseriesgarchFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_table_make(size : Int) -> TimeseriesgarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesgarchTable::len(self : TimeseriesgarchTable) -> Int { self.size }

pub fn TimeseriesgarchTable::get(self : TimeseriesgarchTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesgarchTable::set(self : TimeseriesgarchTable, i : Int, v : Double) -> TimeseriesgarchTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchTable::sum(self : TimeseriesgarchTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesgarchTable::mean(self : TimeseriesgarchTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesgarchTable::scale(self : TimeseriesgarchTable, f : Double) -> TimeseriesgarchTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchTable::add(self : TimeseriesgarchTable, other : TimeseriesgarchTable) -> TimeseriesgarchTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesgarchTable::copy(self : TimeseriesgarchTable) -> TimeseriesgarchTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchTable::fill(self : TimeseriesgarchTable, v : Double) -> TimeseriesgarchTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchTable::min(self : TimeseriesgarchTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesgarchTable::max(self : TimeseriesgarchTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesgarchTable::to_string(self : TimeseriesgarchTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_graphn_make(size : Int) -> TimeseriesgarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesgarchGraphN::len(self : TimeseriesgarchGraphN) -> Int { self.size }

pub fn TimeseriesgarchGraphN::get(self : TimeseriesgarchGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesgarchGraphN::set(self : TimeseriesgarchGraphN, i : Int, v : Double) -> TimeseriesgarchGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchGraphN::sum(self : TimeseriesgarchGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesgarchGraphN::mean(self : TimeseriesgarchGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesgarchGraphN::scale(self : TimeseriesgarchGraphN, f : Double) -> TimeseriesgarchGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchGraphN::add(self : TimeseriesgarchGraphN, other : TimeseriesgarchGraphN) -> TimeseriesgarchGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesgarchGraphN::copy(self : TimeseriesgarchGraphN) -> TimeseriesgarchGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchGraphN::fill(self : TimeseriesgarchGraphN, v : Double) -> TimeseriesgarchGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchGraphN::min(self : TimeseriesgarchGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesgarchGraphN::max(self : TimeseriesgarchGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesgarchGraphN::to_string(self : TimeseriesgarchGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_node_make(size : Int) -> TimeseriesgarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesgarchNode::len(self : TimeseriesgarchNode) -> Int { self.size }

pub fn TimeseriesgarchNode::get(self : TimeseriesgarchNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesgarchNode::set(self : TimeseriesgarchNode, i : Int, v : Double) -> TimeseriesgarchNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchNode::sum(self : TimeseriesgarchNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesgarchNode::mean(self : TimeseriesgarchNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesgarchNode::scale(self : TimeseriesgarchNode, f : Double) -> TimeseriesgarchNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchNode::add(self : TimeseriesgarchNode, other : TimeseriesgarchNode) -> TimeseriesgarchNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesgarchNode::copy(self : TimeseriesgarchNode) -> TimeseriesgarchNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchNode::fill(self : TimeseriesgarchNode, v : Double) -> TimeseriesgarchNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchNode::min(self : TimeseriesgarchNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesgarchNode::max(self : TimeseriesgarchNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesgarchNode::to_string(self : TimeseriesgarchNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_edge_make(size : Int) -> TimeseriesgarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesgarchEdge::len(self : TimeseriesgarchEdge) -> Int { self.size }

pub fn TimeseriesgarchEdge::get(self : TimeseriesgarchEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesgarchEdge::set(self : TimeseriesgarchEdge, i : Int, v : Double) -> TimeseriesgarchEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchEdge::sum(self : TimeseriesgarchEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesgarchEdge::mean(self : TimeseriesgarchEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesgarchEdge::scale(self : TimeseriesgarchEdge, f : Double) -> TimeseriesgarchEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchEdge::add(self : TimeseriesgarchEdge, other : TimeseriesgarchEdge) -> TimeseriesgarchEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesgarchEdge::copy(self : TimeseriesgarchEdge) -> TimeseriesgarchEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchEdge::fill(self : TimeseriesgarchEdge, v : Double) -> TimeseriesgarchEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchEdge::min(self : TimeseriesgarchEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesgarchEdge::max(self : TimeseriesgarchEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesgarchEdge::to_string(self : TimeseriesgarchEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_path_make(size : Int) -> TimeseriesgarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesgarchPath::len(self : TimeseriesgarchPath) -> Int { self.size }

pub fn TimeseriesgarchPath::get(self : TimeseriesgarchPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesgarchPath::set(self : TimeseriesgarchPath, i : Int, v : Double) -> TimeseriesgarchPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchPath::sum(self : TimeseriesgarchPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesgarchPath::mean(self : TimeseriesgarchPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesgarchPath::scale(self : TimeseriesgarchPath, f : Double) -> TimeseriesgarchPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchPath::add(self : TimeseriesgarchPath, other : TimeseriesgarchPath) -> TimeseriesgarchPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesgarchPath::copy(self : TimeseriesgarchPath) -> TimeseriesgarchPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchPath::fill(self : TimeseriesgarchPath, v : Double) -> TimeseriesgarchPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchPath::min(self : TimeseriesgarchPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesgarchPath::max(self : TimeseriesgarchPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesgarchPath::to_string(self : TimeseriesgarchPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_cluster_make(size : Int) -> TimeseriesgarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesgarchCluster::len(self : TimeseriesgarchCluster) -> Int { self.size }

pub fn TimeseriesgarchCluster::get(self : TimeseriesgarchCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesgarchCluster::set(self : TimeseriesgarchCluster, i : Int, v : Double) -> TimeseriesgarchCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchCluster::sum(self : TimeseriesgarchCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesgarchCluster::mean(self : TimeseriesgarchCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesgarchCluster::scale(self : TimeseriesgarchCluster, f : Double) -> TimeseriesgarchCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchCluster::add(self : TimeseriesgarchCluster, other : TimeseriesgarchCluster) -> TimeseriesgarchCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesgarchCluster::copy(self : TimeseriesgarchCluster) -> TimeseriesgarchCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchCluster::fill(self : TimeseriesgarchCluster, v : Double) -> TimeseriesgarchCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchCluster::min(self : TimeseriesgarchCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesgarchCluster::max(self : TimeseriesgarchCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesgarchCluster::to_string(self : TimeseriesgarchCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_model_make(size : Int) -> TimeseriesgarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesgarchModel::len(self : TimeseriesgarchModel) -> Int { self.size }

pub fn TimeseriesgarchModel::get(self : TimeseriesgarchModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesgarchModel::set(self : TimeseriesgarchModel, i : Int, v : Double) -> TimeseriesgarchModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchModel::sum(self : TimeseriesgarchModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesgarchModel::mean(self : TimeseriesgarchModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesgarchModel::scale(self : TimeseriesgarchModel, f : Double) -> TimeseriesgarchModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchModel::add(self : TimeseriesgarchModel, other : TimeseriesgarchModel) -> TimeseriesgarchModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesgarchModel::copy(self : TimeseriesgarchModel) -> TimeseriesgarchModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchModel::fill(self : TimeseriesgarchModel, v : Double) -> TimeseriesgarchModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchModel::min(self : TimeseriesgarchModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesgarchModel::max(self : TimeseriesgarchModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesgarchModel::to_string(self : TimeseriesgarchModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_layer_make(size : Int) -> TimeseriesgarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesgarchLayer::len(self : TimeseriesgarchLayer) -> Int { self.size }

pub fn TimeseriesgarchLayer::get(self : TimeseriesgarchLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesgarchLayer::set(self : TimeseriesgarchLayer, i : Int, v : Double) -> TimeseriesgarchLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchLayer::sum(self : TimeseriesgarchLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesgarchLayer::mean(self : TimeseriesgarchLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesgarchLayer::scale(self : TimeseriesgarchLayer, f : Double) -> TimeseriesgarchLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchLayer::add(self : TimeseriesgarchLayer, other : TimeseriesgarchLayer) -> TimeseriesgarchLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesgarchLayer::copy(self : TimeseriesgarchLayer) -> TimeseriesgarchLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchLayer::fill(self : TimeseriesgarchLayer, v : Double) -> TimeseriesgarchLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchLayer::min(self : TimeseriesgarchLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesgarchLayer::max(self : TimeseriesgarchLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesgarchLayer::to_string(self : TimeseriesgarchLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_buffer_make(size : Int) -> TimeseriesgarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesgarchBuffer::len(self : TimeseriesgarchBuffer) -> Int { self.size }

pub fn TimeseriesgarchBuffer::get(self : TimeseriesgarchBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesgarchBuffer::set(self : TimeseriesgarchBuffer, i : Int, v : Double) -> TimeseriesgarchBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchBuffer::sum(self : TimeseriesgarchBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesgarchBuffer::mean(self : TimeseriesgarchBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesgarchBuffer::scale(self : TimeseriesgarchBuffer, f : Double) -> TimeseriesgarchBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchBuffer::add(self : TimeseriesgarchBuffer, other : TimeseriesgarchBuffer) -> TimeseriesgarchBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesgarchBuffer::copy(self : TimeseriesgarchBuffer) -> TimeseriesgarchBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchBuffer::fill(self : TimeseriesgarchBuffer, v : Double) -> TimeseriesgarchBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchBuffer::min(self : TimeseriesgarchBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesgarchBuffer::max(self : TimeseriesgarchBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesgarchBuffer::to_string(self : TimeseriesgarchBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_cursor_make(size : Int) -> TimeseriesgarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesgarchCursor::len(self : TimeseriesgarchCursor) -> Int { self.size }

pub fn TimeseriesgarchCursor::get(self : TimeseriesgarchCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesgarchCursor::set(self : TimeseriesgarchCursor, i : Int, v : Double) -> TimeseriesgarchCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchCursor::sum(self : TimeseriesgarchCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesgarchCursor::mean(self : TimeseriesgarchCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesgarchCursor::scale(self : TimeseriesgarchCursor, f : Double) -> TimeseriesgarchCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchCursor::add(self : TimeseriesgarchCursor, other : TimeseriesgarchCursor) -> TimeseriesgarchCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesgarchCursor::copy(self : TimeseriesgarchCursor) -> TimeseriesgarchCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchCursor::fill(self : TimeseriesgarchCursor, v : Double) -> TimeseriesgarchCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchCursor::min(self : TimeseriesgarchCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesgarchCursor::max(self : TimeseriesgarchCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesgarchCursor::to_string(self : TimeseriesgarchCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_view_make(size : Int) -> TimeseriesgarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesgarchView::len(self : TimeseriesgarchView) -> Int { self.size }

pub fn TimeseriesgarchView::get(self : TimeseriesgarchView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesgarchView::set(self : TimeseriesgarchView, i : Int, v : Double) -> TimeseriesgarchView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchView::sum(self : TimeseriesgarchView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesgarchView::mean(self : TimeseriesgarchView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesgarchView::scale(self : TimeseriesgarchView, f : Double) -> TimeseriesgarchView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchView::add(self : TimeseriesgarchView, other : TimeseriesgarchView) -> TimeseriesgarchView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesgarchView::copy(self : TimeseriesgarchView) -> TimeseriesgarchView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchView::fill(self : TimeseriesgarchView, v : Double) -> TimeseriesgarchView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchView::min(self : TimeseriesgarchView) -> Double { @_common.min(self.data) }

pub fn TimeseriesgarchView::max(self : TimeseriesgarchView) -> Double { @_common.max(self.data) }

pub fn TimeseriesgarchView::to_string(self : TimeseriesgarchView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_range_make(size : Int) -> TimeseriesgarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesgarchRange::len(self : TimeseriesgarchRange) -> Int { self.size }

pub fn TimeseriesgarchRange::get(self : TimeseriesgarchRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesgarchRange::set(self : TimeseriesgarchRange, i : Int, v : Double) -> TimeseriesgarchRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchRange::sum(self : TimeseriesgarchRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesgarchRange::mean(self : TimeseriesgarchRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesgarchRange::scale(self : TimeseriesgarchRange, f : Double) -> TimeseriesgarchRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchRange::add(self : TimeseriesgarchRange, other : TimeseriesgarchRange) -> TimeseriesgarchRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesgarchRange::copy(self : TimeseriesgarchRange) -> TimeseriesgarchRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchRange::fill(self : TimeseriesgarchRange, v : Double) -> TimeseriesgarchRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchRange::min(self : TimeseriesgarchRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesgarchRange::max(self : TimeseriesgarchRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesgarchRange::to_string(self : TimeseriesgarchRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_slice_make(size : Int) -> TimeseriesgarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesgarchSlice::len(self : TimeseriesgarchSlice) -> Int { self.size }

pub fn TimeseriesgarchSlice::get(self : TimeseriesgarchSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesgarchSlice::set(self : TimeseriesgarchSlice, i : Int, v : Double) -> TimeseriesgarchSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchSlice::sum(self : TimeseriesgarchSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesgarchSlice::mean(self : TimeseriesgarchSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesgarchSlice::scale(self : TimeseriesgarchSlice, f : Double) -> TimeseriesgarchSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchSlice::add(self : TimeseriesgarchSlice, other : TimeseriesgarchSlice) -> TimeseriesgarchSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesgarchSlice::copy(self : TimeseriesgarchSlice) -> TimeseriesgarchSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchSlice::fill(self : TimeseriesgarchSlice, v : Double) -> TimeseriesgarchSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesgarchSlice::min(self : TimeseriesgarchSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesgarchSlice::max(self : TimeseriesgarchSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesgarchSlice::to_string(self : TimeseriesgarchSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

