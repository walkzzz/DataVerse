///===
/// extcore/timeseries_forecast_drift

pub(all) struct TimeseriesforecastdriftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_drift_make_point(x : Double, y : Double) -> TimeseriesforecastdriftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_drift_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastdriftPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecastdriftPoint::x(self : TimeseriesforecastdriftPoint) -> Double { self.x }

pub fn TimeseriesforecastdriftPoint::y(self : TimeseriesforecastdriftPoint) -> Double { self.y }

pub fn TimeseriesforecastdriftPoint::z(self : TimeseriesforecastdriftPoint) -> Double { self.z }

pub fn TimeseriesforecastdriftPoint::label(self : TimeseriesforecastdriftPoint) -> Int { self.label }

pub fn TimeseriesforecastdriftPoint::dist(self : TimeseriesforecastdriftPoint, other : TimeseriesforecastdriftPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecastdriftPoint::add(self : TimeseriesforecastdriftPoint, other : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecastdriftPoint::sub(self : TimeseriesforecastdriftPoint, other : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecastdriftPoint::scale(self : TimeseriesforecastdriftPoint, s : Double) -> TimeseriesforecastdriftPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecastdriftPoint::dot(self : TimeseriesforecastdriftPoint, other : TimeseriesforecastdriftPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecastdriftPoint::cross(self : TimeseriesforecastdriftPoint, other : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecastdriftPoint::norm(self : TimeseriesforecastdriftPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecastdriftPoint::normalize(self : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastdriftPoint::negate(self : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecastdriftPoint::mid(self : TimeseriesforecastdriftPoint, other : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecastdriftPoint::lerp(self : TimeseriesforecastdriftPoint, other : TimeseriesforecastdriftPoint, t : Double) -> TimeseriesforecastdriftPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecastdriftPoint::to_string(self : TimeseriesforecastdriftPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_drift_make_series(vals : Array[Double], name : String) -> TimeseriesforecastdriftSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecastdriftSeries::len(self : TimeseriesforecastdriftSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecastdriftSeries::sum(self : TimeseriesforecastdriftSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecastdriftSeries::mean(self : TimeseriesforecastdriftSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecastdriftSeries::min(self : TimeseriesforecastdriftSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecastdriftSeries::max(self : TimeseriesforecastdriftSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecastdriftSeries::range(self : TimeseriesforecastdriftSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecastdriftSeries::variance(self : TimeseriesforecastdriftSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecastdriftSeries::std(self : TimeseriesforecastdriftSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecastdriftSeries::median(self : TimeseriesforecastdriftSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecastdriftSeries::scale(self : TimeseriesforecastdriftSeries, f : Double) -> TimeseriesforecastdriftSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecastdriftSeries::add(self : TimeseriesforecastdriftSeries, other : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastdriftSeries::sub(self : TimeseriesforecastdriftSeries, other : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastdriftSeries::normalize(self : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecastdriftSeries::cumsum(self : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecastdriftSeries::to_string(self : TimeseriesforecastdriftSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastdriftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_drift_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastdriftMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn timeseries_forecast_drift_matrix_identity(n : Int) -> TimeseriesforecastdriftMatrix {
  let m = timeseries_forecast_drift_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecastdriftMatrix::get(self : TimeseriesforecastdriftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecastdriftMatrix::transpose(self : TimeseriesforecastdriftMatrix) -> TimeseriesforecastdriftMatrix {
  let result = timeseries_forecast_drift_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecastdriftMatrix::add(self : TimeseriesforecastdriftMatrix, other : TimeseriesforecastdriftMatrix) -> TimeseriesforecastdriftMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_drift_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecastdriftMatrix::scale(self : TimeseriesforecastdriftMatrix, s : Double) -> TimeseriesforecastdriftMatrix {
  let result = timeseries_forecast_drift_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecastdriftMatrix::multiply(self : TimeseriesforecastdriftMatrix, other : TimeseriesforecastdriftMatrix) -> TimeseriesforecastdriftMatrix {
  if self.cols != other.rows { return timeseries_forecast_drift_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_drift_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn TimeseriesforecastdriftMatrix::trace(self : TimeseriesforecastdriftMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecastdriftMatrix::det(self : TimeseriesforecastdriftMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecastdriftMatrix::norm(self : TimeseriesforecastdriftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecastdriftMatrix::to_string(self : TimeseriesforecastdriftMatrix) -> String {
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

pub(all) struct TimeseriesforecastdriftVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_drift_make_vector(comps : Array[Double]) -> TimeseriesforecastdriftVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_drift_vector_zero(dim : Int) -> TimeseriesforecastdriftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecastdriftVector::add(self : TimeseriesforecastdriftVector, other : TimeseriesforecastdriftVector) -> TimeseriesforecastdriftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastdriftVector::sub(self : TimeseriesforecastdriftVector, other : TimeseriesforecastdriftVector) -> TimeseriesforecastdriftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastdriftVector::scale(self : TimeseriesforecastdriftVector, s : Double) -> TimeseriesforecastdriftVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecastdriftVector::dot(self : TimeseriesforecastdriftVector, other : TimeseriesforecastdriftVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecastdriftVector::norm(self : TimeseriesforecastdriftVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecastdriftVector::normalize(self : TimeseriesforecastdriftVector) -> TimeseriesforecastdriftVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastdriftVector::dist(self : TimeseriesforecastdriftVector, other : TimeseriesforecastdriftVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecastdriftVector::to_string(self : TimeseriesforecastdriftVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastdriftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_frame_make(size : Int) -> TimeseriesforecastdriftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdriftFrame::len(self : TimeseriesforecastdriftFrame) -> Int { self.size }

pub fn TimeseriesforecastdriftFrame::get(self : TimeseriesforecastdriftFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdriftFrame::set(self : TimeseriesforecastdriftFrame, i : Int, v : Double) -> TimeseriesforecastdriftFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftFrame::sum(self : TimeseriesforecastdriftFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdriftFrame::mean(self : TimeseriesforecastdriftFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdriftFrame::scale(self : TimeseriesforecastdriftFrame, f : Double) -> TimeseriesforecastdriftFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftFrame::add(self : TimeseriesforecastdriftFrame, other : TimeseriesforecastdriftFrame) -> TimeseriesforecastdriftFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdriftFrame::copy(self : TimeseriesforecastdriftFrame) -> TimeseriesforecastdriftFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftFrame::fill(self : TimeseriesforecastdriftFrame, v : Double) -> TimeseriesforecastdriftFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftFrame::min(self : TimeseriesforecastdriftFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdriftFrame::max(self : TimeseriesforecastdriftFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdriftFrame::to_string(self : TimeseriesforecastdriftFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_table_make(size : Int) -> TimeseriesforecastdriftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdriftTable::len(self : TimeseriesforecastdriftTable) -> Int { self.size }

pub fn TimeseriesforecastdriftTable::get(self : TimeseriesforecastdriftTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdriftTable::set(self : TimeseriesforecastdriftTable, i : Int, v : Double) -> TimeseriesforecastdriftTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftTable::sum(self : TimeseriesforecastdriftTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdriftTable::mean(self : TimeseriesforecastdriftTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdriftTable::scale(self : TimeseriesforecastdriftTable, f : Double) -> TimeseriesforecastdriftTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftTable::add(self : TimeseriesforecastdriftTable, other : TimeseriesforecastdriftTable) -> TimeseriesforecastdriftTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdriftTable::copy(self : TimeseriesforecastdriftTable) -> TimeseriesforecastdriftTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftTable::fill(self : TimeseriesforecastdriftTable, v : Double) -> TimeseriesforecastdriftTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftTable::min(self : TimeseriesforecastdriftTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdriftTable::max(self : TimeseriesforecastdriftTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdriftTable::to_string(self : TimeseriesforecastdriftTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_graphn_make(size : Int) -> TimeseriesforecastdriftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdriftGraphN::len(self : TimeseriesforecastdriftGraphN) -> Int { self.size }

pub fn TimeseriesforecastdriftGraphN::get(self : TimeseriesforecastdriftGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdriftGraphN::set(self : TimeseriesforecastdriftGraphN, i : Int, v : Double) -> TimeseriesforecastdriftGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftGraphN::sum(self : TimeseriesforecastdriftGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdriftGraphN::mean(self : TimeseriesforecastdriftGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdriftGraphN::scale(self : TimeseriesforecastdriftGraphN, f : Double) -> TimeseriesforecastdriftGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftGraphN::add(self : TimeseriesforecastdriftGraphN, other : TimeseriesforecastdriftGraphN) -> TimeseriesforecastdriftGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdriftGraphN::copy(self : TimeseriesforecastdriftGraphN) -> TimeseriesforecastdriftGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftGraphN::fill(self : TimeseriesforecastdriftGraphN, v : Double) -> TimeseriesforecastdriftGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftGraphN::min(self : TimeseriesforecastdriftGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdriftGraphN::max(self : TimeseriesforecastdriftGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdriftGraphN::to_string(self : TimeseriesforecastdriftGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_node_make(size : Int) -> TimeseriesforecastdriftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdriftNode::len(self : TimeseriesforecastdriftNode) -> Int { self.size }

pub fn TimeseriesforecastdriftNode::get(self : TimeseriesforecastdriftNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdriftNode::set(self : TimeseriesforecastdriftNode, i : Int, v : Double) -> TimeseriesforecastdriftNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftNode::sum(self : TimeseriesforecastdriftNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdriftNode::mean(self : TimeseriesforecastdriftNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdriftNode::scale(self : TimeseriesforecastdriftNode, f : Double) -> TimeseriesforecastdriftNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftNode::add(self : TimeseriesforecastdriftNode, other : TimeseriesforecastdriftNode) -> TimeseriesforecastdriftNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdriftNode::copy(self : TimeseriesforecastdriftNode) -> TimeseriesforecastdriftNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftNode::fill(self : TimeseriesforecastdriftNode, v : Double) -> TimeseriesforecastdriftNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftNode::min(self : TimeseriesforecastdriftNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdriftNode::max(self : TimeseriesforecastdriftNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdriftNode::to_string(self : TimeseriesforecastdriftNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_edge_make(size : Int) -> TimeseriesforecastdriftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdriftEdge::len(self : TimeseriesforecastdriftEdge) -> Int { self.size }

pub fn TimeseriesforecastdriftEdge::get(self : TimeseriesforecastdriftEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdriftEdge::set(self : TimeseriesforecastdriftEdge, i : Int, v : Double) -> TimeseriesforecastdriftEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftEdge::sum(self : TimeseriesforecastdriftEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdriftEdge::mean(self : TimeseriesforecastdriftEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdriftEdge::scale(self : TimeseriesforecastdriftEdge, f : Double) -> TimeseriesforecastdriftEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftEdge::add(self : TimeseriesforecastdriftEdge, other : TimeseriesforecastdriftEdge) -> TimeseriesforecastdriftEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdriftEdge::copy(self : TimeseriesforecastdriftEdge) -> TimeseriesforecastdriftEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftEdge::fill(self : TimeseriesforecastdriftEdge, v : Double) -> TimeseriesforecastdriftEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftEdge::min(self : TimeseriesforecastdriftEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdriftEdge::max(self : TimeseriesforecastdriftEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdriftEdge::to_string(self : TimeseriesforecastdriftEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_path_make(size : Int) -> TimeseriesforecastdriftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdriftPath::len(self : TimeseriesforecastdriftPath) -> Int { self.size }

pub fn TimeseriesforecastdriftPath::get(self : TimeseriesforecastdriftPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdriftPath::set(self : TimeseriesforecastdriftPath, i : Int, v : Double) -> TimeseriesforecastdriftPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftPath::sum(self : TimeseriesforecastdriftPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdriftPath::mean(self : TimeseriesforecastdriftPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdriftPath::scale(self : TimeseriesforecastdriftPath, f : Double) -> TimeseriesforecastdriftPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftPath::add(self : TimeseriesforecastdriftPath, other : TimeseriesforecastdriftPath) -> TimeseriesforecastdriftPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdriftPath::copy(self : TimeseriesforecastdriftPath) -> TimeseriesforecastdriftPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftPath::fill(self : TimeseriesforecastdriftPath, v : Double) -> TimeseriesforecastdriftPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftPath::min(self : TimeseriesforecastdriftPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdriftPath::max(self : TimeseriesforecastdriftPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdriftPath::to_string(self : TimeseriesforecastdriftPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_cluster_make(size : Int) -> TimeseriesforecastdriftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdriftCluster::len(self : TimeseriesforecastdriftCluster) -> Int { self.size }

pub fn TimeseriesforecastdriftCluster::get(self : TimeseriesforecastdriftCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdriftCluster::set(self : TimeseriesforecastdriftCluster, i : Int, v : Double) -> TimeseriesforecastdriftCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftCluster::sum(self : TimeseriesforecastdriftCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdriftCluster::mean(self : TimeseriesforecastdriftCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdriftCluster::scale(self : TimeseriesforecastdriftCluster, f : Double) -> TimeseriesforecastdriftCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftCluster::add(self : TimeseriesforecastdriftCluster, other : TimeseriesforecastdriftCluster) -> TimeseriesforecastdriftCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdriftCluster::copy(self : TimeseriesforecastdriftCluster) -> TimeseriesforecastdriftCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftCluster::fill(self : TimeseriesforecastdriftCluster, v : Double) -> TimeseriesforecastdriftCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftCluster::min(self : TimeseriesforecastdriftCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdriftCluster::max(self : TimeseriesforecastdriftCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdriftCluster::to_string(self : TimeseriesforecastdriftCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_model_make(size : Int) -> TimeseriesforecastdriftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdriftModel::len(self : TimeseriesforecastdriftModel) -> Int { self.size }

pub fn TimeseriesforecastdriftModel::get(self : TimeseriesforecastdriftModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdriftModel::set(self : TimeseriesforecastdriftModel, i : Int, v : Double) -> TimeseriesforecastdriftModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftModel::sum(self : TimeseriesforecastdriftModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdriftModel::mean(self : TimeseriesforecastdriftModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdriftModel::scale(self : TimeseriesforecastdriftModel, f : Double) -> TimeseriesforecastdriftModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftModel::add(self : TimeseriesforecastdriftModel, other : TimeseriesforecastdriftModel) -> TimeseriesforecastdriftModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdriftModel::copy(self : TimeseriesforecastdriftModel) -> TimeseriesforecastdriftModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftModel::fill(self : TimeseriesforecastdriftModel, v : Double) -> TimeseriesforecastdriftModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftModel::min(self : TimeseriesforecastdriftModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdriftModel::max(self : TimeseriesforecastdriftModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdriftModel::to_string(self : TimeseriesforecastdriftModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_layer_make(size : Int) -> TimeseriesforecastdriftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdriftLayer::len(self : TimeseriesforecastdriftLayer) -> Int { self.size }

pub fn TimeseriesforecastdriftLayer::get(self : TimeseriesforecastdriftLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdriftLayer::set(self : TimeseriesforecastdriftLayer, i : Int, v : Double) -> TimeseriesforecastdriftLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftLayer::sum(self : TimeseriesforecastdriftLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdriftLayer::mean(self : TimeseriesforecastdriftLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdriftLayer::scale(self : TimeseriesforecastdriftLayer, f : Double) -> TimeseriesforecastdriftLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftLayer::add(self : TimeseriesforecastdriftLayer, other : TimeseriesforecastdriftLayer) -> TimeseriesforecastdriftLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdriftLayer::copy(self : TimeseriesforecastdriftLayer) -> TimeseriesforecastdriftLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftLayer::fill(self : TimeseriesforecastdriftLayer, v : Double) -> TimeseriesforecastdriftLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftLayer::min(self : TimeseriesforecastdriftLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdriftLayer::max(self : TimeseriesforecastdriftLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdriftLayer::to_string(self : TimeseriesforecastdriftLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_buffer_make(size : Int) -> TimeseriesforecastdriftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdriftBuffer::len(self : TimeseriesforecastdriftBuffer) -> Int { self.size }

pub fn TimeseriesforecastdriftBuffer::get(self : TimeseriesforecastdriftBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdriftBuffer::set(self : TimeseriesforecastdriftBuffer, i : Int, v : Double) -> TimeseriesforecastdriftBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftBuffer::sum(self : TimeseriesforecastdriftBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdriftBuffer::mean(self : TimeseriesforecastdriftBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdriftBuffer::scale(self : TimeseriesforecastdriftBuffer, f : Double) -> TimeseriesforecastdriftBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftBuffer::add(self : TimeseriesforecastdriftBuffer, other : TimeseriesforecastdriftBuffer) -> TimeseriesforecastdriftBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdriftBuffer::copy(self : TimeseriesforecastdriftBuffer) -> TimeseriesforecastdriftBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftBuffer::fill(self : TimeseriesforecastdriftBuffer, v : Double) -> TimeseriesforecastdriftBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftBuffer::min(self : TimeseriesforecastdriftBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdriftBuffer::max(self : TimeseriesforecastdriftBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdriftBuffer::to_string(self : TimeseriesforecastdriftBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_cursor_make(size : Int) -> TimeseriesforecastdriftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdriftCursor::len(self : TimeseriesforecastdriftCursor) -> Int { self.size }

pub fn TimeseriesforecastdriftCursor::get(self : TimeseriesforecastdriftCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdriftCursor::set(self : TimeseriesforecastdriftCursor, i : Int, v : Double) -> TimeseriesforecastdriftCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftCursor::sum(self : TimeseriesforecastdriftCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdriftCursor::mean(self : TimeseriesforecastdriftCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdriftCursor::scale(self : TimeseriesforecastdriftCursor, f : Double) -> TimeseriesforecastdriftCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftCursor::add(self : TimeseriesforecastdriftCursor, other : TimeseriesforecastdriftCursor) -> TimeseriesforecastdriftCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdriftCursor::copy(self : TimeseriesforecastdriftCursor) -> TimeseriesforecastdriftCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftCursor::fill(self : TimeseriesforecastdriftCursor, v : Double) -> TimeseriesforecastdriftCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftCursor::min(self : TimeseriesforecastdriftCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdriftCursor::max(self : TimeseriesforecastdriftCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdriftCursor::to_string(self : TimeseriesforecastdriftCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_view_make(size : Int) -> TimeseriesforecastdriftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdriftView::len(self : TimeseriesforecastdriftView) -> Int { self.size }

pub fn TimeseriesforecastdriftView::get(self : TimeseriesforecastdriftView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdriftView::set(self : TimeseriesforecastdriftView, i : Int, v : Double) -> TimeseriesforecastdriftView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftView::sum(self : TimeseriesforecastdriftView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdriftView::mean(self : TimeseriesforecastdriftView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdriftView::scale(self : TimeseriesforecastdriftView, f : Double) -> TimeseriesforecastdriftView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftView::add(self : TimeseriesforecastdriftView, other : TimeseriesforecastdriftView) -> TimeseriesforecastdriftView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdriftView::copy(self : TimeseriesforecastdriftView) -> TimeseriesforecastdriftView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftView::fill(self : TimeseriesforecastdriftView, v : Double) -> TimeseriesforecastdriftView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftView::min(self : TimeseriesforecastdriftView) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdriftView::max(self : TimeseriesforecastdriftView) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdriftView::to_string(self : TimeseriesforecastdriftView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_range_make(size : Int) -> TimeseriesforecastdriftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdriftRange::len(self : TimeseriesforecastdriftRange) -> Int { self.size }

pub fn TimeseriesforecastdriftRange::get(self : TimeseriesforecastdriftRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdriftRange::set(self : TimeseriesforecastdriftRange, i : Int, v : Double) -> TimeseriesforecastdriftRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftRange::sum(self : TimeseriesforecastdriftRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdriftRange::mean(self : TimeseriesforecastdriftRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdriftRange::scale(self : TimeseriesforecastdriftRange, f : Double) -> TimeseriesforecastdriftRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftRange::add(self : TimeseriesforecastdriftRange, other : TimeseriesforecastdriftRange) -> TimeseriesforecastdriftRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdriftRange::copy(self : TimeseriesforecastdriftRange) -> TimeseriesforecastdriftRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftRange::fill(self : TimeseriesforecastdriftRange, v : Double) -> TimeseriesforecastdriftRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftRange::min(self : TimeseriesforecastdriftRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdriftRange::max(self : TimeseriesforecastdriftRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdriftRange::to_string(self : TimeseriesforecastdriftRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_slice_make(size : Int) -> TimeseriesforecastdriftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastdriftSlice::len(self : TimeseriesforecastdriftSlice) -> Int { self.size }

pub fn TimeseriesforecastdriftSlice::get(self : TimeseriesforecastdriftSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastdriftSlice::set(self : TimeseriesforecastdriftSlice, i : Int, v : Double) -> TimeseriesforecastdriftSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftSlice::sum(self : TimeseriesforecastdriftSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastdriftSlice::mean(self : TimeseriesforecastdriftSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastdriftSlice::scale(self : TimeseriesforecastdriftSlice, f : Double) -> TimeseriesforecastdriftSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftSlice::add(self : TimeseriesforecastdriftSlice, other : TimeseriesforecastdriftSlice) -> TimeseriesforecastdriftSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastdriftSlice::copy(self : TimeseriesforecastdriftSlice) -> TimeseriesforecastdriftSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftSlice::fill(self : TimeseriesforecastdriftSlice, v : Double) -> TimeseriesforecastdriftSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastdriftSlice::min(self : TimeseriesforecastdriftSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastdriftSlice::max(self : TimeseriesforecastdriftSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastdriftSlice::to_string(self : TimeseriesforecastdriftSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

