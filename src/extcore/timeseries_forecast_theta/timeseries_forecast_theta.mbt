///===
/// extcore/timeseries_forecast_theta

pub(all) struct TimeseriesforecastthetaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_theta_make_point(x : Double, y : Double) -> TimeseriesforecastthetaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_theta_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastthetaPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecastthetaPoint::x(self : TimeseriesforecastthetaPoint) -> Double { self.x }

pub fn TimeseriesforecastthetaPoint::y(self : TimeseriesforecastthetaPoint) -> Double { self.y }

pub fn TimeseriesforecastthetaPoint::z(self : TimeseriesforecastthetaPoint) -> Double { self.z }

pub fn TimeseriesforecastthetaPoint::label(self : TimeseriesforecastthetaPoint) -> Int { self.label }

pub fn TimeseriesforecastthetaPoint::dist(self : TimeseriesforecastthetaPoint, other : TimeseriesforecastthetaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecastthetaPoint::add(self : TimeseriesforecastthetaPoint, other : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecastthetaPoint::sub(self : TimeseriesforecastthetaPoint, other : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecastthetaPoint::scale(self : TimeseriesforecastthetaPoint, s : Double) -> TimeseriesforecastthetaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecastthetaPoint::dot(self : TimeseriesforecastthetaPoint, other : TimeseriesforecastthetaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecastthetaPoint::cross(self : TimeseriesforecastthetaPoint, other : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecastthetaPoint::norm(self : TimeseriesforecastthetaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecastthetaPoint::normalize(self : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastthetaPoint::negate(self : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecastthetaPoint::mid(self : TimeseriesforecastthetaPoint, other : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecastthetaPoint::lerp(self : TimeseriesforecastthetaPoint, other : TimeseriesforecastthetaPoint, t : Double) -> TimeseriesforecastthetaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecastthetaPoint::to_string(self : TimeseriesforecastthetaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_theta_make_series(vals : Array[Double], name : String) -> TimeseriesforecastthetaSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecastthetaSeries::len(self : TimeseriesforecastthetaSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecastthetaSeries::sum(self : TimeseriesforecastthetaSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecastthetaSeries::mean(self : TimeseriesforecastthetaSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecastthetaSeries::min(self : TimeseriesforecastthetaSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecastthetaSeries::max(self : TimeseriesforecastthetaSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecastthetaSeries::range(self : TimeseriesforecastthetaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecastthetaSeries::variance(self : TimeseriesforecastthetaSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecastthetaSeries::std(self : TimeseriesforecastthetaSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecastthetaSeries::median(self : TimeseriesforecastthetaSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecastthetaSeries::scale(self : TimeseriesforecastthetaSeries, f : Double) -> TimeseriesforecastthetaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecastthetaSeries::add(self : TimeseriesforecastthetaSeries, other : TimeseriesforecastthetaSeries) -> TimeseriesforecastthetaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastthetaSeries::sub(self : TimeseriesforecastthetaSeries, other : TimeseriesforecastthetaSeries) -> TimeseriesforecastthetaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastthetaSeries::normalize(self : TimeseriesforecastthetaSeries) -> TimeseriesforecastthetaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecastthetaSeries::cumsum(self : TimeseriesforecastthetaSeries) -> TimeseriesforecastthetaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecastthetaSeries::to_string(self : TimeseriesforecastthetaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastthetaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_theta_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastthetaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_theta_matrix_identity(n : Int) -> TimeseriesforecastthetaMatrix {
  let m = timeseries_forecast_theta_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecastthetaMatrix::get(self : TimeseriesforecastthetaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecastthetaMatrix::transpose(self : TimeseriesforecastthetaMatrix) -> TimeseriesforecastthetaMatrix {
  let result = timeseries_forecast_theta_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecastthetaMatrix::add(self : TimeseriesforecastthetaMatrix, other : TimeseriesforecastthetaMatrix) -> TimeseriesforecastthetaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_theta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecastthetaMatrix::scale(self : TimeseriesforecastthetaMatrix, s : Double) -> TimeseriesforecastthetaMatrix {
  let result = timeseries_forecast_theta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecastthetaMatrix::multiply(self : TimeseriesforecastthetaMatrix, other : TimeseriesforecastthetaMatrix) -> TimeseriesforecastthetaMatrix {
  if self.cols != other.rows { return timeseries_forecast_theta_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_theta_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesforecastthetaMatrix::trace(self : TimeseriesforecastthetaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecastthetaMatrix::det(self : TimeseriesforecastthetaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecastthetaMatrix::norm(self : TimeseriesforecastthetaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecastthetaMatrix::to_string(self : TimeseriesforecastthetaMatrix) -> String {
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

pub(all) struct TimeseriesforecastthetaVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_theta_make_vector(comps : Array[Double]) -> TimeseriesforecastthetaVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_theta_vector_zero(dim : Int) -> TimeseriesforecastthetaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecastthetaVector::add(self : TimeseriesforecastthetaVector, other : TimeseriesforecastthetaVector) -> TimeseriesforecastthetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastthetaVector::sub(self : TimeseriesforecastthetaVector, other : TimeseriesforecastthetaVector) -> TimeseriesforecastthetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastthetaVector::scale(self : TimeseriesforecastthetaVector, s : Double) -> TimeseriesforecastthetaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecastthetaVector::dot(self : TimeseriesforecastthetaVector, other : TimeseriesforecastthetaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecastthetaVector::norm(self : TimeseriesforecastthetaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecastthetaVector::normalize(self : TimeseriesforecastthetaVector) -> TimeseriesforecastthetaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastthetaVector::dist(self : TimeseriesforecastthetaVector, other : TimeseriesforecastthetaVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecastthetaVector::to_string(self : TimeseriesforecastthetaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastthetaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_frame_make(size : Int) -> TimeseriesforecastthetaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastthetaFrame::len(self : TimeseriesforecastthetaFrame) -> Int { self.size }

pub fn TimeseriesforecastthetaFrame::get(self : TimeseriesforecastthetaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastthetaFrame::set(self : TimeseriesforecastthetaFrame, i : Int, v : Double) -> TimeseriesforecastthetaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaFrame::sum(self : TimeseriesforecastthetaFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastthetaFrame::mean(self : TimeseriesforecastthetaFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastthetaFrame::scale(self : TimeseriesforecastthetaFrame, f : Double) -> TimeseriesforecastthetaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaFrame::add(self : TimeseriesforecastthetaFrame, other : TimeseriesforecastthetaFrame) -> TimeseriesforecastthetaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastthetaFrame::copy(self : TimeseriesforecastthetaFrame) -> TimeseriesforecastthetaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaFrame::fill(self : TimeseriesforecastthetaFrame, v : Double) -> TimeseriesforecastthetaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaFrame::min(self : TimeseriesforecastthetaFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastthetaFrame::max(self : TimeseriesforecastthetaFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastthetaFrame::to_string(self : TimeseriesforecastthetaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_table_make(size : Int) -> TimeseriesforecastthetaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastthetaTable::len(self : TimeseriesforecastthetaTable) -> Int { self.size }

pub fn TimeseriesforecastthetaTable::get(self : TimeseriesforecastthetaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastthetaTable::set(self : TimeseriesforecastthetaTable, i : Int, v : Double) -> TimeseriesforecastthetaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaTable::sum(self : TimeseriesforecastthetaTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastthetaTable::mean(self : TimeseriesforecastthetaTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastthetaTable::scale(self : TimeseriesforecastthetaTable, f : Double) -> TimeseriesforecastthetaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaTable::add(self : TimeseriesforecastthetaTable, other : TimeseriesforecastthetaTable) -> TimeseriesforecastthetaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastthetaTable::copy(self : TimeseriesforecastthetaTable) -> TimeseriesforecastthetaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaTable::fill(self : TimeseriesforecastthetaTable, v : Double) -> TimeseriesforecastthetaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaTable::min(self : TimeseriesforecastthetaTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastthetaTable::max(self : TimeseriesforecastthetaTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastthetaTable::to_string(self : TimeseriesforecastthetaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_graphn_make(size : Int) -> TimeseriesforecastthetaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastthetaGraphN::len(self : TimeseriesforecastthetaGraphN) -> Int { self.size }

pub fn TimeseriesforecastthetaGraphN::get(self : TimeseriesforecastthetaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastthetaGraphN::set(self : TimeseriesforecastthetaGraphN, i : Int, v : Double) -> TimeseriesforecastthetaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaGraphN::sum(self : TimeseriesforecastthetaGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastthetaGraphN::mean(self : TimeseriesforecastthetaGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastthetaGraphN::scale(self : TimeseriesforecastthetaGraphN, f : Double) -> TimeseriesforecastthetaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaGraphN::add(self : TimeseriesforecastthetaGraphN, other : TimeseriesforecastthetaGraphN) -> TimeseriesforecastthetaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastthetaGraphN::copy(self : TimeseriesforecastthetaGraphN) -> TimeseriesforecastthetaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaGraphN::fill(self : TimeseriesforecastthetaGraphN, v : Double) -> TimeseriesforecastthetaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaGraphN::min(self : TimeseriesforecastthetaGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastthetaGraphN::max(self : TimeseriesforecastthetaGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastthetaGraphN::to_string(self : TimeseriesforecastthetaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_node_make(size : Int) -> TimeseriesforecastthetaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastthetaNode::len(self : TimeseriesforecastthetaNode) -> Int { self.size }

pub fn TimeseriesforecastthetaNode::get(self : TimeseriesforecastthetaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastthetaNode::set(self : TimeseriesforecastthetaNode, i : Int, v : Double) -> TimeseriesforecastthetaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaNode::sum(self : TimeseriesforecastthetaNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastthetaNode::mean(self : TimeseriesforecastthetaNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastthetaNode::scale(self : TimeseriesforecastthetaNode, f : Double) -> TimeseriesforecastthetaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaNode::add(self : TimeseriesforecastthetaNode, other : TimeseriesforecastthetaNode) -> TimeseriesforecastthetaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastthetaNode::copy(self : TimeseriesforecastthetaNode) -> TimeseriesforecastthetaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaNode::fill(self : TimeseriesforecastthetaNode, v : Double) -> TimeseriesforecastthetaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaNode::min(self : TimeseriesforecastthetaNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastthetaNode::max(self : TimeseriesforecastthetaNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastthetaNode::to_string(self : TimeseriesforecastthetaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_edge_make(size : Int) -> TimeseriesforecastthetaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastthetaEdge::len(self : TimeseriesforecastthetaEdge) -> Int { self.size }

pub fn TimeseriesforecastthetaEdge::get(self : TimeseriesforecastthetaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastthetaEdge::set(self : TimeseriesforecastthetaEdge, i : Int, v : Double) -> TimeseriesforecastthetaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaEdge::sum(self : TimeseriesforecastthetaEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastthetaEdge::mean(self : TimeseriesforecastthetaEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastthetaEdge::scale(self : TimeseriesforecastthetaEdge, f : Double) -> TimeseriesforecastthetaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaEdge::add(self : TimeseriesforecastthetaEdge, other : TimeseriesforecastthetaEdge) -> TimeseriesforecastthetaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastthetaEdge::copy(self : TimeseriesforecastthetaEdge) -> TimeseriesforecastthetaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaEdge::fill(self : TimeseriesforecastthetaEdge, v : Double) -> TimeseriesforecastthetaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaEdge::min(self : TimeseriesforecastthetaEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastthetaEdge::max(self : TimeseriesforecastthetaEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastthetaEdge::to_string(self : TimeseriesforecastthetaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_path_make(size : Int) -> TimeseriesforecastthetaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastthetaPath::len(self : TimeseriesforecastthetaPath) -> Int { self.size }

pub fn TimeseriesforecastthetaPath::get(self : TimeseriesforecastthetaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastthetaPath::set(self : TimeseriesforecastthetaPath, i : Int, v : Double) -> TimeseriesforecastthetaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaPath::sum(self : TimeseriesforecastthetaPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastthetaPath::mean(self : TimeseriesforecastthetaPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastthetaPath::scale(self : TimeseriesforecastthetaPath, f : Double) -> TimeseriesforecastthetaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaPath::add(self : TimeseriesforecastthetaPath, other : TimeseriesforecastthetaPath) -> TimeseriesforecastthetaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastthetaPath::copy(self : TimeseriesforecastthetaPath) -> TimeseriesforecastthetaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaPath::fill(self : TimeseriesforecastthetaPath, v : Double) -> TimeseriesforecastthetaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaPath::min(self : TimeseriesforecastthetaPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastthetaPath::max(self : TimeseriesforecastthetaPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastthetaPath::to_string(self : TimeseriesforecastthetaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_cluster_make(size : Int) -> TimeseriesforecastthetaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastthetaCluster::len(self : TimeseriesforecastthetaCluster) -> Int { self.size }

pub fn TimeseriesforecastthetaCluster::get(self : TimeseriesforecastthetaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastthetaCluster::set(self : TimeseriesforecastthetaCluster, i : Int, v : Double) -> TimeseriesforecastthetaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaCluster::sum(self : TimeseriesforecastthetaCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastthetaCluster::mean(self : TimeseriesforecastthetaCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastthetaCluster::scale(self : TimeseriesforecastthetaCluster, f : Double) -> TimeseriesforecastthetaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaCluster::add(self : TimeseriesforecastthetaCluster, other : TimeseriesforecastthetaCluster) -> TimeseriesforecastthetaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastthetaCluster::copy(self : TimeseriesforecastthetaCluster) -> TimeseriesforecastthetaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaCluster::fill(self : TimeseriesforecastthetaCluster, v : Double) -> TimeseriesforecastthetaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaCluster::min(self : TimeseriesforecastthetaCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastthetaCluster::max(self : TimeseriesforecastthetaCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastthetaCluster::to_string(self : TimeseriesforecastthetaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_model_make(size : Int) -> TimeseriesforecastthetaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastthetaModel::len(self : TimeseriesforecastthetaModel) -> Int { self.size }

pub fn TimeseriesforecastthetaModel::get(self : TimeseriesforecastthetaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastthetaModel::set(self : TimeseriesforecastthetaModel, i : Int, v : Double) -> TimeseriesforecastthetaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaModel::sum(self : TimeseriesforecastthetaModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastthetaModel::mean(self : TimeseriesforecastthetaModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastthetaModel::scale(self : TimeseriesforecastthetaModel, f : Double) -> TimeseriesforecastthetaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaModel::add(self : TimeseriesforecastthetaModel, other : TimeseriesforecastthetaModel) -> TimeseriesforecastthetaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastthetaModel::copy(self : TimeseriesforecastthetaModel) -> TimeseriesforecastthetaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaModel::fill(self : TimeseriesforecastthetaModel, v : Double) -> TimeseriesforecastthetaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaModel::min(self : TimeseriesforecastthetaModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastthetaModel::max(self : TimeseriesforecastthetaModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastthetaModel::to_string(self : TimeseriesforecastthetaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_layer_make(size : Int) -> TimeseriesforecastthetaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastthetaLayer::len(self : TimeseriesforecastthetaLayer) -> Int { self.size }

pub fn TimeseriesforecastthetaLayer::get(self : TimeseriesforecastthetaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastthetaLayer::set(self : TimeseriesforecastthetaLayer, i : Int, v : Double) -> TimeseriesforecastthetaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaLayer::sum(self : TimeseriesforecastthetaLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastthetaLayer::mean(self : TimeseriesforecastthetaLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastthetaLayer::scale(self : TimeseriesforecastthetaLayer, f : Double) -> TimeseriesforecastthetaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaLayer::add(self : TimeseriesforecastthetaLayer, other : TimeseriesforecastthetaLayer) -> TimeseriesforecastthetaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastthetaLayer::copy(self : TimeseriesforecastthetaLayer) -> TimeseriesforecastthetaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaLayer::fill(self : TimeseriesforecastthetaLayer, v : Double) -> TimeseriesforecastthetaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaLayer::min(self : TimeseriesforecastthetaLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastthetaLayer::max(self : TimeseriesforecastthetaLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastthetaLayer::to_string(self : TimeseriesforecastthetaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_buffer_make(size : Int) -> TimeseriesforecastthetaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastthetaBuffer::len(self : TimeseriesforecastthetaBuffer) -> Int { self.size }

pub fn TimeseriesforecastthetaBuffer::get(self : TimeseriesforecastthetaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastthetaBuffer::set(self : TimeseriesforecastthetaBuffer, i : Int, v : Double) -> TimeseriesforecastthetaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaBuffer::sum(self : TimeseriesforecastthetaBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastthetaBuffer::mean(self : TimeseriesforecastthetaBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastthetaBuffer::scale(self : TimeseriesforecastthetaBuffer, f : Double) -> TimeseriesforecastthetaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaBuffer::add(self : TimeseriesforecastthetaBuffer, other : TimeseriesforecastthetaBuffer) -> TimeseriesforecastthetaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastthetaBuffer::copy(self : TimeseriesforecastthetaBuffer) -> TimeseriesforecastthetaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaBuffer::fill(self : TimeseriesforecastthetaBuffer, v : Double) -> TimeseriesforecastthetaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaBuffer::min(self : TimeseriesforecastthetaBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastthetaBuffer::max(self : TimeseriesforecastthetaBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastthetaBuffer::to_string(self : TimeseriesforecastthetaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_cursor_make(size : Int) -> TimeseriesforecastthetaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastthetaCursor::len(self : TimeseriesforecastthetaCursor) -> Int { self.size }

pub fn TimeseriesforecastthetaCursor::get(self : TimeseriesforecastthetaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastthetaCursor::set(self : TimeseriesforecastthetaCursor, i : Int, v : Double) -> TimeseriesforecastthetaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaCursor::sum(self : TimeseriesforecastthetaCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastthetaCursor::mean(self : TimeseriesforecastthetaCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastthetaCursor::scale(self : TimeseriesforecastthetaCursor, f : Double) -> TimeseriesforecastthetaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaCursor::add(self : TimeseriesforecastthetaCursor, other : TimeseriesforecastthetaCursor) -> TimeseriesforecastthetaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastthetaCursor::copy(self : TimeseriesforecastthetaCursor) -> TimeseriesforecastthetaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaCursor::fill(self : TimeseriesforecastthetaCursor, v : Double) -> TimeseriesforecastthetaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaCursor::min(self : TimeseriesforecastthetaCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastthetaCursor::max(self : TimeseriesforecastthetaCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastthetaCursor::to_string(self : TimeseriesforecastthetaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_view_make(size : Int) -> TimeseriesforecastthetaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastthetaView::len(self : TimeseriesforecastthetaView) -> Int { self.size }

pub fn TimeseriesforecastthetaView::get(self : TimeseriesforecastthetaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastthetaView::set(self : TimeseriesforecastthetaView, i : Int, v : Double) -> TimeseriesforecastthetaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaView::sum(self : TimeseriesforecastthetaView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastthetaView::mean(self : TimeseriesforecastthetaView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastthetaView::scale(self : TimeseriesforecastthetaView, f : Double) -> TimeseriesforecastthetaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaView::add(self : TimeseriesforecastthetaView, other : TimeseriesforecastthetaView) -> TimeseriesforecastthetaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastthetaView::copy(self : TimeseriesforecastthetaView) -> TimeseriesforecastthetaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaView::fill(self : TimeseriesforecastthetaView, v : Double) -> TimeseriesforecastthetaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaView::min(self : TimeseriesforecastthetaView) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastthetaView::max(self : TimeseriesforecastthetaView) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastthetaView::to_string(self : TimeseriesforecastthetaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_range_make(size : Int) -> TimeseriesforecastthetaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastthetaRange::len(self : TimeseriesforecastthetaRange) -> Int { self.size }

pub fn TimeseriesforecastthetaRange::get(self : TimeseriesforecastthetaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastthetaRange::set(self : TimeseriesforecastthetaRange, i : Int, v : Double) -> TimeseriesforecastthetaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaRange::sum(self : TimeseriesforecastthetaRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastthetaRange::mean(self : TimeseriesforecastthetaRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastthetaRange::scale(self : TimeseriesforecastthetaRange, f : Double) -> TimeseriesforecastthetaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaRange::add(self : TimeseriesforecastthetaRange, other : TimeseriesforecastthetaRange) -> TimeseriesforecastthetaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastthetaRange::copy(self : TimeseriesforecastthetaRange) -> TimeseriesforecastthetaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaRange::fill(self : TimeseriesforecastthetaRange, v : Double) -> TimeseriesforecastthetaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaRange::min(self : TimeseriesforecastthetaRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastthetaRange::max(self : TimeseriesforecastthetaRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastthetaRange::to_string(self : TimeseriesforecastthetaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_slice_make(size : Int) -> TimeseriesforecastthetaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastthetaSlice::len(self : TimeseriesforecastthetaSlice) -> Int { self.size }

pub fn TimeseriesforecastthetaSlice::get(self : TimeseriesforecastthetaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastthetaSlice::set(self : TimeseriesforecastthetaSlice, i : Int, v : Double) -> TimeseriesforecastthetaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaSlice::sum(self : TimeseriesforecastthetaSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastthetaSlice::mean(self : TimeseriesforecastthetaSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastthetaSlice::scale(self : TimeseriesforecastthetaSlice, f : Double) -> TimeseriesforecastthetaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaSlice::add(self : TimeseriesforecastthetaSlice, other : TimeseriesforecastthetaSlice) -> TimeseriesforecastthetaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastthetaSlice::copy(self : TimeseriesforecastthetaSlice) -> TimeseriesforecastthetaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaSlice::fill(self : TimeseriesforecastthetaSlice, v : Double) -> TimeseriesforecastthetaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastthetaSlice::min(self : TimeseriesforecastthetaSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastthetaSlice::max(self : TimeseriesforecastthetaSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastthetaSlice::to_string(self : TimeseriesforecastthetaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

