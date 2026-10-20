///===
/// extcore/timeseries_decomp_hp

pub(all) struct TimeseriesdecomphpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_hp_make_point(x : Double, y : Double) -> TimeseriesdecomphpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_hp_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecomphpPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesdecomphpPoint::x(self : TimeseriesdecomphpPoint) -> Double { self.x }

pub fn TimeseriesdecomphpPoint::y(self : TimeseriesdecomphpPoint) -> Double { self.y }

pub fn TimeseriesdecomphpPoint::z(self : TimeseriesdecomphpPoint) -> Double { self.z }

pub fn TimeseriesdecomphpPoint::label(self : TimeseriesdecomphpPoint) -> Int { self.label }

pub fn TimeseriesdecomphpPoint::dist(self : TimeseriesdecomphpPoint, other : TimeseriesdecomphpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesdecomphpPoint::add(self : TimeseriesdecomphpPoint, other : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesdecomphpPoint::sub(self : TimeseriesdecomphpPoint, other : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesdecomphpPoint::scale(self : TimeseriesdecomphpPoint, s : Double) -> TimeseriesdecomphpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesdecomphpPoint::dot(self : TimeseriesdecomphpPoint, other : TimeseriesdecomphpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesdecomphpPoint::cross(self : TimeseriesdecomphpPoint, other : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesdecomphpPoint::norm(self : TimeseriesdecomphpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesdecomphpPoint::normalize(self : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecomphpPoint::negate(self : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesdecomphpPoint::mid(self : TimeseriesdecomphpPoint, other : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesdecomphpPoint::lerp(self : TimeseriesdecomphpPoint, other : TimeseriesdecomphpPoint, t : Double) -> TimeseriesdecomphpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesdecomphpPoint::to_string(self : TimeseriesdecomphpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_hp_make_series(vals : Array[Double], name : String) -> TimeseriesdecomphpSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesdecomphpSeries::len(self : TimeseriesdecomphpSeries) -> Int { self.vals.length() }

pub fn TimeseriesdecomphpSeries::sum(self : TimeseriesdecomphpSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesdecomphpSeries::mean(self : TimeseriesdecomphpSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesdecomphpSeries::min(self : TimeseriesdecomphpSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesdecomphpSeries::max(self : TimeseriesdecomphpSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesdecomphpSeries::range(self : TimeseriesdecomphpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesdecomphpSeries::variance(self : TimeseriesdecomphpSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesdecomphpSeries::std(self : TimeseriesdecomphpSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesdecomphpSeries::median(self : TimeseriesdecomphpSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesdecomphpSeries::scale(self : TimeseriesdecomphpSeries, f : Double) -> TimeseriesdecomphpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesdecomphpSeries::add(self : TimeseriesdecomphpSeries, other : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesdecomphpSeries::sub(self : TimeseriesdecomphpSeries, other : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesdecomphpSeries::normalize(self : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesdecomphpSeries::cumsum(self : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesdecomphpSeries::to_string(self : TimeseriesdecomphpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecomphpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_hp_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecomphpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_hp_matrix_identity(n : Int) -> TimeseriesdecomphpMatrix {
  let m = timeseries_decomp_hp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesdecomphpMatrix::get(self : TimeseriesdecomphpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesdecomphpMatrix::transpose(self : TimeseriesdecomphpMatrix) -> TimeseriesdecomphpMatrix {
  let result = timeseries_decomp_hp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesdecomphpMatrix::add(self : TimeseriesdecomphpMatrix, other : TimeseriesdecomphpMatrix) -> TimeseriesdecomphpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_hp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesdecomphpMatrix::scale(self : TimeseriesdecomphpMatrix, s : Double) -> TimeseriesdecomphpMatrix {
  let result = timeseries_decomp_hp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesdecomphpMatrix::multiply(self : TimeseriesdecomphpMatrix, other : TimeseriesdecomphpMatrix) -> TimeseriesdecomphpMatrix {
  if self.cols != other.rows { return timeseries_decomp_hp_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_hp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn TimeseriesdecomphpMatrix::trace(self : TimeseriesdecomphpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesdecomphpMatrix::det(self : TimeseriesdecomphpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesdecomphpMatrix::norm(self : TimeseriesdecomphpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesdecomphpMatrix::to_string(self : TimeseriesdecomphpMatrix) -> String {
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

pub(all) struct TimeseriesdecomphpVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_hp_make_vector(comps : Array[Double]) -> TimeseriesdecomphpVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_hp_vector_zero(dim : Int) -> TimeseriesdecomphpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesdecomphpVector::add(self : TimeseriesdecomphpVector, other : TimeseriesdecomphpVector) -> TimeseriesdecomphpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecomphpVector::sub(self : TimeseriesdecomphpVector, other : TimeseriesdecomphpVector) -> TimeseriesdecomphpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecomphpVector::scale(self : TimeseriesdecomphpVector, s : Double) -> TimeseriesdecomphpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesdecomphpVector::dot(self : TimeseriesdecomphpVector, other : TimeseriesdecomphpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesdecomphpVector::norm(self : TimeseriesdecomphpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesdecomphpVector::normalize(self : TimeseriesdecomphpVector) -> TimeseriesdecomphpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecomphpVector::dist(self : TimeseriesdecomphpVector, other : TimeseriesdecomphpVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesdecomphpVector::to_string(self : TimeseriesdecomphpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecomphpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_frame_make(size : Int) -> TimeseriesdecomphpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecomphpFrame::len(self : TimeseriesdecomphpFrame) -> Int { self.size }

pub fn TimeseriesdecomphpFrame::get(self : TimeseriesdecomphpFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecomphpFrame::set(self : TimeseriesdecomphpFrame, i : Int, v : Double) -> TimeseriesdecomphpFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpFrame::sum(self : TimeseriesdecomphpFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecomphpFrame::mean(self : TimeseriesdecomphpFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecomphpFrame::scale(self : TimeseriesdecomphpFrame, f : Double) -> TimeseriesdecomphpFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpFrame::add(self : TimeseriesdecomphpFrame, other : TimeseriesdecomphpFrame) -> TimeseriesdecomphpFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecomphpFrame::copy(self : TimeseriesdecomphpFrame) -> TimeseriesdecomphpFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpFrame::fill(self : TimeseriesdecomphpFrame, v : Double) -> TimeseriesdecomphpFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpFrame::min(self : TimeseriesdecomphpFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecomphpFrame::max(self : TimeseriesdecomphpFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecomphpFrame::to_string(self : TimeseriesdecomphpFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_table_make(size : Int) -> TimeseriesdecomphpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecomphpTable::len(self : TimeseriesdecomphpTable) -> Int { self.size }

pub fn TimeseriesdecomphpTable::get(self : TimeseriesdecomphpTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecomphpTable::set(self : TimeseriesdecomphpTable, i : Int, v : Double) -> TimeseriesdecomphpTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpTable::sum(self : TimeseriesdecomphpTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecomphpTable::mean(self : TimeseriesdecomphpTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecomphpTable::scale(self : TimeseriesdecomphpTable, f : Double) -> TimeseriesdecomphpTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpTable::add(self : TimeseriesdecomphpTable, other : TimeseriesdecomphpTable) -> TimeseriesdecomphpTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecomphpTable::copy(self : TimeseriesdecomphpTable) -> TimeseriesdecomphpTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpTable::fill(self : TimeseriesdecomphpTable, v : Double) -> TimeseriesdecomphpTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpTable::min(self : TimeseriesdecomphpTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecomphpTable::max(self : TimeseriesdecomphpTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecomphpTable::to_string(self : TimeseriesdecomphpTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_graphn_make(size : Int) -> TimeseriesdecomphpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecomphpGraphN::len(self : TimeseriesdecomphpGraphN) -> Int { self.size }

pub fn TimeseriesdecomphpGraphN::get(self : TimeseriesdecomphpGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecomphpGraphN::set(self : TimeseriesdecomphpGraphN, i : Int, v : Double) -> TimeseriesdecomphpGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpGraphN::sum(self : TimeseriesdecomphpGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecomphpGraphN::mean(self : TimeseriesdecomphpGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecomphpGraphN::scale(self : TimeseriesdecomphpGraphN, f : Double) -> TimeseriesdecomphpGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpGraphN::add(self : TimeseriesdecomphpGraphN, other : TimeseriesdecomphpGraphN) -> TimeseriesdecomphpGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecomphpGraphN::copy(self : TimeseriesdecomphpGraphN) -> TimeseriesdecomphpGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpGraphN::fill(self : TimeseriesdecomphpGraphN, v : Double) -> TimeseriesdecomphpGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpGraphN::min(self : TimeseriesdecomphpGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecomphpGraphN::max(self : TimeseriesdecomphpGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecomphpGraphN::to_string(self : TimeseriesdecomphpGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_node_make(size : Int) -> TimeseriesdecomphpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecomphpNode::len(self : TimeseriesdecomphpNode) -> Int { self.size }

pub fn TimeseriesdecomphpNode::get(self : TimeseriesdecomphpNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecomphpNode::set(self : TimeseriesdecomphpNode, i : Int, v : Double) -> TimeseriesdecomphpNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpNode::sum(self : TimeseriesdecomphpNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecomphpNode::mean(self : TimeseriesdecomphpNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecomphpNode::scale(self : TimeseriesdecomphpNode, f : Double) -> TimeseriesdecomphpNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpNode::add(self : TimeseriesdecomphpNode, other : TimeseriesdecomphpNode) -> TimeseriesdecomphpNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecomphpNode::copy(self : TimeseriesdecomphpNode) -> TimeseriesdecomphpNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpNode::fill(self : TimeseriesdecomphpNode, v : Double) -> TimeseriesdecomphpNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpNode::min(self : TimeseriesdecomphpNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecomphpNode::max(self : TimeseriesdecomphpNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecomphpNode::to_string(self : TimeseriesdecomphpNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_edge_make(size : Int) -> TimeseriesdecomphpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecomphpEdge::len(self : TimeseriesdecomphpEdge) -> Int { self.size }

pub fn TimeseriesdecomphpEdge::get(self : TimeseriesdecomphpEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecomphpEdge::set(self : TimeseriesdecomphpEdge, i : Int, v : Double) -> TimeseriesdecomphpEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpEdge::sum(self : TimeseriesdecomphpEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecomphpEdge::mean(self : TimeseriesdecomphpEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecomphpEdge::scale(self : TimeseriesdecomphpEdge, f : Double) -> TimeseriesdecomphpEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpEdge::add(self : TimeseriesdecomphpEdge, other : TimeseriesdecomphpEdge) -> TimeseriesdecomphpEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecomphpEdge::copy(self : TimeseriesdecomphpEdge) -> TimeseriesdecomphpEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpEdge::fill(self : TimeseriesdecomphpEdge, v : Double) -> TimeseriesdecomphpEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpEdge::min(self : TimeseriesdecomphpEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecomphpEdge::max(self : TimeseriesdecomphpEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecomphpEdge::to_string(self : TimeseriesdecomphpEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_path_make(size : Int) -> TimeseriesdecomphpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecomphpPath::len(self : TimeseriesdecomphpPath) -> Int { self.size }

pub fn TimeseriesdecomphpPath::get(self : TimeseriesdecomphpPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecomphpPath::set(self : TimeseriesdecomphpPath, i : Int, v : Double) -> TimeseriesdecomphpPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpPath::sum(self : TimeseriesdecomphpPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecomphpPath::mean(self : TimeseriesdecomphpPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecomphpPath::scale(self : TimeseriesdecomphpPath, f : Double) -> TimeseriesdecomphpPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpPath::add(self : TimeseriesdecomphpPath, other : TimeseriesdecomphpPath) -> TimeseriesdecomphpPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecomphpPath::copy(self : TimeseriesdecomphpPath) -> TimeseriesdecomphpPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpPath::fill(self : TimeseriesdecomphpPath, v : Double) -> TimeseriesdecomphpPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpPath::min(self : TimeseriesdecomphpPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecomphpPath::max(self : TimeseriesdecomphpPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecomphpPath::to_string(self : TimeseriesdecomphpPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_cluster_make(size : Int) -> TimeseriesdecomphpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecomphpCluster::len(self : TimeseriesdecomphpCluster) -> Int { self.size }

pub fn TimeseriesdecomphpCluster::get(self : TimeseriesdecomphpCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecomphpCluster::set(self : TimeseriesdecomphpCluster, i : Int, v : Double) -> TimeseriesdecomphpCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpCluster::sum(self : TimeseriesdecomphpCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecomphpCluster::mean(self : TimeseriesdecomphpCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecomphpCluster::scale(self : TimeseriesdecomphpCluster, f : Double) -> TimeseriesdecomphpCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpCluster::add(self : TimeseriesdecomphpCluster, other : TimeseriesdecomphpCluster) -> TimeseriesdecomphpCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecomphpCluster::copy(self : TimeseriesdecomphpCluster) -> TimeseriesdecomphpCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpCluster::fill(self : TimeseriesdecomphpCluster, v : Double) -> TimeseriesdecomphpCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpCluster::min(self : TimeseriesdecomphpCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecomphpCluster::max(self : TimeseriesdecomphpCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecomphpCluster::to_string(self : TimeseriesdecomphpCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_model_make(size : Int) -> TimeseriesdecomphpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecomphpModel::len(self : TimeseriesdecomphpModel) -> Int { self.size }

pub fn TimeseriesdecomphpModel::get(self : TimeseriesdecomphpModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecomphpModel::set(self : TimeseriesdecomphpModel, i : Int, v : Double) -> TimeseriesdecomphpModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpModel::sum(self : TimeseriesdecomphpModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecomphpModel::mean(self : TimeseriesdecomphpModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecomphpModel::scale(self : TimeseriesdecomphpModel, f : Double) -> TimeseriesdecomphpModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpModel::add(self : TimeseriesdecomphpModel, other : TimeseriesdecomphpModel) -> TimeseriesdecomphpModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecomphpModel::copy(self : TimeseriesdecomphpModel) -> TimeseriesdecomphpModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpModel::fill(self : TimeseriesdecomphpModel, v : Double) -> TimeseriesdecomphpModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpModel::min(self : TimeseriesdecomphpModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecomphpModel::max(self : TimeseriesdecomphpModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecomphpModel::to_string(self : TimeseriesdecomphpModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_layer_make(size : Int) -> TimeseriesdecomphpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecomphpLayer::len(self : TimeseriesdecomphpLayer) -> Int { self.size }

pub fn TimeseriesdecomphpLayer::get(self : TimeseriesdecomphpLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecomphpLayer::set(self : TimeseriesdecomphpLayer, i : Int, v : Double) -> TimeseriesdecomphpLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpLayer::sum(self : TimeseriesdecomphpLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecomphpLayer::mean(self : TimeseriesdecomphpLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecomphpLayer::scale(self : TimeseriesdecomphpLayer, f : Double) -> TimeseriesdecomphpLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpLayer::add(self : TimeseriesdecomphpLayer, other : TimeseriesdecomphpLayer) -> TimeseriesdecomphpLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecomphpLayer::copy(self : TimeseriesdecomphpLayer) -> TimeseriesdecomphpLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpLayer::fill(self : TimeseriesdecomphpLayer, v : Double) -> TimeseriesdecomphpLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpLayer::min(self : TimeseriesdecomphpLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecomphpLayer::max(self : TimeseriesdecomphpLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecomphpLayer::to_string(self : TimeseriesdecomphpLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_buffer_make(size : Int) -> TimeseriesdecomphpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecomphpBuffer::len(self : TimeseriesdecomphpBuffer) -> Int { self.size }

pub fn TimeseriesdecomphpBuffer::get(self : TimeseriesdecomphpBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecomphpBuffer::set(self : TimeseriesdecomphpBuffer, i : Int, v : Double) -> TimeseriesdecomphpBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpBuffer::sum(self : TimeseriesdecomphpBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecomphpBuffer::mean(self : TimeseriesdecomphpBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecomphpBuffer::scale(self : TimeseriesdecomphpBuffer, f : Double) -> TimeseriesdecomphpBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpBuffer::add(self : TimeseriesdecomphpBuffer, other : TimeseriesdecomphpBuffer) -> TimeseriesdecomphpBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecomphpBuffer::copy(self : TimeseriesdecomphpBuffer) -> TimeseriesdecomphpBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpBuffer::fill(self : TimeseriesdecomphpBuffer, v : Double) -> TimeseriesdecomphpBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpBuffer::min(self : TimeseriesdecomphpBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecomphpBuffer::max(self : TimeseriesdecomphpBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecomphpBuffer::to_string(self : TimeseriesdecomphpBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_cursor_make(size : Int) -> TimeseriesdecomphpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecomphpCursor::len(self : TimeseriesdecomphpCursor) -> Int { self.size }

pub fn TimeseriesdecomphpCursor::get(self : TimeseriesdecomphpCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecomphpCursor::set(self : TimeseriesdecomphpCursor, i : Int, v : Double) -> TimeseriesdecomphpCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpCursor::sum(self : TimeseriesdecomphpCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecomphpCursor::mean(self : TimeseriesdecomphpCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecomphpCursor::scale(self : TimeseriesdecomphpCursor, f : Double) -> TimeseriesdecomphpCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpCursor::add(self : TimeseriesdecomphpCursor, other : TimeseriesdecomphpCursor) -> TimeseriesdecomphpCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecomphpCursor::copy(self : TimeseriesdecomphpCursor) -> TimeseriesdecomphpCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpCursor::fill(self : TimeseriesdecomphpCursor, v : Double) -> TimeseriesdecomphpCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpCursor::min(self : TimeseriesdecomphpCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecomphpCursor::max(self : TimeseriesdecomphpCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecomphpCursor::to_string(self : TimeseriesdecomphpCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_view_make(size : Int) -> TimeseriesdecomphpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecomphpView::len(self : TimeseriesdecomphpView) -> Int { self.size }

pub fn TimeseriesdecomphpView::get(self : TimeseriesdecomphpView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecomphpView::set(self : TimeseriesdecomphpView, i : Int, v : Double) -> TimeseriesdecomphpView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpView::sum(self : TimeseriesdecomphpView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecomphpView::mean(self : TimeseriesdecomphpView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecomphpView::scale(self : TimeseriesdecomphpView, f : Double) -> TimeseriesdecomphpView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpView::add(self : TimeseriesdecomphpView, other : TimeseriesdecomphpView) -> TimeseriesdecomphpView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecomphpView::copy(self : TimeseriesdecomphpView) -> TimeseriesdecomphpView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpView::fill(self : TimeseriesdecomphpView, v : Double) -> TimeseriesdecomphpView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpView::min(self : TimeseriesdecomphpView) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecomphpView::max(self : TimeseriesdecomphpView) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecomphpView::to_string(self : TimeseriesdecomphpView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_range_make(size : Int) -> TimeseriesdecomphpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecomphpRange::len(self : TimeseriesdecomphpRange) -> Int { self.size }

pub fn TimeseriesdecomphpRange::get(self : TimeseriesdecomphpRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecomphpRange::set(self : TimeseriesdecomphpRange, i : Int, v : Double) -> TimeseriesdecomphpRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpRange::sum(self : TimeseriesdecomphpRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecomphpRange::mean(self : TimeseriesdecomphpRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecomphpRange::scale(self : TimeseriesdecomphpRange, f : Double) -> TimeseriesdecomphpRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpRange::add(self : TimeseriesdecomphpRange, other : TimeseriesdecomphpRange) -> TimeseriesdecomphpRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecomphpRange::copy(self : TimeseriesdecomphpRange) -> TimeseriesdecomphpRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpRange::fill(self : TimeseriesdecomphpRange, v : Double) -> TimeseriesdecomphpRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpRange::min(self : TimeseriesdecomphpRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecomphpRange::max(self : TimeseriesdecomphpRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecomphpRange::to_string(self : TimeseriesdecomphpRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_slice_make(size : Int) -> TimeseriesdecomphpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecomphpSlice::len(self : TimeseriesdecomphpSlice) -> Int { self.size }

pub fn TimeseriesdecomphpSlice::get(self : TimeseriesdecomphpSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecomphpSlice::set(self : TimeseriesdecomphpSlice, i : Int, v : Double) -> TimeseriesdecomphpSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpSlice::sum(self : TimeseriesdecomphpSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecomphpSlice::mean(self : TimeseriesdecomphpSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecomphpSlice::scale(self : TimeseriesdecomphpSlice, f : Double) -> TimeseriesdecomphpSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpSlice::add(self : TimeseriesdecomphpSlice, other : TimeseriesdecomphpSlice) -> TimeseriesdecomphpSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecomphpSlice::copy(self : TimeseriesdecomphpSlice) -> TimeseriesdecomphpSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpSlice::fill(self : TimeseriesdecomphpSlice, v : Double) -> TimeseriesdecomphpSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecomphpSlice::min(self : TimeseriesdecomphpSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecomphpSlice::max(self : TimeseriesdecomphpSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecomphpSlice::to_string(self : TimeseriesdecomphpSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

