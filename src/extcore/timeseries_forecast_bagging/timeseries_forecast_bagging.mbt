///===
/// extcore/timeseries_forecast_bagging

pub(all) struct TimeseriesforecastbaggingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_bagging_make_point(x : Double, y : Double) -> TimeseriesforecastbaggingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_bagging_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastbaggingPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecastbaggingPoint::x(self : TimeseriesforecastbaggingPoint) -> Double { self.x }

pub fn TimeseriesforecastbaggingPoint::y(self : TimeseriesforecastbaggingPoint) -> Double { self.y }

pub fn TimeseriesforecastbaggingPoint::z(self : TimeseriesforecastbaggingPoint) -> Double { self.z }

pub fn TimeseriesforecastbaggingPoint::label(self : TimeseriesforecastbaggingPoint) -> Int { self.label }

pub fn TimeseriesforecastbaggingPoint::dist(self : TimeseriesforecastbaggingPoint, other : TimeseriesforecastbaggingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecastbaggingPoint::add(self : TimeseriesforecastbaggingPoint, other : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecastbaggingPoint::sub(self : TimeseriesforecastbaggingPoint, other : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecastbaggingPoint::scale(self : TimeseriesforecastbaggingPoint, s : Double) -> TimeseriesforecastbaggingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecastbaggingPoint::dot(self : TimeseriesforecastbaggingPoint, other : TimeseriesforecastbaggingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecastbaggingPoint::cross(self : TimeseriesforecastbaggingPoint, other : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecastbaggingPoint::norm(self : TimeseriesforecastbaggingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecastbaggingPoint::normalize(self : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastbaggingPoint::negate(self : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecastbaggingPoint::mid(self : TimeseriesforecastbaggingPoint, other : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecastbaggingPoint::lerp(self : TimeseriesforecastbaggingPoint, other : TimeseriesforecastbaggingPoint, t : Double) -> TimeseriesforecastbaggingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecastbaggingPoint::to_string(self : TimeseriesforecastbaggingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_bagging_make_series(vals : Array[Double], name : String) -> TimeseriesforecastbaggingSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecastbaggingSeries::len(self : TimeseriesforecastbaggingSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecastbaggingSeries::sum(self : TimeseriesforecastbaggingSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecastbaggingSeries::mean(self : TimeseriesforecastbaggingSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecastbaggingSeries::min(self : TimeseriesforecastbaggingSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecastbaggingSeries::max(self : TimeseriesforecastbaggingSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecastbaggingSeries::range(self : TimeseriesforecastbaggingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecastbaggingSeries::variance(self : TimeseriesforecastbaggingSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecastbaggingSeries::std(self : TimeseriesforecastbaggingSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecastbaggingSeries::median(self : TimeseriesforecastbaggingSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecastbaggingSeries::scale(self : TimeseriesforecastbaggingSeries, f : Double) -> TimeseriesforecastbaggingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecastbaggingSeries::add(self : TimeseriesforecastbaggingSeries, other : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastbaggingSeries::sub(self : TimeseriesforecastbaggingSeries, other : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastbaggingSeries::normalize(self : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecastbaggingSeries::cumsum(self : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecastbaggingSeries::to_string(self : TimeseriesforecastbaggingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastbaggingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_bagging_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastbaggingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_bagging_matrix_identity(n : Int) -> TimeseriesforecastbaggingMatrix {
  let m = timeseries_forecast_bagging_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecastbaggingMatrix::get(self : TimeseriesforecastbaggingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecastbaggingMatrix::transpose(self : TimeseriesforecastbaggingMatrix) -> TimeseriesforecastbaggingMatrix {
  let result = timeseries_forecast_bagging_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecastbaggingMatrix::add(self : TimeseriesforecastbaggingMatrix, other : TimeseriesforecastbaggingMatrix) -> TimeseriesforecastbaggingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_bagging_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecastbaggingMatrix::scale(self : TimeseriesforecastbaggingMatrix, s : Double) -> TimeseriesforecastbaggingMatrix {
  let result = timeseries_forecast_bagging_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecastbaggingMatrix::multiply(self : TimeseriesforecastbaggingMatrix, other : TimeseriesforecastbaggingMatrix) -> TimeseriesforecastbaggingMatrix {
  if self.cols != other.rows { return timeseries_forecast_bagging_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_bagging_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesforecastbaggingMatrix::trace(self : TimeseriesforecastbaggingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecastbaggingMatrix::det(self : TimeseriesforecastbaggingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecastbaggingMatrix::norm(self : TimeseriesforecastbaggingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecastbaggingMatrix::to_string(self : TimeseriesforecastbaggingMatrix) -> String {
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

pub(all) struct TimeseriesforecastbaggingVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_bagging_make_vector(comps : Array[Double]) -> TimeseriesforecastbaggingVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_bagging_vector_zero(dim : Int) -> TimeseriesforecastbaggingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecastbaggingVector::add(self : TimeseriesforecastbaggingVector, other : TimeseriesforecastbaggingVector) -> TimeseriesforecastbaggingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastbaggingVector::sub(self : TimeseriesforecastbaggingVector, other : TimeseriesforecastbaggingVector) -> TimeseriesforecastbaggingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastbaggingVector::scale(self : TimeseriesforecastbaggingVector, s : Double) -> TimeseriesforecastbaggingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecastbaggingVector::dot(self : TimeseriesforecastbaggingVector, other : TimeseriesforecastbaggingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecastbaggingVector::norm(self : TimeseriesforecastbaggingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecastbaggingVector::normalize(self : TimeseriesforecastbaggingVector) -> TimeseriesforecastbaggingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastbaggingVector::dist(self : TimeseriesforecastbaggingVector, other : TimeseriesforecastbaggingVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecastbaggingVector::to_string(self : TimeseriesforecastbaggingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastbaggingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_frame_make(size : Int) -> TimeseriesforecastbaggingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastbaggingFrame::len(self : TimeseriesforecastbaggingFrame) -> Int { self.size }

pub fn TimeseriesforecastbaggingFrame::get(self : TimeseriesforecastbaggingFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastbaggingFrame::set(self : TimeseriesforecastbaggingFrame, i : Int, v : Double) -> TimeseriesforecastbaggingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingFrame::sum(self : TimeseriesforecastbaggingFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastbaggingFrame::mean(self : TimeseriesforecastbaggingFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastbaggingFrame::scale(self : TimeseriesforecastbaggingFrame, f : Double) -> TimeseriesforecastbaggingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingFrame::add(self : TimeseriesforecastbaggingFrame, other : TimeseriesforecastbaggingFrame) -> TimeseriesforecastbaggingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastbaggingFrame::copy(self : TimeseriesforecastbaggingFrame) -> TimeseriesforecastbaggingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingFrame::fill(self : TimeseriesforecastbaggingFrame, v : Double) -> TimeseriesforecastbaggingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingFrame::min(self : TimeseriesforecastbaggingFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastbaggingFrame::max(self : TimeseriesforecastbaggingFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastbaggingFrame::to_string(self : TimeseriesforecastbaggingFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_table_make(size : Int) -> TimeseriesforecastbaggingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastbaggingTable::len(self : TimeseriesforecastbaggingTable) -> Int { self.size }

pub fn TimeseriesforecastbaggingTable::get(self : TimeseriesforecastbaggingTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastbaggingTable::set(self : TimeseriesforecastbaggingTable, i : Int, v : Double) -> TimeseriesforecastbaggingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingTable::sum(self : TimeseriesforecastbaggingTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastbaggingTable::mean(self : TimeseriesforecastbaggingTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastbaggingTable::scale(self : TimeseriesforecastbaggingTable, f : Double) -> TimeseriesforecastbaggingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingTable::add(self : TimeseriesforecastbaggingTable, other : TimeseriesforecastbaggingTable) -> TimeseriesforecastbaggingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastbaggingTable::copy(self : TimeseriesforecastbaggingTable) -> TimeseriesforecastbaggingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingTable::fill(self : TimeseriesforecastbaggingTable, v : Double) -> TimeseriesforecastbaggingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingTable::min(self : TimeseriesforecastbaggingTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastbaggingTable::max(self : TimeseriesforecastbaggingTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastbaggingTable::to_string(self : TimeseriesforecastbaggingTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_graphn_make(size : Int) -> TimeseriesforecastbaggingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastbaggingGraphN::len(self : TimeseriesforecastbaggingGraphN) -> Int { self.size }

pub fn TimeseriesforecastbaggingGraphN::get(self : TimeseriesforecastbaggingGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastbaggingGraphN::set(self : TimeseriesforecastbaggingGraphN, i : Int, v : Double) -> TimeseriesforecastbaggingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingGraphN::sum(self : TimeseriesforecastbaggingGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastbaggingGraphN::mean(self : TimeseriesforecastbaggingGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastbaggingGraphN::scale(self : TimeseriesforecastbaggingGraphN, f : Double) -> TimeseriesforecastbaggingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingGraphN::add(self : TimeseriesforecastbaggingGraphN, other : TimeseriesforecastbaggingGraphN) -> TimeseriesforecastbaggingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastbaggingGraphN::copy(self : TimeseriesforecastbaggingGraphN) -> TimeseriesforecastbaggingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingGraphN::fill(self : TimeseriesforecastbaggingGraphN, v : Double) -> TimeseriesforecastbaggingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingGraphN::min(self : TimeseriesforecastbaggingGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastbaggingGraphN::max(self : TimeseriesforecastbaggingGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastbaggingGraphN::to_string(self : TimeseriesforecastbaggingGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_node_make(size : Int) -> TimeseriesforecastbaggingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastbaggingNode::len(self : TimeseriesforecastbaggingNode) -> Int { self.size }

pub fn TimeseriesforecastbaggingNode::get(self : TimeseriesforecastbaggingNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastbaggingNode::set(self : TimeseriesforecastbaggingNode, i : Int, v : Double) -> TimeseriesforecastbaggingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingNode::sum(self : TimeseriesforecastbaggingNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastbaggingNode::mean(self : TimeseriesforecastbaggingNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastbaggingNode::scale(self : TimeseriesforecastbaggingNode, f : Double) -> TimeseriesforecastbaggingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingNode::add(self : TimeseriesforecastbaggingNode, other : TimeseriesforecastbaggingNode) -> TimeseriesforecastbaggingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastbaggingNode::copy(self : TimeseriesforecastbaggingNode) -> TimeseriesforecastbaggingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingNode::fill(self : TimeseriesforecastbaggingNode, v : Double) -> TimeseriesforecastbaggingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingNode::min(self : TimeseriesforecastbaggingNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastbaggingNode::max(self : TimeseriesforecastbaggingNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastbaggingNode::to_string(self : TimeseriesforecastbaggingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_edge_make(size : Int) -> TimeseriesforecastbaggingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastbaggingEdge::len(self : TimeseriesforecastbaggingEdge) -> Int { self.size }

pub fn TimeseriesforecastbaggingEdge::get(self : TimeseriesforecastbaggingEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastbaggingEdge::set(self : TimeseriesforecastbaggingEdge, i : Int, v : Double) -> TimeseriesforecastbaggingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingEdge::sum(self : TimeseriesforecastbaggingEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastbaggingEdge::mean(self : TimeseriesforecastbaggingEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastbaggingEdge::scale(self : TimeseriesforecastbaggingEdge, f : Double) -> TimeseriesforecastbaggingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingEdge::add(self : TimeseriesforecastbaggingEdge, other : TimeseriesforecastbaggingEdge) -> TimeseriesforecastbaggingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastbaggingEdge::copy(self : TimeseriesforecastbaggingEdge) -> TimeseriesforecastbaggingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingEdge::fill(self : TimeseriesforecastbaggingEdge, v : Double) -> TimeseriesforecastbaggingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingEdge::min(self : TimeseriesforecastbaggingEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastbaggingEdge::max(self : TimeseriesforecastbaggingEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastbaggingEdge::to_string(self : TimeseriesforecastbaggingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_path_make(size : Int) -> TimeseriesforecastbaggingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastbaggingPath::len(self : TimeseriesforecastbaggingPath) -> Int { self.size }

pub fn TimeseriesforecastbaggingPath::get(self : TimeseriesforecastbaggingPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastbaggingPath::set(self : TimeseriesforecastbaggingPath, i : Int, v : Double) -> TimeseriesforecastbaggingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingPath::sum(self : TimeseriesforecastbaggingPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastbaggingPath::mean(self : TimeseriesforecastbaggingPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastbaggingPath::scale(self : TimeseriesforecastbaggingPath, f : Double) -> TimeseriesforecastbaggingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingPath::add(self : TimeseriesforecastbaggingPath, other : TimeseriesforecastbaggingPath) -> TimeseriesforecastbaggingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastbaggingPath::copy(self : TimeseriesforecastbaggingPath) -> TimeseriesforecastbaggingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingPath::fill(self : TimeseriesforecastbaggingPath, v : Double) -> TimeseriesforecastbaggingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingPath::min(self : TimeseriesforecastbaggingPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastbaggingPath::max(self : TimeseriesforecastbaggingPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastbaggingPath::to_string(self : TimeseriesforecastbaggingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_cluster_make(size : Int) -> TimeseriesforecastbaggingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastbaggingCluster::len(self : TimeseriesforecastbaggingCluster) -> Int { self.size }

pub fn TimeseriesforecastbaggingCluster::get(self : TimeseriesforecastbaggingCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastbaggingCluster::set(self : TimeseriesforecastbaggingCluster, i : Int, v : Double) -> TimeseriesforecastbaggingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingCluster::sum(self : TimeseriesforecastbaggingCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastbaggingCluster::mean(self : TimeseriesforecastbaggingCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastbaggingCluster::scale(self : TimeseriesforecastbaggingCluster, f : Double) -> TimeseriesforecastbaggingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingCluster::add(self : TimeseriesforecastbaggingCluster, other : TimeseriesforecastbaggingCluster) -> TimeseriesforecastbaggingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastbaggingCluster::copy(self : TimeseriesforecastbaggingCluster) -> TimeseriesforecastbaggingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingCluster::fill(self : TimeseriesforecastbaggingCluster, v : Double) -> TimeseriesforecastbaggingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingCluster::min(self : TimeseriesforecastbaggingCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastbaggingCluster::max(self : TimeseriesforecastbaggingCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastbaggingCluster::to_string(self : TimeseriesforecastbaggingCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_model_make(size : Int) -> TimeseriesforecastbaggingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastbaggingModel::len(self : TimeseriesforecastbaggingModel) -> Int { self.size }

pub fn TimeseriesforecastbaggingModel::get(self : TimeseriesforecastbaggingModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastbaggingModel::set(self : TimeseriesforecastbaggingModel, i : Int, v : Double) -> TimeseriesforecastbaggingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingModel::sum(self : TimeseriesforecastbaggingModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastbaggingModel::mean(self : TimeseriesforecastbaggingModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastbaggingModel::scale(self : TimeseriesforecastbaggingModel, f : Double) -> TimeseriesforecastbaggingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingModel::add(self : TimeseriesforecastbaggingModel, other : TimeseriesforecastbaggingModel) -> TimeseriesforecastbaggingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastbaggingModel::copy(self : TimeseriesforecastbaggingModel) -> TimeseriesforecastbaggingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingModel::fill(self : TimeseriesforecastbaggingModel, v : Double) -> TimeseriesforecastbaggingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingModel::min(self : TimeseriesforecastbaggingModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastbaggingModel::max(self : TimeseriesforecastbaggingModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastbaggingModel::to_string(self : TimeseriesforecastbaggingModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_layer_make(size : Int) -> TimeseriesforecastbaggingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastbaggingLayer::len(self : TimeseriesforecastbaggingLayer) -> Int { self.size }

pub fn TimeseriesforecastbaggingLayer::get(self : TimeseriesforecastbaggingLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastbaggingLayer::set(self : TimeseriesforecastbaggingLayer, i : Int, v : Double) -> TimeseriesforecastbaggingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingLayer::sum(self : TimeseriesforecastbaggingLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastbaggingLayer::mean(self : TimeseriesforecastbaggingLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastbaggingLayer::scale(self : TimeseriesforecastbaggingLayer, f : Double) -> TimeseriesforecastbaggingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingLayer::add(self : TimeseriesforecastbaggingLayer, other : TimeseriesforecastbaggingLayer) -> TimeseriesforecastbaggingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastbaggingLayer::copy(self : TimeseriesforecastbaggingLayer) -> TimeseriesforecastbaggingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingLayer::fill(self : TimeseriesforecastbaggingLayer, v : Double) -> TimeseriesforecastbaggingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingLayer::min(self : TimeseriesforecastbaggingLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastbaggingLayer::max(self : TimeseriesforecastbaggingLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastbaggingLayer::to_string(self : TimeseriesforecastbaggingLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_buffer_make(size : Int) -> TimeseriesforecastbaggingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastbaggingBuffer::len(self : TimeseriesforecastbaggingBuffer) -> Int { self.size }

pub fn TimeseriesforecastbaggingBuffer::get(self : TimeseriesforecastbaggingBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastbaggingBuffer::set(self : TimeseriesforecastbaggingBuffer, i : Int, v : Double) -> TimeseriesforecastbaggingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingBuffer::sum(self : TimeseriesforecastbaggingBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastbaggingBuffer::mean(self : TimeseriesforecastbaggingBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastbaggingBuffer::scale(self : TimeseriesforecastbaggingBuffer, f : Double) -> TimeseriesforecastbaggingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingBuffer::add(self : TimeseriesforecastbaggingBuffer, other : TimeseriesforecastbaggingBuffer) -> TimeseriesforecastbaggingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastbaggingBuffer::copy(self : TimeseriesforecastbaggingBuffer) -> TimeseriesforecastbaggingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingBuffer::fill(self : TimeseriesforecastbaggingBuffer, v : Double) -> TimeseriesforecastbaggingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingBuffer::min(self : TimeseriesforecastbaggingBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastbaggingBuffer::max(self : TimeseriesforecastbaggingBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastbaggingBuffer::to_string(self : TimeseriesforecastbaggingBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_cursor_make(size : Int) -> TimeseriesforecastbaggingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastbaggingCursor::len(self : TimeseriesforecastbaggingCursor) -> Int { self.size }

pub fn TimeseriesforecastbaggingCursor::get(self : TimeseriesforecastbaggingCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastbaggingCursor::set(self : TimeseriesforecastbaggingCursor, i : Int, v : Double) -> TimeseriesforecastbaggingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingCursor::sum(self : TimeseriesforecastbaggingCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastbaggingCursor::mean(self : TimeseriesforecastbaggingCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastbaggingCursor::scale(self : TimeseriesforecastbaggingCursor, f : Double) -> TimeseriesforecastbaggingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingCursor::add(self : TimeseriesforecastbaggingCursor, other : TimeseriesforecastbaggingCursor) -> TimeseriesforecastbaggingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastbaggingCursor::copy(self : TimeseriesforecastbaggingCursor) -> TimeseriesforecastbaggingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingCursor::fill(self : TimeseriesforecastbaggingCursor, v : Double) -> TimeseriesforecastbaggingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingCursor::min(self : TimeseriesforecastbaggingCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastbaggingCursor::max(self : TimeseriesforecastbaggingCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastbaggingCursor::to_string(self : TimeseriesforecastbaggingCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_view_make(size : Int) -> TimeseriesforecastbaggingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastbaggingView::len(self : TimeseriesforecastbaggingView) -> Int { self.size }

pub fn TimeseriesforecastbaggingView::get(self : TimeseriesforecastbaggingView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastbaggingView::set(self : TimeseriesforecastbaggingView, i : Int, v : Double) -> TimeseriesforecastbaggingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingView::sum(self : TimeseriesforecastbaggingView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastbaggingView::mean(self : TimeseriesforecastbaggingView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastbaggingView::scale(self : TimeseriesforecastbaggingView, f : Double) -> TimeseriesforecastbaggingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingView::add(self : TimeseriesforecastbaggingView, other : TimeseriesforecastbaggingView) -> TimeseriesforecastbaggingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastbaggingView::copy(self : TimeseriesforecastbaggingView) -> TimeseriesforecastbaggingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingView::fill(self : TimeseriesforecastbaggingView, v : Double) -> TimeseriesforecastbaggingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingView::min(self : TimeseriesforecastbaggingView) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastbaggingView::max(self : TimeseriesforecastbaggingView) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastbaggingView::to_string(self : TimeseriesforecastbaggingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_range_make(size : Int) -> TimeseriesforecastbaggingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastbaggingRange::len(self : TimeseriesforecastbaggingRange) -> Int { self.size }

pub fn TimeseriesforecastbaggingRange::get(self : TimeseriesforecastbaggingRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastbaggingRange::set(self : TimeseriesforecastbaggingRange, i : Int, v : Double) -> TimeseriesforecastbaggingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingRange::sum(self : TimeseriesforecastbaggingRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastbaggingRange::mean(self : TimeseriesforecastbaggingRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastbaggingRange::scale(self : TimeseriesforecastbaggingRange, f : Double) -> TimeseriesforecastbaggingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingRange::add(self : TimeseriesforecastbaggingRange, other : TimeseriesforecastbaggingRange) -> TimeseriesforecastbaggingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastbaggingRange::copy(self : TimeseriesforecastbaggingRange) -> TimeseriesforecastbaggingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingRange::fill(self : TimeseriesforecastbaggingRange, v : Double) -> TimeseriesforecastbaggingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingRange::min(self : TimeseriesforecastbaggingRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastbaggingRange::max(self : TimeseriesforecastbaggingRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastbaggingRange::to_string(self : TimeseriesforecastbaggingRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_slice_make(size : Int) -> TimeseriesforecastbaggingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastbaggingSlice::len(self : TimeseriesforecastbaggingSlice) -> Int { self.size }

pub fn TimeseriesforecastbaggingSlice::get(self : TimeseriesforecastbaggingSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastbaggingSlice::set(self : TimeseriesforecastbaggingSlice, i : Int, v : Double) -> TimeseriesforecastbaggingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingSlice::sum(self : TimeseriesforecastbaggingSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastbaggingSlice::mean(self : TimeseriesforecastbaggingSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastbaggingSlice::scale(self : TimeseriesforecastbaggingSlice, f : Double) -> TimeseriesforecastbaggingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingSlice::add(self : TimeseriesforecastbaggingSlice, other : TimeseriesforecastbaggingSlice) -> TimeseriesforecastbaggingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastbaggingSlice::copy(self : TimeseriesforecastbaggingSlice) -> TimeseriesforecastbaggingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingSlice::fill(self : TimeseriesforecastbaggingSlice, v : Double) -> TimeseriesforecastbaggingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastbaggingSlice::min(self : TimeseriesforecastbaggingSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastbaggingSlice::max(self : TimeseriesforecastbaggingSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastbaggingSlice::to_string(self : TimeseriesforecastbaggingSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

