///===
/// extcore/timeseries_var

pub(all) struct TimeseriesvarPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_var_make_point(x : Double, y : Double) -> TimeseriesvarPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_var_make_point3(x : Double, y : Double, z : Double) -> TimeseriesvarPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesvarPoint::x(self : TimeseriesvarPoint) -> Double { self.x }

pub fn TimeseriesvarPoint::y(self : TimeseriesvarPoint) -> Double { self.y }

pub fn TimeseriesvarPoint::z(self : TimeseriesvarPoint) -> Double { self.z }

pub fn TimeseriesvarPoint::label(self : TimeseriesvarPoint) -> Int { self.label }

pub fn TimeseriesvarPoint::dist(self : TimeseriesvarPoint, other : TimeseriesvarPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesvarPoint::add(self : TimeseriesvarPoint, other : TimeseriesvarPoint) -> TimeseriesvarPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesvarPoint::sub(self : TimeseriesvarPoint, other : TimeseriesvarPoint) -> TimeseriesvarPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesvarPoint::scale(self : TimeseriesvarPoint, s : Double) -> TimeseriesvarPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesvarPoint::dot(self : TimeseriesvarPoint, other : TimeseriesvarPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesvarPoint::cross(self : TimeseriesvarPoint, other : TimeseriesvarPoint) -> TimeseriesvarPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesvarPoint::norm(self : TimeseriesvarPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesvarPoint::normalize(self : TimeseriesvarPoint) -> TimeseriesvarPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesvarPoint::negate(self : TimeseriesvarPoint) -> TimeseriesvarPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesvarPoint::mid(self : TimeseriesvarPoint, other : TimeseriesvarPoint) -> TimeseriesvarPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesvarPoint::lerp(self : TimeseriesvarPoint, other : TimeseriesvarPoint, t : Double) -> TimeseriesvarPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesvarPoint::to_string(self : TimeseriesvarPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesvarSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_var_make_series(vals : Array[Double], name : String) -> TimeseriesvarSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesvarSeries::len(self : TimeseriesvarSeries) -> Int { self.vals.length() }

pub fn TimeseriesvarSeries::sum(self : TimeseriesvarSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesvarSeries::mean(self : TimeseriesvarSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesvarSeries::min(self : TimeseriesvarSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesvarSeries::max(self : TimeseriesvarSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesvarSeries::range(self : TimeseriesvarSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesvarSeries::variance(self : TimeseriesvarSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesvarSeries::std(self : TimeseriesvarSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesvarSeries::median(self : TimeseriesvarSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesvarSeries::scale(self : TimeseriesvarSeries, f : Double) -> TimeseriesvarSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesvarSeries::add(self : TimeseriesvarSeries, other : TimeseriesvarSeries) -> TimeseriesvarSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesvarSeries::sub(self : TimeseriesvarSeries, other : TimeseriesvarSeries) -> TimeseriesvarSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesvarSeries::normalize(self : TimeseriesvarSeries) -> TimeseriesvarSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesvarSeries::cumsum(self : TimeseriesvarSeries) -> TimeseriesvarSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesvarSeries::to_string(self : TimeseriesvarSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesvarMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_var_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesvarMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_var_matrix_identity(n : Int) -> TimeseriesvarMatrix {
  let m = timeseries_var_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesvarMatrix::get(self : TimeseriesvarMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesvarMatrix::transpose(self : TimeseriesvarMatrix) -> TimeseriesvarMatrix {
  let result = timeseries_var_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesvarMatrix::add(self : TimeseriesvarMatrix, other : TimeseriesvarMatrix) -> TimeseriesvarMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_var_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesvarMatrix::scale(self : TimeseriesvarMatrix, s : Double) -> TimeseriesvarMatrix {
  let result = timeseries_var_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesvarMatrix::multiply(self : TimeseriesvarMatrix, other : TimeseriesvarMatrix) -> TimeseriesvarMatrix {
  if self.cols != other.rows { return timeseries_var_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_var_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn TimeseriesvarMatrix::trace(self : TimeseriesvarMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesvarMatrix::det(self : TimeseriesvarMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesvarMatrix::norm(self : TimeseriesvarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesvarMatrix::to_string(self : TimeseriesvarMatrix) -> String {
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

pub(all) struct TimeseriesvarVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_var_make_vector(comps : Array[Double]) -> TimeseriesvarVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_var_vector_zero(dim : Int) -> TimeseriesvarVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesvarVector::add(self : TimeseriesvarVector, other : TimeseriesvarVector) -> TimeseriesvarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesvarVector::sub(self : TimeseriesvarVector, other : TimeseriesvarVector) -> TimeseriesvarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesvarVector::scale(self : TimeseriesvarVector, s : Double) -> TimeseriesvarVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesvarVector::dot(self : TimeseriesvarVector, other : TimeseriesvarVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesvarVector::norm(self : TimeseriesvarVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesvarVector::normalize(self : TimeseriesvarVector) -> TimeseriesvarVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesvarVector::dist(self : TimeseriesvarVector, other : TimeseriesvarVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesvarVector::to_string(self : TimeseriesvarVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesvarFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_frame_make(size : Int) -> TimeseriesvarFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesvarFrame::len(self : TimeseriesvarFrame) -> Int { self.size }

pub fn TimeseriesvarFrame::get(self : TimeseriesvarFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesvarFrame::set(self : TimeseriesvarFrame, i : Int, v : Double) -> TimeseriesvarFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesvarFrame::sum(self : TimeseriesvarFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesvarFrame::mean(self : TimeseriesvarFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesvarFrame::scale(self : TimeseriesvarFrame, f : Double) -> TimeseriesvarFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarFrame::add(self : TimeseriesvarFrame, other : TimeseriesvarFrame) -> TimeseriesvarFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesvarFrame::copy(self : TimeseriesvarFrame) -> TimeseriesvarFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarFrame::fill(self : TimeseriesvarFrame, v : Double) -> TimeseriesvarFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarFrame::min(self : TimeseriesvarFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesvarFrame::max(self : TimeseriesvarFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesvarFrame::to_string(self : TimeseriesvarFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_table_make(size : Int) -> TimeseriesvarTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesvarTable::len(self : TimeseriesvarTable) -> Int { self.size }

pub fn TimeseriesvarTable::get(self : TimeseriesvarTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesvarTable::set(self : TimeseriesvarTable, i : Int, v : Double) -> TimeseriesvarTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesvarTable::sum(self : TimeseriesvarTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesvarTable::mean(self : TimeseriesvarTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesvarTable::scale(self : TimeseriesvarTable, f : Double) -> TimeseriesvarTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarTable::add(self : TimeseriesvarTable, other : TimeseriesvarTable) -> TimeseriesvarTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesvarTable::copy(self : TimeseriesvarTable) -> TimeseriesvarTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarTable::fill(self : TimeseriesvarTable, v : Double) -> TimeseriesvarTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarTable::min(self : TimeseriesvarTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesvarTable::max(self : TimeseriesvarTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesvarTable::to_string(self : TimeseriesvarTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_graphn_make(size : Int) -> TimeseriesvarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesvarGraphN::len(self : TimeseriesvarGraphN) -> Int { self.size }

pub fn TimeseriesvarGraphN::get(self : TimeseriesvarGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesvarGraphN::set(self : TimeseriesvarGraphN, i : Int, v : Double) -> TimeseriesvarGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesvarGraphN::sum(self : TimeseriesvarGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesvarGraphN::mean(self : TimeseriesvarGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesvarGraphN::scale(self : TimeseriesvarGraphN, f : Double) -> TimeseriesvarGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarGraphN::add(self : TimeseriesvarGraphN, other : TimeseriesvarGraphN) -> TimeseriesvarGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesvarGraphN::copy(self : TimeseriesvarGraphN) -> TimeseriesvarGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarGraphN::fill(self : TimeseriesvarGraphN, v : Double) -> TimeseriesvarGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarGraphN::min(self : TimeseriesvarGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesvarGraphN::max(self : TimeseriesvarGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesvarGraphN::to_string(self : TimeseriesvarGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_node_make(size : Int) -> TimeseriesvarNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesvarNode::len(self : TimeseriesvarNode) -> Int { self.size }

pub fn TimeseriesvarNode::get(self : TimeseriesvarNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesvarNode::set(self : TimeseriesvarNode, i : Int, v : Double) -> TimeseriesvarNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesvarNode::sum(self : TimeseriesvarNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesvarNode::mean(self : TimeseriesvarNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesvarNode::scale(self : TimeseriesvarNode, f : Double) -> TimeseriesvarNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarNode::add(self : TimeseriesvarNode, other : TimeseriesvarNode) -> TimeseriesvarNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesvarNode::copy(self : TimeseriesvarNode) -> TimeseriesvarNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarNode::fill(self : TimeseriesvarNode, v : Double) -> TimeseriesvarNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarNode::min(self : TimeseriesvarNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesvarNode::max(self : TimeseriesvarNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesvarNode::to_string(self : TimeseriesvarNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_edge_make(size : Int) -> TimeseriesvarEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesvarEdge::len(self : TimeseriesvarEdge) -> Int { self.size }

pub fn TimeseriesvarEdge::get(self : TimeseriesvarEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesvarEdge::set(self : TimeseriesvarEdge, i : Int, v : Double) -> TimeseriesvarEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesvarEdge::sum(self : TimeseriesvarEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesvarEdge::mean(self : TimeseriesvarEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesvarEdge::scale(self : TimeseriesvarEdge, f : Double) -> TimeseriesvarEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarEdge::add(self : TimeseriesvarEdge, other : TimeseriesvarEdge) -> TimeseriesvarEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesvarEdge::copy(self : TimeseriesvarEdge) -> TimeseriesvarEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarEdge::fill(self : TimeseriesvarEdge, v : Double) -> TimeseriesvarEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarEdge::min(self : TimeseriesvarEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesvarEdge::max(self : TimeseriesvarEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesvarEdge::to_string(self : TimeseriesvarEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_path_make(size : Int) -> TimeseriesvarPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesvarPath::len(self : TimeseriesvarPath) -> Int { self.size }

pub fn TimeseriesvarPath::get(self : TimeseriesvarPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesvarPath::set(self : TimeseriesvarPath, i : Int, v : Double) -> TimeseriesvarPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesvarPath::sum(self : TimeseriesvarPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesvarPath::mean(self : TimeseriesvarPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesvarPath::scale(self : TimeseriesvarPath, f : Double) -> TimeseriesvarPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarPath::add(self : TimeseriesvarPath, other : TimeseriesvarPath) -> TimeseriesvarPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesvarPath::copy(self : TimeseriesvarPath) -> TimeseriesvarPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarPath::fill(self : TimeseriesvarPath, v : Double) -> TimeseriesvarPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarPath::min(self : TimeseriesvarPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesvarPath::max(self : TimeseriesvarPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesvarPath::to_string(self : TimeseriesvarPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_cluster_make(size : Int) -> TimeseriesvarCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesvarCluster::len(self : TimeseriesvarCluster) -> Int { self.size }

pub fn TimeseriesvarCluster::get(self : TimeseriesvarCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesvarCluster::set(self : TimeseriesvarCluster, i : Int, v : Double) -> TimeseriesvarCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesvarCluster::sum(self : TimeseriesvarCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesvarCluster::mean(self : TimeseriesvarCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesvarCluster::scale(self : TimeseriesvarCluster, f : Double) -> TimeseriesvarCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarCluster::add(self : TimeseriesvarCluster, other : TimeseriesvarCluster) -> TimeseriesvarCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesvarCluster::copy(self : TimeseriesvarCluster) -> TimeseriesvarCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarCluster::fill(self : TimeseriesvarCluster, v : Double) -> TimeseriesvarCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarCluster::min(self : TimeseriesvarCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesvarCluster::max(self : TimeseriesvarCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesvarCluster::to_string(self : TimeseriesvarCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_model_make(size : Int) -> TimeseriesvarModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesvarModel::len(self : TimeseriesvarModel) -> Int { self.size }

pub fn TimeseriesvarModel::get(self : TimeseriesvarModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesvarModel::set(self : TimeseriesvarModel, i : Int, v : Double) -> TimeseriesvarModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesvarModel::sum(self : TimeseriesvarModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesvarModel::mean(self : TimeseriesvarModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesvarModel::scale(self : TimeseriesvarModel, f : Double) -> TimeseriesvarModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarModel::add(self : TimeseriesvarModel, other : TimeseriesvarModel) -> TimeseriesvarModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesvarModel::copy(self : TimeseriesvarModel) -> TimeseriesvarModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarModel::fill(self : TimeseriesvarModel, v : Double) -> TimeseriesvarModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarModel::min(self : TimeseriesvarModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesvarModel::max(self : TimeseriesvarModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesvarModel::to_string(self : TimeseriesvarModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_layer_make(size : Int) -> TimeseriesvarLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesvarLayer::len(self : TimeseriesvarLayer) -> Int { self.size }

pub fn TimeseriesvarLayer::get(self : TimeseriesvarLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesvarLayer::set(self : TimeseriesvarLayer, i : Int, v : Double) -> TimeseriesvarLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesvarLayer::sum(self : TimeseriesvarLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesvarLayer::mean(self : TimeseriesvarLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesvarLayer::scale(self : TimeseriesvarLayer, f : Double) -> TimeseriesvarLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarLayer::add(self : TimeseriesvarLayer, other : TimeseriesvarLayer) -> TimeseriesvarLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesvarLayer::copy(self : TimeseriesvarLayer) -> TimeseriesvarLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarLayer::fill(self : TimeseriesvarLayer, v : Double) -> TimeseriesvarLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarLayer::min(self : TimeseriesvarLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesvarLayer::max(self : TimeseriesvarLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesvarLayer::to_string(self : TimeseriesvarLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_buffer_make(size : Int) -> TimeseriesvarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesvarBuffer::len(self : TimeseriesvarBuffer) -> Int { self.size }

pub fn TimeseriesvarBuffer::get(self : TimeseriesvarBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesvarBuffer::set(self : TimeseriesvarBuffer, i : Int, v : Double) -> TimeseriesvarBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesvarBuffer::sum(self : TimeseriesvarBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesvarBuffer::mean(self : TimeseriesvarBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesvarBuffer::scale(self : TimeseriesvarBuffer, f : Double) -> TimeseriesvarBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarBuffer::add(self : TimeseriesvarBuffer, other : TimeseriesvarBuffer) -> TimeseriesvarBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesvarBuffer::copy(self : TimeseriesvarBuffer) -> TimeseriesvarBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarBuffer::fill(self : TimeseriesvarBuffer, v : Double) -> TimeseriesvarBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarBuffer::min(self : TimeseriesvarBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesvarBuffer::max(self : TimeseriesvarBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesvarBuffer::to_string(self : TimeseriesvarBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_cursor_make(size : Int) -> TimeseriesvarCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesvarCursor::len(self : TimeseriesvarCursor) -> Int { self.size }

pub fn TimeseriesvarCursor::get(self : TimeseriesvarCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesvarCursor::set(self : TimeseriesvarCursor, i : Int, v : Double) -> TimeseriesvarCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesvarCursor::sum(self : TimeseriesvarCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesvarCursor::mean(self : TimeseriesvarCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesvarCursor::scale(self : TimeseriesvarCursor, f : Double) -> TimeseriesvarCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarCursor::add(self : TimeseriesvarCursor, other : TimeseriesvarCursor) -> TimeseriesvarCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesvarCursor::copy(self : TimeseriesvarCursor) -> TimeseriesvarCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarCursor::fill(self : TimeseriesvarCursor, v : Double) -> TimeseriesvarCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarCursor::min(self : TimeseriesvarCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesvarCursor::max(self : TimeseriesvarCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesvarCursor::to_string(self : TimeseriesvarCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_view_make(size : Int) -> TimeseriesvarView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesvarView::len(self : TimeseriesvarView) -> Int { self.size }

pub fn TimeseriesvarView::get(self : TimeseriesvarView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesvarView::set(self : TimeseriesvarView, i : Int, v : Double) -> TimeseriesvarView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesvarView::sum(self : TimeseriesvarView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesvarView::mean(self : TimeseriesvarView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesvarView::scale(self : TimeseriesvarView, f : Double) -> TimeseriesvarView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarView::add(self : TimeseriesvarView, other : TimeseriesvarView) -> TimeseriesvarView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesvarView::copy(self : TimeseriesvarView) -> TimeseriesvarView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarView::fill(self : TimeseriesvarView, v : Double) -> TimeseriesvarView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarView::min(self : TimeseriesvarView) -> Double { @_common.min(self.data) }

pub fn TimeseriesvarView::max(self : TimeseriesvarView) -> Double { @_common.max(self.data) }

pub fn TimeseriesvarView::to_string(self : TimeseriesvarView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_range_make(size : Int) -> TimeseriesvarRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesvarRange::len(self : TimeseriesvarRange) -> Int { self.size }

pub fn TimeseriesvarRange::get(self : TimeseriesvarRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesvarRange::set(self : TimeseriesvarRange, i : Int, v : Double) -> TimeseriesvarRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesvarRange::sum(self : TimeseriesvarRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesvarRange::mean(self : TimeseriesvarRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesvarRange::scale(self : TimeseriesvarRange, f : Double) -> TimeseriesvarRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarRange::add(self : TimeseriesvarRange, other : TimeseriesvarRange) -> TimeseriesvarRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesvarRange::copy(self : TimeseriesvarRange) -> TimeseriesvarRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarRange::fill(self : TimeseriesvarRange, v : Double) -> TimeseriesvarRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarRange::min(self : TimeseriesvarRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesvarRange::max(self : TimeseriesvarRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesvarRange::to_string(self : TimeseriesvarRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_slice_make(size : Int) -> TimeseriesvarSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesvarSlice::len(self : TimeseriesvarSlice) -> Int { self.size }

pub fn TimeseriesvarSlice::get(self : TimeseriesvarSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesvarSlice::set(self : TimeseriesvarSlice, i : Int, v : Double) -> TimeseriesvarSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesvarSlice::sum(self : TimeseriesvarSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesvarSlice::mean(self : TimeseriesvarSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesvarSlice::scale(self : TimeseriesvarSlice, f : Double) -> TimeseriesvarSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarSlice::add(self : TimeseriesvarSlice, other : TimeseriesvarSlice) -> TimeseriesvarSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesvarSlice::copy(self : TimeseriesvarSlice) -> TimeseriesvarSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarSlice::fill(self : TimeseriesvarSlice, v : Double) -> TimeseriesvarSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesvarSlice::min(self : TimeseriesvarSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesvarSlice::max(self : TimeseriesvarSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesvarSlice::to_string(self : TimeseriesvarSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

