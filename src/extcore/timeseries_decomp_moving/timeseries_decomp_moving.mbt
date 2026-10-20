///===
/// extcore/timeseries_decomp_moving

pub(all) struct TimeseriesdecompmovingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_moving_make_point(x : Double, y : Double) -> TimeseriesdecompmovingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_moving_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompmovingPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesdecompmovingPoint::x(self : TimeseriesdecompmovingPoint) -> Double { self.x }

pub fn TimeseriesdecompmovingPoint::y(self : TimeseriesdecompmovingPoint) -> Double { self.y }

pub fn TimeseriesdecompmovingPoint::z(self : TimeseriesdecompmovingPoint) -> Double { self.z }

pub fn TimeseriesdecompmovingPoint::label(self : TimeseriesdecompmovingPoint) -> Int { self.label }

pub fn TimeseriesdecompmovingPoint::dist(self : TimeseriesdecompmovingPoint, other : TimeseriesdecompmovingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesdecompmovingPoint::add(self : TimeseriesdecompmovingPoint, other : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesdecompmovingPoint::sub(self : TimeseriesdecompmovingPoint, other : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesdecompmovingPoint::scale(self : TimeseriesdecompmovingPoint, s : Double) -> TimeseriesdecompmovingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesdecompmovingPoint::dot(self : TimeseriesdecompmovingPoint, other : TimeseriesdecompmovingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesdecompmovingPoint::cross(self : TimeseriesdecompmovingPoint, other : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesdecompmovingPoint::norm(self : TimeseriesdecompmovingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesdecompmovingPoint::normalize(self : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompmovingPoint::negate(self : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesdecompmovingPoint::mid(self : TimeseriesdecompmovingPoint, other : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesdecompmovingPoint::lerp(self : TimeseriesdecompmovingPoint, other : TimeseriesdecompmovingPoint, t : Double) -> TimeseriesdecompmovingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesdecompmovingPoint::to_string(self : TimeseriesdecompmovingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_moving_make_series(vals : Array[Double], name : String) -> TimeseriesdecompmovingSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesdecompmovingSeries::len(self : TimeseriesdecompmovingSeries) -> Int { self.vals.length() }

pub fn TimeseriesdecompmovingSeries::sum(self : TimeseriesdecompmovingSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesdecompmovingSeries::mean(self : TimeseriesdecompmovingSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesdecompmovingSeries::min(self : TimeseriesdecompmovingSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesdecompmovingSeries::max(self : TimeseriesdecompmovingSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesdecompmovingSeries::range(self : TimeseriesdecompmovingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesdecompmovingSeries::variance(self : TimeseriesdecompmovingSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesdecompmovingSeries::std(self : TimeseriesdecompmovingSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesdecompmovingSeries::median(self : TimeseriesdecompmovingSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesdecompmovingSeries::scale(self : TimeseriesdecompmovingSeries, f : Double) -> TimeseriesdecompmovingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesdecompmovingSeries::add(self : TimeseriesdecompmovingSeries, other : TimeseriesdecompmovingSeries) -> TimeseriesdecompmovingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompmovingSeries::sub(self : TimeseriesdecompmovingSeries, other : TimeseriesdecompmovingSeries) -> TimeseriesdecompmovingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompmovingSeries::normalize(self : TimeseriesdecompmovingSeries) -> TimeseriesdecompmovingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesdecompmovingSeries::cumsum(self : TimeseriesdecompmovingSeries) -> TimeseriesdecompmovingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesdecompmovingSeries::to_string(self : TimeseriesdecompmovingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompmovingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_moving_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompmovingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_moving_matrix_identity(n : Int) -> TimeseriesdecompmovingMatrix {
  let m = timeseries_decomp_moving_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesdecompmovingMatrix::get(self : TimeseriesdecompmovingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesdecompmovingMatrix::transpose(self : TimeseriesdecompmovingMatrix) -> TimeseriesdecompmovingMatrix {
  let result = timeseries_decomp_moving_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesdecompmovingMatrix::add(self : TimeseriesdecompmovingMatrix, other : TimeseriesdecompmovingMatrix) -> TimeseriesdecompmovingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_moving_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesdecompmovingMatrix::scale(self : TimeseriesdecompmovingMatrix, s : Double) -> TimeseriesdecompmovingMatrix {
  let result = timeseries_decomp_moving_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesdecompmovingMatrix::multiply(self : TimeseriesdecompmovingMatrix, other : TimeseriesdecompmovingMatrix) -> TimeseriesdecompmovingMatrix {
  if self.cols != other.rows { return timeseries_decomp_moving_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_moving_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesdecompmovingMatrix::trace(self : TimeseriesdecompmovingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesdecompmovingMatrix::det(self : TimeseriesdecompmovingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesdecompmovingMatrix::norm(self : TimeseriesdecompmovingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesdecompmovingMatrix::to_string(self : TimeseriesdecompmovingMatrix) -> String {
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

pub(all) struct TimeseriesdecompmovingVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_moving_make_vector(comps : Array[Double]) -> TimeseriesdecompmovingVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_moving_vector_zero(dim : Int) -> TimeseriesdecompmovingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesdecompmovingVector::add(self : TimeseriesdecompmovingVector, other : TimeseriesdecompmovingVector) -> TimeseriesdecompmovingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompmovingVector::sub(self : TimeseriesdecompmovingVector, other : TimeseriesdecompmovingVector) -> TimeseriesdecompmovingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompmovingVector::scale(self : TimeseriesdecompmovingVector, s : Double) -> TimeseriesdecompmovingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesdecompmovingVector::dot(self : TimeseriesdecompmovingVector, other : TimeseriesdecompmovingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesdecompmovingVector::norm(self : TimeseriesdecompmovingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesdecompmovingVector::normalize(self : TimeseriesdecompmovingVector) -> TimeseriesdecompmovingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompmovingVector::dist(self : TimeseriesdecompmovingVector, other : TimeseriesdecompmovingVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesdecompmovingVector::to_string(self : TimeseriesdecompmovingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompmovingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_frame_make(size : Int) -> TimeseriesdecompmovingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompmovingFrame::len(self : TimeseriesdecompmovingFrame) -> Int { self.size }

pub fn TimeseriesdecompmovingFrame::get(self : TimeseriesdecompmovingFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompmovingFrame::set(self : TimeseriesdecompmovingFrame, i : Int, v : Double) -> TimeseriesdecompmovingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingFrame::sum(self : TimeseriesdecompmovingFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompmovingFrame::mean(self : TimeseriesdecompmovingFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompmovingFrame::scale(self : TimeseriesdecompmovingFrame, f : Double) -> TimeseriesdecompmovingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingFrame::add(self : TimeseriesdecompmovingFrame, other : TimeseriesdecompmovingFrame) -> TimeseriesdecompmovingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompmovingFrame::copy(self : TimeseriesdecompmovingFrame) -> TimeseriesdecompmovingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingFrame::fill(self : TimeseriesdecompmovingFrame, v : Double) -> TimeseriesdecompmovingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingFrame::min(self : TimeseriesdecompmovingFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompmovingFrame::max(self : TimeseriesdecompmovingFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompmovingFrame::to_string(self : TimeseriesdecompmovingFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_table_make(size : Int) -> TimeseriesdecompmovingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompmovingTable::len(self : TimeseriesdecompmovingTable) -> Int { self.size }

pub fn TimeseriesdecompmovingTable::get(self : TimeseriesdecompmovingTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompmovingTable::set(self : TimeseriesdecompmovingTable, i : Int, v : Double) -> TimeseriesdecompmovingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingTable::sum(self : TimeseriesdecompmovingTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompmovingTable::mean(self : TimeseriesdecompmovingTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompmovingTable::scale(self : TimeseriesdecompmovingTable, f : Double) -> TimeseriesdecompmovingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingTable::add(self : TimeseriesdecompmovingTable, other : TimeseriesdecompmovingTable) -> TimeseriesdecompmovingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompmovingTable::copy(self : TimeseriesdecompmovingTable) -> TimeseriesdecompmovingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingTable::fill(self : TimeseriesdecompmovingTable, v : Double) -> TimeseriesdecompmovingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingTable::min(self : TimeseriesdecompmovingTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompmovingTable::max(self : TimeseriesdecompmovingTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompmovingTable::to_string(self : TimeseriesdecompmovingTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_graphn_make(size : Int) -> TimeseriesdecompmovingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompmovingGraphN::len(self : TimeseriesdecompmovingGraphN) -> Int { self.size }

pub fn TimeseriesdecompmovingGraphN::get(self : TimeseriesdecompmovingGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompmovingGraphN::set(self : TimeseriesdecompmovingGraphN, i : Int, v : Double) -> TimeseriesdecompmovingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingGraphN::sum(self : TimeseriesdecompmovingGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompmovingGraphN::mean(self : TimeseriesdecompmovingGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompmovingGraphN::scale(self : TimeseriesdecompmovingGraphN, f : Double) -> TimeseriesdecompmovingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingGraphN::add(self : TimeseriesdecompmovingGraphN, other : TimeseriesdecompmovingGraphN) -> TimeseriesdecompmovingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompmovingGraphN::copy(self : TimeseriesdecompmovingGraphN) -> TimeseriesdecompmovingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingGraphN::fill(self : TimeseriesdecompmovingGraphN, v : Double) -> TimeseriesdecompmovingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingGraphN::min(self : TimeseriesdecompmovingGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompmovingGraphN::max(self : TimeseriesdecompmovingGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompmovingGraphN::to_string(self : TimeseriesdecompmovingGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_node_make(size : Int) -> TimeseriesdecompmovingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompmovingNode::len(self : TimeseriesdecompmovingNode) -> Int { self.size }

pub fn TimeseriesdecompmovingNode::get(self : TimeseriesdecompmovingNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompmovingNode::set(self : TimeseriesdecompmovingNode, i : Int, v : Double) -> TimeseriesdecompmovingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingNode::sum(self : TimeseriesdecompmovingNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompmovingNode::mean(self : TimeseriesdecompmovingNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompmovingNode::scale(self : TimeseriesdecompmovingNode, f : Double) -> TimeseriesdecompmovingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingNode::add(self : TimeseriesdecompmovingNode, other : TimeseriesdecompmovingNode) -> TimeseriesdecompmovingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompmovingNode::copy(self : TimeseriesdecompmovingNode) -> TimeseriesdecompmovingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingNode::fill(self : TimeseriesdecompmovingNode, v : Double) -> TimeseriesdecompmovingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingNode::min(self : TimeseriesdecompmovingNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompmovingNode::max(self : TimeseriesdecompmovingNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompmovingNode::to_string(self : TimeseriesdecompmovingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_edge_make(size : Int) -> TimeseriesdecompmovingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompmovingEdge::len(self : TimeseriesdecompmovingEdge) -> Int { self.size }

pub fn TimeseriesdecompmovingEdge::get(self : TimeseriesdecompmovingEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompmovingEdge::set(self : TimeseriesdecompmovingEdge, i : Int, v : Double) -> TimeseriesdecompmovingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingEdge::sum(self : TimeseriesdecompmovingEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompmovingEdge::mean(self : TimeseriesdecompmovingEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompmovingEdge::scale(self : TimeseriesdecompmovingEdge, f : Double) -> TimeseriesdecompmovingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingEdge::add(self : TimeseriesdecompmovingEdge, other : TimeseriesdecompmovingEdge) -> TimeseriesdecompmovingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompmovingEdge::copy(self : TimeseriesdecompmovingEdge) -> TimeseriesdecompmovingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingEdge::fill(self : TimeseriesdecompmovingEdge, v : Double) -> TimeseriesdecompmovingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingEdge::min(self : TimeseriesdecompmovingEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompmovingEdge::max(self : TimeseriesdecompmovingEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompmovingEdge::to_string(self : TimeseriesdecompmovingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_path_make(size : Int) -> TimeseriesdecompmovingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompmovingPath::len(self : TimeseriesdecompmovingPath) -> Int { self.size }

pub fn TimeseriesdecompmovingPath::get(self : TimeseriesdecompmovingPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompmovingPath::set(self : TimeseriesdecompmovingPath, i : Int, v : Double) -> TimeseriesdecompmovingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingPath::sum(self : TimeseriesdecompmovingPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompmovingPath::mean(self : TimeseriesdecompmovingPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompmovingPath::scale(self : TimeseriesdecompmovingPath, f : Double) -> TimeseriesdecompmovingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingPath::add(self : TimeseriesdecompmovingPath, other : TimeseriesdecompmovingPath) -> TimeseriesdecompmovingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompmovingPath::copy(self : TimeseriesdecompmovingPath) -> TimeseriesdecompmovingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingPath::fill(self : TimeseriesdecompmovingPath, v : Double) -> TimeseriesdecompmovingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingPath::min(self : TimeseriesdecompmovingPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompmovingPath::max(self : TimeseriesdecompmovingPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompmovingPath::to_string(self : TimeseriesdecompmovingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_cluster_make(size : Int) -> TimeseriesdecompmovingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompmovingCluster::len(self : TimeseriesdecompmovingCluster) -> Int { self.size }

pub fn TimeseriesdecompmovingCluster::get(self : TimeseriesdecompmovingCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompmovingCluster::set(self : TimeseriesdecompmovingCluster, i : Int, v : Double) -> TimeseriesdecompmovingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingCluster::sum(self : TimeseriesdecompmovingCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompmovingCluster::mean(self : TimeseriesdecompmovingCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompmovingCluster::scale(self : TimeseriesdecompmovingCluster, f : Double) -> TimeseriesdecompmovingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingCluster::add(self : TimeseriesdecompmovingCluster, other : TimeseriesdecompmovingCluster) -> TimeseriesdecompmovingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompmovingCluster::copy(self : TimeseriesdecompmovingCluster) -> TimeseriesdecompmovingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingCluster::fill(self : TimeseriesdecompmovingCluster, v : Double) -> TimeseriesdecompmovingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingCluster::min(self : TimeseriesdecompmovingCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompmovingCluster::max(self : TimeseriesdecompmovingCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompmovingCluster::to_string(self : TimeseriesdecompmovingCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_model_make(size : Int) -> TimeseriesdecompmovingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompmovingModel::len(self : TimeseriesdecompmovingModel) -> Int { self.size }

pub fn TimeseriesdecompmovingModel::get(self : TimeseriesdecompmovingModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompmovingModel::set(self : TimeseriesdecompmovingModel, i : Int, v : Double) -> TimeseriesdecompmovingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingModel::sum(self : TimeseriesdecompmovingModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompmovingModel::mean(self : TimeseriesdecompmovingModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompmovingModel::scale(self : TimeseriesdecompmovingModel, f : Double) -> TimeseriesdecompmovingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingModel::add(self : TimeseriesdecompmovingModel, other : TimeseriesdecompmovingModel) -> TimeseriesdecompmovingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompmovingModel::copy(self : TimeseriesdecompmovingModel) -> TimeseriesdecompmovingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingModel::fill(self : TimeseriesdecompmovingModel, v : Double) -> TimeseriesdecompmovingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingModel::min(self : TimeseriesdecompmovingModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompmovingModel::max(self : TimeseriesdecompmovingModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompmovingModel::to_string(self : TimeseriesdecompmovingModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_layer_make(size : Int) -> TimeseriesdecompmovingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompmovingLayer::len(self : TimeseriesdecompmovingLayer) -> Int { self.size }

pub fn TimeseriesdecompmovingLayer::get(self : TimeseriesdecompmovingLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompmovingLayer::set(self : TimeseriesdecompmovingLayer, i : Int, v : Double) -> TimeseriesdecompmovingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingLayer::sum(self : TimeseriesdecompmovingLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompmovingLayer::mean(self : TimeseriesdecompmovingLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompmovingLayer::scale(self : TimeseriesdecompmovingLayer, f : Double) -> TimeseriesdecompmovingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingLayer::add(self : TimeseriesdecompmovingLayer, other : TimeseriesdecompmovingLayer) -> TimeseriesdecompmovingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompmovingLayer::copy(self : TimeseriesdecompmovingLayer) -> TimeseriesdecompmovingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingLayer::fill(self : TimeseriesdecompmovingLayer, v : Double) -> TimeseriesdecompmovingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingLayer::min(self : TimeseriesdecompmovingLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompmovingLayer::max(self : TimeseriesdecompmovingLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompmovingLayer::to_string(self : TimeseriesdecompmovingLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_buffer_make(size : Int) -> TimeseriesdecompmovingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompmovingBuffer::len(self : TimeseriesdecompmovingBuffer) -> Int { self.size }

pub fn TimeseriesdecompmovingBuffer::get(self : TimeseriesdecompmovingBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompmovingBuffer::set(self : TimeseriesdecompmovingBuffer, i : Int, v : Double) -> TimeseriesdecompmovingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingBuffer::sum(self : TimeseriesdecompmovingBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompmovingBuffer::mean(self : TimeseriesdecompmovingBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompmovingBuffer::scale(self : TimeseriesdecompmovingBuffer, f : Double) -> TimeseriesdecompmovingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingBuffer::add(self : TimeseriesdecompmovingBuffer, other : TimeseriesdecompmovingBuffer) -> TimeseriesdecompmovingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompmovingBuffer::copy(self : TimeseriesdecompmovingBuffer) -> TimeseriesdecompmovingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingBuffer::fill(self : TimeseriesdecompmovingBuffer, v : Double) -> TimeseriesdecompmovingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingBuffer::min(self : TimeseriesdecompmovingBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompmovingBuffer::max(self : TimeseriesdecompmovingBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompmovingBuffer::to_string(self : TimeseriesdecompmovingBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_cursor_make(size : Int) -> TimeseriesdecompmovingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompmovingCursor::len(self : TimeseriesdecompmovingCursor) -> Int { self.size }

pub fn TimeseriesdecompmovingCursor::get(self : TimeseriesdecompmovingCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompmovingCursor::set(self : TimeseriesdecompmovingCursor, i : Int, v : Double) -> TimeseriesdecompmovingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingCursor::sum(self : TimeseriesdecompmovingCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompmovingCursor::mean(self : TimeseriesdecompmovingCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompmovingCursor::scale(self : TimeseriesdecompmovingCursor, f : Double) -> TimeseriesdecompmovingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingCursor::add(self : TimeseriesdecompmovingCursor, other : TimeseriesdecompmovingCursor) -> TimeseriesdecompmovingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompmovingCursor::copy(self : TimeseriesdecompmovingCursor) -> TimeseriesdecompmovingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingCursor::fill(self : TimeseriesdecompmovingCursor, v : Double) -> TimeseriesdecompmovingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingCursor::min(self : TimeseriesdecompmovingCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompmovingCursor::max(self : TimeseriesdecompmovingCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompmovingCursor::to_string(self : TimeseriesdecompmovingCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_view_make(size : Int) -> TimeseriesdecompmovingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompmovingView::len(self : TimeseriesdecompmovingView) -> Int { self.size }

pub fn TimeseriesdecompmovingView::get(self : TimeseriesdecompmovingView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompmovingView::set(self : TimeseriesdecompmovingView, i : Int, v : Double) -> TimeseriesdecompmovingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingView::sum(self : TimeseriesdecompmovingView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompmovingView::mean(self : TimeseriesdecompmovingView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompmovingView::scale(self : TimeseriesdecompmovingView, f : Double) -> TimeseriesdecompmovingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingView::add(self : TimeseriesdecompmovingView, other : TimeseriesdecompmovingView) -> TimeseriesdecompmovingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompmovingView::copy(self : TimeseriesdecompmovingView) -> TimeseriesdecompmovingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingView::fill(self : TimeseriesdecompmovingView, v : Double) -> TimeseriesdecompmovingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingView::min(self : TimeseriesdecompmovingView) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompmovingView::max(self : TimeseriesdecompmovingView) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompmovingView::to_string(self : TimeseriesdecompmovingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_range_make(size : Int) -> TimeseriesdecompmovingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompmovingRange::len(self : TimeseriesdecompmovingRange) -> Int { self.size }

pub fn TimeseriesdecompmovingRange::get(self : TimeseriesdecompmovingRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompmovingRange::set(self : TimeseriesdecompmovingRange, i : Int, v : Double) -> TimeseriesdecompmovingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingRange::sum(self : TimeseriesdecompmovingRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompmovingRange::mean(self : TimeseriesdecompmovingRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompmovingRange::scale(self : TimeseriesdecompmovingRange, f : Double) -> TimeseriesdecompmovingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingRange::add(self : TimeseriesdecompmovingRange, other : TimeseriesdecompmovingRange) -> TimeseriesdecompmovingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompmovingRange::copy(self : TimeseriesdecompmovingRange) -> TimeseriesdecompmovingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingRange::fill(self : TimeseriesdecompmovingRange, v : Double) -> TimeseriesdecompmovingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingRange::min(self : TimeseriesdecompmovingRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompmovingRange::max(self : TimeseriesdecompmovingRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompmovingRange::to_string(self : TimeseriesdecompmovingRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_slice_make(size : Int) -> TimeseriesdecompmovingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompmovingSlice::len(self : TimeseriesdecompmovingSlice) -> Int { self.size }

pub fn TimeseriesdecompmovingSlice::get(self : TimeseriesdecompmovingSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompmovingSlice::set(self : TimeseriesdecompmovingSlice, i : Int, v : Double) -> TimeseriesdecompmovingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingSlice::sum(self : TimeseriesdecompmovingSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompmovingSlice::mean(self : TimeseriesdecompmovingSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompmovingSlice::scale(self : TimeseriesdecompmovingSlice, f : Double) -> TimeseriesdecompmovingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingSlice::add(self : TimeseriesdecompmovingSlice, other : TimeseriesdecompmovingSlice) -> TimeseriesdecompmovingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompmovingSlice::copy(self : TimeseriesdecompmovingSlice) -> TimeseriesdecompmovingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingSlice::fill(self : TimeseriesdecompmovingSlice, v : Double) -> TimeseriesdecompmovingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompmovingSlice::min(self : TimeseriesdecompmovingSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompmovingSlice::max(self : TimeseriesdecompmovingSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompmovingSlice::to_string(self : TimeseriesdecompmovingSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

