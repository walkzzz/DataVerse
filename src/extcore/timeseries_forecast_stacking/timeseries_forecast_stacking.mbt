///===
/// extcore/timeseries_forecast_stacking

pub(all) struct TimeseriesforecaststackingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_stacking_make_point(x : Double, y : Double) -> TimeseriesforecaststackingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_stacking_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecaststackingPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecaststackingPoint::x(self : TimeseriesforecaststackingPoint) -> Double { self.x }

pub fn TimeseriesforecaststackingPoint::y(self : TimeseriesforecaststackingPoint) -> Double { self.y }

pub fn TimeseriesforecaststackingPoint::z(self : TimeseriesforecaststackingPoint) -> Double { self.z }

pub fn TimeseriesforecaststackingPoint::label(self : TimeseriesforecaststackingPoint) -> Int { self.label }

pub fn TimeseriesforecaststackingPoint::dist(self : TimeseriesforecaststackingPoint, other : TimeseriesforecaststackingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecaststackingPoint::add(self : TimeseriesforecaststackingPoint, other : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecaststackingPoint::sub(self : TimeseriesforecaststackingPoint, other : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecaststackingPoint::scale(self : TimeseriesforecaststackingPoint, s : Double) -> TimeseriesforecaststackingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecaststackingPoint::dot(self : TimeseriesforecaststackingPoint, other : TimeseriesforecaststackingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecaststackingPoint::cross(self : TimeseriesforecaststackingPoint, other : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecaststackingPoint::norm(self : TimeseriesforecaststackingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecaststackingPoint::normalize(self : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecaststackingPoint::negate(self : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecaststackingPoint::mid(self : TimeseriesforecaststackingPoint, other : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecaststackingPoint::lerp(self : TimeseriesforecaststackingPoint, other : TimeseriesforecaststackingPoint, t : Double) -> TimeseriesforecaststackingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecaststackingPoint::to_string(self : TimeseriesforecaststackingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_stacking_make_series(vals : Array[Double], name : String) -> TimeseriesforecaststackingSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecaststackingSeries::len(self : TimeseriesforecaststackingSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecaststackingSeries::sum(self : TimeseriesforecaststackingSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecaststackingSeries::mean(self : TimeseriesforecaststackingSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecaststackingSeries::min(self : TimeseriesforecaststackingSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecaststackingSeries::max(self : TimeseriesforecaststackingSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecaststackingSeries::range(self : TimeseriesforecaststackingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecaststackingSeries::variance(self : TimeseriesforecaststackingSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecaststackingSeries::std(self : TimeseriesforecaststackingSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecaststackingSeries::median(self : TimeseriesforecaststackingSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecaststackingSeries::scale(self : TimeseriesforecaststackingSeries, f : Double) -> TimeseriesforecaststackingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecaststackingSeries::add(self : TimeseriesforecaststackingSeries, other : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecaststackingSeries::sub(self : TimeseriesforecaststackingSeries, other : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecaststackingSeries::normalize(self : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecaststackingSeries::cumsum(self : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecaststackingSeries::to_string(self : TimeseriesforecaststackingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecaststackingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_stacking_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecaststackingMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn timeseries_forecast_stacking_matrix_identity(n : Int) -> TimeseriesforecaststackingMatrix {
  let m = timeseries_forecast_stacking_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecaststackingMatrix::get(self : TimeseriesforecaststackingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecaststackingMatrix::transpose(self : TimeseriesforecaststackingMatrix) -> TimeseriesforecaststackingMatrix {
  let result = timeseries_forecast_stacking_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecaststackingMatrix::add(self : TimeseriesforecaststackingMatrix, other : TimeseriesforecaststackingMatrix) -> TimeseriesforecaststackingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_stacking_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecaststackingMatrix::scale(self : TimeseriesforecaststackingMatrix, s : Double) -> TimeseriesforecaststackingMatrix {
  let result = timeseries_forecast_stacking_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecaststackingMatrix::multiply(self : TimeseriesforecaststackingMatrix, other : TimeseriesforecaststackingMatrix) -> TimeseriesforecaststackingMatrix {
  if self.cols != other.rows { return timeseries_forecast_stacking_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_stacking_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn TimeseriesforecaststackingMatrix::trace(self : TimeseriesforecaststackingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecaststackingMatrix::det(self : TimeseriesforecaststackingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecaststackingMatrix::norm(self : TimeseriesforecaststackingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecaststackingMatrix::to_string(self : TimeseriesforecaststackingMatrix) -> String {
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

pub(all) struct TimeseriesforecaststackingVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_stacking_make_vector(comps : Array[Double]) -> TimeseriesforecaststackingVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_stacking_vector_zero(dim : Int) -> TimeseriesforecaststackingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecaststackingVector::add(self : TimeseriesforecaststackingVector, other : TimeseriesforecaststackingVector) -> TimeseriesforecaststackingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecaststackingVector::sub(self : TimeseriesforecaststackingVector, other : TimeseriesforecaststackingVector) -> TimeseriesforecaststackingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecaststackingVector::scale(self : TimeseriesforecaststackingVector, s : Double) -> TimeseriesforecaststackingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecaststackingVector::dot(self : TimeseriesforecaststackingVector, other : TimeseriesforecaststackingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecaststackingVector::norm(self : TimeseriesforecaststackingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecaststackingVector::normalize(self : TimeseriesforecaststackingVector) -> TimeseriesforecaststackingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecaststackingVector::dist(self : TimeseriesforecaststackingVector, other : TimeseriesforecaststackingVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecaststackingVector::to_string(self : TimeseriesforecaststackingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecaststackingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_frame_make(size : Int) -> TimeseriesforecaststackingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecaststackingFrame::len(self : TimeseriesforecaststackingFrame) -> Int { self.size }

pub fn TimeseriesforecaststackingFrame::get(self : TimeseriesforecaststackingFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecaststackingFrame::set(self : TimeseriesforecaststackingFrame, i : Int, v : Double) -> TimeseriesforecaststackingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingFrame::sum(self : TimeseriesforecaststackingFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecaststackingFrame::mean(self : TimeseriesforecaststackingFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecaststackingFrame::scale(self : TimeseriesforecaststackingFrame, f : Double) -> TimeseriesforecaststackingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingFrame::add(self : TimeseriesforecaststackingFrame, other : TimeseriesforecaststackingFrame) -> TimeseriesforecaststackingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecaststackingFrame::copy(self : TimeseriesforecaststackingFrame) -> TimeseriesforecaststackingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingFrame::fill(self : TimeseriesforecaststackingFrame, v : Double) -> TimeseriesforecaststackingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingFrame::min(self : TimeseriesforecaststackingFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecaststackingFrame::max(self : TimeseriesforecaststackingFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecaststackingFrame::to_string(self : TimeseriesforecaststackingFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_table_make(size : Int) -> TimeseriesforecaststackingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecaststackingTable::len(self : TimeseriesforecaststackingTable) -> Int { self.size }

pub fn TimeseriesforecaststackingTable::get(self : TimeseriesforecaststackingTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecaststackingTable::set(self : TimeseriesforecaststackingTable, i : Int, v : Double) -> TimeseriesforecaststackingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingTable::sum(self : TimeseriesforecaststackingTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecaststackingTable::mean(self : TimeseriesforecaststackingTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecaststackingTable::scale(self : TimeseriesforecaststackingTable, f : Double) -> TimeseriesforecaststackingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingTable::add(self : TimeseriesforecaststackingTable, other : TimeseriesforecaststackingTable) -> TimeseriesforecaststackingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecaststackingTable::copy(self : TimeseriesforecaststackingTable) -> TimeseriesforecaststackingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingTable::fill(self : TimeseriesforecaststackingTable, v : Double) -> TimeseriesforecaststackingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingTable::min(self : TimeseriesforecaststackingTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecaststackingTable::max(self : TimeseriesforecaststackingTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecaststackingTable::to_string(self : TimeseriesforecaststackingTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_graphn_make(size : Int) -> TimeseriesforecaststackingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecaststackingGraphN::len(self : TimeseriesforecaststackingGraphN) -> Int { self.size }

pub fn TimeseriesforecaststackingGraphN::get(self : TimeseriesforecaststackingGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecaststackingGraphN::set(self : TimeseriesforecaststackingGraphN, i : Int, v : Double) -> TimeseriesforecaststackingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingGraphN::sum(self : TimeseriesforecaststackingGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecaststackingGraphN::mean(self : TimeseriesforecaststackingGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecaststackingGraphN::scale(self : TimeseriesforecaststackingGraphN, f : Double) -> TimeseriesforecaststackingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingGraphN::add(self : TimeseriesforecaststackingGraphN, other : TimeseriesforecaststackingGraphN) -> TimeseriesforecaststackingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecaststackingGraphN::copy(self : TimeseriesforecaststackingGraphN) -> TimeseriesforecaststackingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingGraphN::fill(self : TimeseriesforecaststackingGraphN, v : Double) -> TimeseriesforecaststackingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingGraphN::min(self : TimeseriesforecaststackingGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecaststackingGraphN::max(self : TimeseriesforecaststackingGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecaststackingGraphN::to_string(self : TimeseriesforecaststackingGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_node_make(size : Int) -> TimeseriesforecaststackingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecaststackingNode::len(self : TimeseriesforecaststackingNode) -> Int { self.size }

pub fn TimeseriesforecaststackingNode::get(self : TimeseriesforecaststackingNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecaststackingNode::set(self : TimeseriesforecaststackingNode, i : Int, v : Double) -> TimeseriesforecaststackingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingNode::sum(self : TimeseriesforecaststackingNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecaststackingNode::mean(self : TimeseriesforecaststackingNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecaststackingNode::scale(self : TimeseriesforecaststackingNode, f : Double) -> TimeseriesforecaststackingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingNode::add(self : TimeseriesforecaststackingNode, other : TimeseriesforecaststackingNode) -> TimeseriesforecaststackingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecaststackingNode::copy(self : TimeseriesforecaststackingNode) -> TimeseriesforecaststackingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingNode::fill(self : TimeseriesforecaststackingNode, v : Double) -> TimeseriesforecaststackingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingNode::min(self : TimeseriesforecaststackingNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecaststackingNode::max(self : TimeseriesforecaststackingNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecaststackingNode::to_string(self : TimeseriesforecaststackingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_edge_make(size : Int) -> TimeseriesforecaststackingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecaststackingEdge::len(self : TimeseriesforecaststackingEdge) -> Int { self.size }

pub fn TimeseriesforecaststackingEdge::get(self : TimeseriesforecaststackingEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecaststackingEdge::set(self : TimeseriesforecaststackingEdge, i : Int, v : Double) -> TimeseriesforecaststackingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingEdge::sum(self : TimeseriesforecaststackingEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecaststackingEdge::mean(self : TimeseriesforecaststackingEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecaststackingEdge::scale(self : TimeseriesforecaststackingEdge, f : Double) -> TimeseriesforecaststackingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingEdge::add(self : TimeseriesforecaststackingEdge, other : TimeseriesforecaststackingEdge) -> TimeseriesforecaststackingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecaststackingEdge::copy(self : TimeseriesforecaststackingEdge) -> TimeseriesforecaststackingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingEdge::fill(self : TimeseriesforecaststackingEdge, v : Double) -> TimeseriesforecaststackingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingEdge::min(self : TimeseriesforecaststackingEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecaststackingEdge::max(self : TimeseriesforecaststackingEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecaststackingEdge::to_string(self : TimeseriesforecaststackingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_path_make(size : Int) -> TimeseriesforecaststackingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecaststackingPath::len(self : TimeseriesforecaststackingPath) -> Int { self.size }

pub fn TimeseriesforecaststackingPath::get(self : TimeseriesforecaststackingPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecaststackingPath::set(self : TimeseriesforecaststackingPath, i : Int, v : Double) -> TimeseriesforecaststackingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingPath::sum(self : TimeseriesforecaststackingPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecaststackingPath::mean(self : TimeseriesforecaststackingPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecaststackingPath::scale(self : TimeseriesforecaststackingPath, f : Double) -> TimeseriesforecaststackingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingPath::add(self : TimeseriesforecaststackingPath, other : TimeseriesforecaststackingPath) -> TimeseriesforecaststackingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecaststackingPath::copy(self : TimeseriesforecaststackingPath) -> TimeseriesforecaststackingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingPath::fill(self : TimeseriesforecaststackingPath, v : Double) -> TimeseriesforecaststackingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingPath::min(self : TimeseriesforecaststackingPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecaststackingPath::max(self : TimeseriesforecaststackingPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecaststackingPath::to_string(self : TimeseriesforecaststackingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_cluster_make(size : Int) -> TimeseriesforecaststackingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecaststackingCluster::len(self : TimeseriesforecaststackingCluster) -> Int { self.size }

pub fn TimeseriesforecaststackingCluster::get(self : TimeseriesforecaststackingCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecaststackingCluster::set(self : TimeseriesforecaststackingCluster, i : Int, v : Double) -> TimeseriesforecaststackingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingCluster::sum(self : TimeseriesforecaststackingCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecaststackingCluster::mean(self : TimeseriesforecaststackingCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecaststackingCluster::scale(self : TimeseriesforecaststackingCluster, f : Double) -> TimeseriesforecaststackingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingCluster::add(self : TimeseriesforecaststackingCluster, other : TimeseriesforecaststackingCluster) -> TimeseriesforecaststackingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecaststackingCluster::copy(self : TimeseriesforecaststackingCluster) -> TimeseriesforecaststackingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingCluster::fill(self : TimeseriesforecaststackingCluster, v : Double) -> TimeseriesforecaststackingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingCluster::min(self : TimeseriesforecaststackingCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecaststackingCluster::max(self : TimeseriesforecaststackingCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecaststackingCluster::to_string(self : TimeseriesforecaststackingCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_model_make(size : Int) -> TimeseriesforecaststackingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecaststackingModel::len(self : TimeseriesforecaststackingModel) -> Int { self.size }

pub fn TimeseriesforecaststackingModel::get(self : TimeseriesforecaststackingModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecaststackingModel::set(self : TimeseriesforecaststackingModel, i : Int, v : Double) -> TimeseriesforecaststackingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingModel::sum(self : TimeseriesforecaststackingModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecaststackingModel::mean(self : TimeseriesforecaststackingModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecaststackingModel::scale(self : TimeseriesforecaststackingModel, f : Double) -> TimeseriesforecaststackingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingModel::add(self : TimeseriesforecaststackingModel, other : TimeseriesforecaststackingModel) -> TimeseriesforecaststackingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecaststackingModel::copy(self : TimeseriesforecaststackingModel) -> TimeseriesforecaststackingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingModel::fill(self : TimeseriesforecaststackingModel, v : Double) -> TimeseriesforecaststackingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingModel::min(self : TimeseriesforecaststackingModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecaststackingModel::max(self : TimeseriesforecaststackingModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecaststackingModel::to_string(self : TimeseriesforecaststackingModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_layer_make(size : Int) -> TimeseriesforecaststackingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecaststackingLayer::len(self : TimeseriesforecaststackingLayer) -> Int { self.size }

pub fn TimeseriesforecaststackingLayer::get(self : TimeseriesforecaststackingLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecaststackingLayer::set(self : TimeseriesforecaststackingLayer, i : Int, v : Double) -> TimeseriesforecaststackingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingLayer::sum(self : TimeseriesforecaststackingLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecaststackingLayer::mean(self : TimeseriesforecaststackingLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecaststackingLayer::scale(self : TimeseriesforecaststackingLayer, f : Double) -> TimeseriesforecaststackingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingLayer::add(self : TimeseriesforecaststackingLayer, other : TimeseriesforecaststackingLayer) -> TimeseriesforecaststackingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecaststackingLayer::copy(self : TimeseriesforecaststackingLayer) -> TimeseriesforecaststackingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingLayer::fill(self : TimeseriesforecaststackingLayer, v : Double) -> TimeseriesforecaststackingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingLayer::min(self : TimeseriesforecaststackingLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecaststackingLayer::max(self : TimeseriesforecaststackingLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecaststackingLayer::to_string(self : TimeseriesforecaststackingLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_buffer_make(size : Int) -> TimeseriesforecaststackingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecaststackingBuffer::len(self : TimeseriesforecaststackingBuffer) -> Int { self.size }

pub fn TimeseriesforecaststackingBuffer::get(self : TimeseriesforecaststackingBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecaststackingBuffer::set(self : TimeseriesforecaststackingBuffer, i : Int, v : Double) -> TimeseriesforecaststackingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingBuffer::sum(self : TimeseriesforecaststackingBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecaststackingBuffer::mean(self : TimeseriesforecaststackingBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecaststackingBuffer::scale(self : TimeseriesforecaststackingBuffer, f : Double) -> TimeseriesforecaststackingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingBuffer::add(self : TimeseriesforecaststackingBuffer, other : TimeseriesforecaststackingBuffer) -> TimeseriesforecaststackingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecaststackingBuffer::copy(self : TimeseriesforecaststackingBuffer) -> TimeseriesforecaststackingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingBuffer::fill(self : TimeseriesforecaststackingBuffer, v : Double) -> TimeseriesforecaststackingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingBuffer::min(self : TimeseriesforecaststackingBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecaststackingBuffer::max(self : TimeseriesforecaststackingBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecaststackingBuffer::to_string(self : TimeseriesforecaststackingBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_cursor_make(size : Int) -> TimeseriesforecaststackingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecaststackingCursor::len(self : TimeseriesforecaststackingCursor) -> Int { self.size }

pub fn TimeseriesforecaststackingCursor::get(self : TimeseriesforecaststackingCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecaststackingCursor::set(self : TimeseriesforecaststackingCursor, i : Int, v : Double) -> TimeseriesforecaststackingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingCursor::sum(self : TimeseriesforecaststackingCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecaststackingCursor::mean(self : TimeseriesforecaststackingCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecaststackingCursor::scale(self : TimeseriesforecaststackingCursor, f : Double) -> TimeseriesforecaststackingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingCursor::add(self : TimeseriesforecaststackingCursor, other : TimeseriesforecaststackingCursor) -> TimeseriesforecaststackingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecaststackingCursor::copy(self : TimeseriesforecaststackingCursor) -> TimeseriesforecaststackingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingCursor::fill(self : TimeseriesforecaststackingCursor, v : Double) -> TimeseriesforecaststackingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingCursor::min(self : TimeseriesforecaststackingCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecaststackingCursor::max(self : TimeseriesforecaststackingCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecaststackingCursor::to_string(self : TimeseriesforecaststackingCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_view_make(size : Int) -> TimeseriesforecaststackingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecaststackingView::len(self : TimeseriesforecaststackingView) -> Int { self.size }

pub fn TimeseriesforecaststackingView::get(self : TimeseriesforecaststackingView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecaststackingView::set(self : TimeseriesforecaststackingView, i : Int, v : Double) -> TimeseriesforecaststackingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingView::sum(self : TimeseriesforecaststackingView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecaststackingView::mean(self : TimeseriesforecaststackingView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecaststackingView::scale(self : TimeseriesforecaststackingView, f : Double) -> TimeseriesforecaststackingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingView::add(self : TimeseriesforecaststackingView, other : TimeseriesforecaststackingView) -> TimeseriesforecaststackingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecaststackingView::copy(self : TimeseriesforecaststackingView) -> TimeseriesforecaststackingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingView::fill(self : TimeseriesforecaststackingView, v : Double) -> TimeseriesforecaststackingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingView::min(self : TimeseriesforecaststackingView) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecaststackingView::max(self : TimeseriesforecaststackingView) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecaststackingView::to_string(self : TimeseriesforecaststackingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_range_make(size : Int) -> TimeseriesforecaststackingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecaststackingRange::len(self : TimeseriesforecaststackingRange) -> Int { self.size }

pub fn TimeseriesforecaststackingRange::get(self : TimeseriesforecaststackingRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecaststackingRange::set(self : TimeseriesforecaststackingRange, i : Int, v : Double) -> TimeseriesforecaststackingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingRange::sum(self : TimeseriesforecaststackingRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecaststackingRange::mean(self : TimeseriesforecaststackingRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecaststackingRange::scale(self : TimeseriesforecaststackingRange, f : Double) -> TimeseriesforecaststackingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingRange::add(self : TimeseriesforecaststackingRange, other : TimeseriesforecaststackingRange) -> TimeseriesforecaststackingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecaststackingRange::copy(self : TimeseriesforecaststackingRange) -> TimeseriesforecaststackingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingRange::fill(self : TimeseriesforecaststackingRange, v : Double) -> TimeseriesforecaststackingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingRange::min(self : TimeseriesforecaststackingRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecaststackingRange::max(self : TimeseriesforecaststackingRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecaststackingRange::to_string(self : TimeseriesforecaststackingRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_slice_make(size : Int) -> TimeseriesforecaststackingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecaststackingSlice::len(self : TimeseriesforecaststackingSlice) -> Int { self.size }

pub fn TimeseriesforecaststackingSlice::get(self : TimeseriesforecaststackingSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecaststackingSlice::set(self : TimeseriesforecaststackingSlice, i : Int, v : Double) -> TimeseriesforecaststackingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingSlice::sum(self : TimeseriesforecaststackingSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecaststackingSlice::mean(self : TimeseriesforecaststackingSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecaststackingSlice::scale(self : TimeseriesforecaststackingSlice, f : Double) -> TimeseriesforecaststackingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingSlice::add(self : TimeseriesforecaststackingSlice, other : TimeseriesforecaststackingSlice) -> TimeseriesforecaststackingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecaststackingSlice::copy(self : TimeseriesforecaststackingSlice) -> TimeseriesforecaststackingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingSlice::fill(self : TimeseriesforecaststackingSlice, v : Double) -> TimeseriesforecaststackingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecaststackingSlice::min(self : TimeseriesforecaststackingSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecaststackingSlice::max(self : TimeseriesforecaststackingSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecaststackingSlice::to_string(self : TimeseriesforecaststackingSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

