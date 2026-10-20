///===
/// extcore/timeseries_forecast_seasonal

pub(all) struct TimeseriesforecastseasonalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_seasonal_make_point(x : Double, y : Double) -> TimeseriesforecastseasonalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_seasonal_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastseasonalPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecastseasonalPoint::x(self : TimeseriesforecastseasonalPoint) -> Double { self.x }

pub fn TimeseriesforecastseasonalPoint::y(self : TimeseriesforecastseasonalPoint) -> Double { self.y }

pub fn TimeseriesforecastseasonalPoint::z(self : TimeseriesforecastseasonalPoint) -> Double { self.z }

pub fn TimeseriesforecastseasonalPoint::label(self : TimeseriesforecastseasonalPoint) -> Int { self.label }

pub fn TimeseriesforecastseasonalPoint::dist(self : TimeseriesforecastseasonalPoint, other : TimeseriesforecastseasonalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecastseasonalPoint::add(self : TimeseriesforecastseasonalPoint, other : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecastseasonalPoint::sub(self : TimeseriesforecastseasonalPoint, other : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecastseasonalPoint::scale(self : TimeseriesforecastseasonalPoint, s : Double) -> TimeseriesforecastseasonalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecastseasonalPoint::dot(self : TimeseriesforecastseasonalPoint, other : TimeseriesforecastseasonalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecastseasonalPoint::cross(self : TimeseriesforecastseasonalPoint, other : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecastseasonalPoint::norm(self : TimeseriesforecastseasonalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecastseasonalPoint::normalize(self : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastseasonalPoint::negate(self : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecastseasonalPoint::mid(self : TimeseriesforecastseasonalPoint, other : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecastseasonalPoint::lerp(self : TimeseriesforecastseasonalPoint, other : TimeseriesforecastseasonalPoint, t : Double) -> TimeseriesforecastseasonalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecastseasonalPoint::to_string(self : TimeseriesforecastseasonalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_seasonal_make_series(vals : Array[Double], name : String) -> TimeseriesforecastseasonalSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecastseasonalSeries::len(self : TimeseriesforecastseasonalSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecastseasonalSeries::sum(self : TimeseriesforecastseasonalSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecastseasonalSeries::mean(self : TimeseriesforecastseasonalSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecastseasonalSeries::min(self : TimeseriesforecastseasonalSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecastseasonalSeries::max(self : TimeseriesforecastseasonalSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecastseasonalSeries::range(self : TimeseriesforecastseasonalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecastseasonalSeries::variance(self : TimeseriesforecastseasonalSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecastseasonalSeries::std(self : TimeseriesforecastseasonalSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecastseasonalSeries::median(self : TimeseriesforecastseasonalSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecastseasonalSeries::scale(self : TimeseriesforecastseasonalSeries, f : Double) -> TimeseriesforecastseasonalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecastseasonalSeries::add(self : TimeseriesforecastseasonalSeries, other : TimeseriesforecastseasonalSeries) -> TimeseriesforecastseasonalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastseasonalSeries::sub(self : TimeseriesforecastseasonalSeries, other : TimeseriesforecastseasonalSeries) -> TimeseriesforecastseasonalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastseasonalSeries::normalize(self : TimeseriesforecastseasonalSeries) -> TimeseriesforecastseasonalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecastseasonalSeries::cumsum(self : TimeseriesforecastseasonalSeries) -> TimeseriesforecastseasonalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecastseasonalSeries::to_string(self : TimeseriesforecastseasonalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastseasonalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_seasonal_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastseasonalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_seasonal_matrix_identity(n : Int) -> TimeseriesforecastseasonalMatrix {
  let m = timeseries_forecast_seasonal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecastseasonalMatrix::get(self : TimeseriesforecastseasonalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecastseasonalMatrix::transpose(self : TimeseriesforecastseasonalMatrix) -> TimeseriesforecastseasonalMatrix {
  let result = timeseries_forecast_seasonal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecastseasonalMatrix::add(self : TimeseriesforecastseasonalMatrix, other : TimeseriesforecastseasonalMatrix) -> TimeseriesforecastseasonalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_seasonal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecastseasonalMatrix::scale(self : TimeseriesforecastseasonalMatrix, s : Double) -> TimeseriesforecastseasonalMatrix {
  let result = timeseries_forecast_seasonal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecastseasonalMatrix::multiply(self : TimeseriesforecastseasonalMatrix, other : TimeseriesforecastseasonalMatrix) -> TimeseriesforecastseasonalMatrix {
  if self.cols != other.rows { return timeseries_forecast_seasonal_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_seasonal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesforecastseasonalMatrix::trace(self : TimeseriesforecastseasonalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecastseasonalMatrix::det(self : TimeseriesforecastseasonalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecastseasonalMatrix::norm(self : TimeseriesforecastseasonalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecastseasonalMatrix::to_string(self : TimeseriesforecastseasonalMatrix) -> String {
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

pub(all) struct TimeseriesforecastseasonalVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_seasonal_make_vector(comps : Array[Double]) -> TimeseriesforecastseasonalVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_seasonal_vector_zero(dim : Int) -> TimeseriesforecastseasonalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecastseasonalVector::add(self : TimeseriesforecastseasonalVector, other : TimeseriesforecastseasonalVector) -> TimeseriesforecastseasonalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastseasonalVector::sub(self : TimeseriesforecastseasonalVector, other : TimeseriesforecastseasonalVector) -> TimeseriesforecastseasonalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastseasonalVector::scale(self : TimeseriesforecastseasonalVector, s : Double) -> TimeseriesforecastseasonalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecastseasonalVector::dot(self : TimeseriesforecastseasonalVector, other : TimeseriesforecastseasonalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecastseasonalVector::norm(self : TimeseriesforecastseasonalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecastseasonalVector::normalize(self : TimeseriesforecastseasonalVector) -> TimeseriesforecastseasonalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastseasonalVector::dist(self : TimeseriesforecastseasonalVector, other : TimeseriesforecastseasonalVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecastseasonalVector::to_string(self : TimeseriesforecastseasonalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastseasonalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_frame_make(size : Int) -> TimeseriesforecastseasonalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastseasonalFrame::len(self : TimeseriesforecastseasonalFrame) -> Int { self.size }

pub fn TimeseriesforecastseasonalFrame::get(self : TimeseriesforecastseasonalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastseasonalFrame::set(self : TimeseriesforecastseasonalFrame, i : Int, v : Double) -> TimeseriesforecastseasonalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalFrame::sum(self : TimeseriesforecastseasonalFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastseasonalFrame::mean(self : TimeseriesforecastseasonalFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastseasonalFrame::scale(self : TimeseriesforecastseasonalFrame, f : Double) -> TimeseriesforecastseasonalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalFrame::add(self : TimeseriesforecastseasonalFrame, other : TimeseriesforecastseasonalFrame) -> TimeseriesforecastseasonalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastseasonalFrame::copy(self : TimeseriesforecastseasonalFrame) -> TimeseriesforecastseasonalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalFrame::fill(self : TimeseriesforecastseasonalFrame, v : Double) -> TimeseriesforecastseasonalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalFrame::min(self : TimeseriesforecastseasonalFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastseasonalFrame::max(self : TimeseriesforecastseasonalFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastseasonalFrame::to_string(self : TimeseriesforecastseasonalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_table_make(size : Int) -> TimeseriesforecastseasonalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastseasonalTable::len(self : TimeseriesforecastseasonalTable) -> Int { self.size }

pub fn TimeseriesforecastseasonalTable::get(self : TimeseriesforecastseasonalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastseasonalTable::set(self : TimeseriesforecastseasonalTable, i : Int, v : Double) -> TimeseriesforecastseasonalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalTable::sum(self : TimeseriesforecastseasonalTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastseasonalTable::mean(self : TimeseriesforecastseasonalTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastseasonalTable::scale(self : TimeseriesforecastseasonalTable, f : Double) -> TimeseriesforecastseasonalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalTable::add(self : TimeseriesforecastseasonalTable, other : TimeseriesforecastseasonalTable) -> TimeseriesforecastseasonalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastseasonalTable::copy(self : TimeseriesforecastseasonalTable) -> TimeseriesforecastseasonalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalTable::fill(self : TimeseriesforecastseasonalTable, v : Double) -> TimeseriesforecastseasonalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalTable::min(self : TimeseriesforecastseasonalTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastseasonalTable::max(self : TimeseriesforecastseasonalTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastseasonalTable::to_string(self : TimeseriesforecastseasonalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_graphn_make(size : Int) -> TimeseriesforecastseasonalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastseasonalGraphN::len(self : TimeseriesforecastseasonalGraphN) -> Int { self.size }

pub fn TimeseriesforecastseasonalGraphN::get(self : TimeseriesforecastseasonalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastseasonalGraphN::set(self : TimeseriesforecastseasonalGraphN, i : Int, v : Double) -> TimeseriesforecastseasonalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalGraphN::sum(self : TimeseriesforecastseasonalGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastseasonalGraphN::mean(self : TimeseriesforecastseasonalGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastseasonalGraphN::scale(self : TimeseriesforecastseasonalGraphN, f : Double) -> TimeseriesforecastseasonalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalGraphN::add(self : TimeseriesforecastseasonalGraphN, other : TimeseriesforecastseasonalGraphN) -> TimeseriesforecastseasonalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastseasonalGraphN::copy(self : TimeseriesforecastseasonalGraphN) -> TimeseriesforecastseasonalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalGraphN::fill(self : TimeseriesforecastseasonalGraphN, v : Double) -> TimeseriesforecastseasonalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalGraphN::min(self : TimeseriesforecastseasonalGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastseasonalGraphN::max(self : TimeseriesforecastseasonalGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastseasonalGraphN::to_string(self : TimeseriesforecastseasonalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_node_make(size : Int) -> TimeseriesforecastseasonalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastseasonalNode::len(self : TimeseriesforecastseasonalNode) -> Int { self.size }

pub fn TimeseriesforecastseasonalNode::get(self : TimeseriesforecastseasonalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastseasonalNode::set(self : TimeseriesforecastseasonalNode, i : Int, v : Double) -> TimeseriesforecastseasonalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalNode::sum(self : TimeseriesforecastseasonalNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastseasonalNode::mean(self : TimeseriesforecastseasonalNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastseasonalNode::scale(self : TimeseriesforecastseasonalNode, f : Double) -> TimeseriesforecastseasonalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalNode::add(self : TimeseriesforecastseasonalNode, other : TimeseriesforecastseasonalNode) -> TimeseriesforecastseasonalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastseasonalNode::copy(self : TimeseriesforecastseasonalNode) -> TimeseriesforecastseasonalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalNode::fill(self : TimeseriesforecastseasonalNode, v : Double) -> TimeseriesforecastseasonalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalNode::min(self : TimeseriesforecastseasonalNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastseasonalNode::max(self : TimeseriesforecastseasonalNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastseasonalNode::to_string(self : TimeseriesforecastseasonalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_edge_make(size : Int) -> TimeseriesforecastseasonalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastseasonalEdge::len(self : TimeseriesforecastseasonalEdge) -> Int { self.size }

pub fn TimeseriesforecastseasonalEdge::get(self : TimeseriesforecastseasonalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastseasonalEdge::set(self : TimeseriesforecastseasonalEdge, i : Int, v : Double) -> TimeseriesforecastseasonalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalEdge::sum(self : TimeseriesforecastseasonalEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastseasonalEdge::mean(self : TimeseriesforecastseasonalEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastseasonalEdge::scale(self : TimeseriesforecastseasonalEdge, f : Double) -> TimeseriesforecastseasonalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalEdge::add(self : TimeseriesforecastseasonalEdge, other : TimeseriesforecastseasonalEdge) -> TimeseriesforecastseasonalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastseasonalEdge::copy(self : TimeseriesforecastseasonalEdge) -> TimeseriesforecastseasonalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalEdge::fill(self : TimeseriesforecastseasonalEdge, v : Double) -> TimeseriesforecastseasonalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalEdge::min(self : TimeseriesforecastseasonalEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastseasonalEdge::max(self : TimeseriesforecastseasonalEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastseasonalEdge::to_string(self : TimeseriesforecastseasonalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_path_make(size : Int) -> TimeseriesforecastseasonalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastseasonalPath::len(self : TimeseriesforecastseasonalPath) -> Int { self.size }

pub fn TimeseriesforecastseasonalPath::get(self : TimeseriesforecastseasonalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastseasonalPath::set(self : TimeseriesforecastseasonalPath, i : Int, v : Double) -> TimeseriesforecastseasonalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalPath::sum(self : TimeseriesforecastseasonalPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastseasonalPath::mean(self : TimeseriesforecastseasonalPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastseasonalPath::scale(self : TimeseriesforecastseasonalPath, f : Double) -> TimeseriesforecastseasonalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalPath::add(self : TimeseriesforecastseasonalPath, other : TimeseriesforecastseasonalPath) -> TimeseriesforecastseasonalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastseasonalPath::copy(self : TimeseriesforecastseasonalPath) -> TimeseriesforecastseasonalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalPath::fill(self : TimeseriesforecastseasonalPath, v : Double) -> TimeseriesforecastseasonalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalPath::min(self : TimeseriesforecastseasonalPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastseasonalPath::max(self : TimeseriesforecastseasonalPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastseasonalPath::to_string(self : TimeseriesforecastseasonalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_cluster_make(size : Int) -> TimeseriesforecastseasonalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastseasonalCluster::len(self : TimeseriesforecastseasonalCluster) -> Int { self.size }

pub fn TimeseriesforecastseasonalCluster::get(self : TimeseriesforecastseasonalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastseasonalCluster::set(self : TimeseriesforecastseasonalCluster, i : Int, v : Double) -> TimeseriesforecastseasonalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalCluster::sum(self : TimeseriesforecastseasonalCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastseasonalCluster::mean(self : TimeseriesforecastseasonalCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastseasonalCluster::scale(self : TimeseriesforecastseasonalCluster, f : Double) -> TimeseriesforecastseasonalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalCluster::add(self : TimeseriesforecastseasonalCluster, other : TimeseriesforecastseasonalCluster) -> TimeseriesforecastseasonalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastseasonalCluster::copy(self : TimeseriesforecastseasonalCluster) -> TimeseriesforecastseasonalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalCluster::fill(self : TimeseriesforecastseasonalCluster, v : Double) -> TimeseriesforecastseasonalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalCluster::min(self : TimeseriesforecastseasonalCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastseasonalCluster::max(self : TimeseriesforecastseasonalCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastseasonalCluster::to_string(self : TimeseriesforecastseasonalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_model_make(size : Int) -> TimeseriesforecastseasonalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastseasonalModel::len(self : TimeseriesforecastseasonalModel) -> Int { self.size }

pub fn TimeseriesforecastseasonalModel::get(self : TimeseriesforecastseasonalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastseasonalModel::set(self : TimeseriesforecastseasonalModel, i : Int, v : Double) -> TimeseriesforecastseasonalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalModel::sum(self : TimeseriesforecastseasonalModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastseasonalModel::mean(self : TimeseriesforecastseasonalModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastseasonalModel::scale(self : TimeseriesforecastseasonalModel, f : Double) -> TimeseriesforecastseasonalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalModel::add(self : TimeseriesforecastseasonalModel, other : TimeseriesforecastseasonalModel) -> TimeseriesforecastseasonalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastseasonalModel::copy(self : TimeseriesforecastseasonalModel) -> TimeseriesforecastseasonalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalModel::fill(self : TimeseriesforecastseasonalModel, v : Double) -> TimeseriesforecastseasonalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalModel::min(self : TimeseriesforecastseasonalModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastseasonalModel::max(self : TimeseriesforecastseasonalModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastseasonalModel::to_string(self : TimeseriesforecastseasonalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_layer_make(size : Int) -> TimeseriesforecastseasonalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastseasonalLayer::len(self : TimeseriesforecastseasonalLayer) -> Int { self.size }

pub fn TimeseriesforecastseasonalLayer::get(self : TimeseriesforecastseasonalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastseasonalLayer::set(self : TimeseriesforecastseasonalLayer, i : Int, v : Double) -> TimeseriesforecastseasonalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalLayer::sum(self : TimeseriesforecastseasonalLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastseasonalLayer::mean(self : TimeseriesforecastseasonalLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastseasonalLayer::scale(self : TimeseriesforecastseasonalLayer, f : Double) -> TimeseriesforecastseasonalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalLayer::add(self : TimeseriesforecastseasonalLayer, other : TimeseriesforecastseasonalLayer) -> TimeseriesforecastseasonalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastseasonalLayer::copy(self : TimeseriesforecastseasonalLayer) -> TimeseriesforecastseasonalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalLayer::fill(self : TimeseriesforecastseasonalLayer, v : Double) -> TimeseriesforecastseasonalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalLayer::min(self : TimeseriesforecastseasonalLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastseasonalLayer::max(self : TimeseriesforecastseasonalLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastseasonalLayer::to_string(self : TimeseriesforecastseasonalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_buffer_make(size : Int) -> TimeseriesforecastseasonalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastseasonalBuffer::len(self : TimeseriesforecastseasonalBuffer) -> Int { self.size }

pub fn TimeseriesforecastseasonalBuffer::get(self : TimeseriesforecastseasonalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastseasonalBuffer::set(self : TimeseriesforecastseasonalBuffer, i : Int, v : Double) -> TimeseriesforecastseasonalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalBuffer::sum(self : TimeseriesforecastseasonalBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastseasonalBuffer::mean(self : TimeseriesforecastseasonalBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastseasonalBuffer::scale(self : TimeseriesforecastseasonalBuffer, f : Double) -> TimeseriesforecastseasonalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalBuffer::add(self : TimeseriesforecastseasonalBuffer, other : TimeseriesforecastseasonalBuffer) -> TimeseriesforecastseasonalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastseasonalBuffer::copy(self : TimeseriesforecastseasonalBuffer) -> TimeseriesforecastseasonalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalBuffer::fill(self : TimeseriesforecastseasonalBuffer, v : Double) -> TimeseriesforecastseasonalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalBuffer::min(self : TimeseriesforecastseasonalBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastseasonalBuffer::max(self : TimeseriesforecastseasonalBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastseasonalBuffer::to_string(self : TimeseriesforecastseasonalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_cursor_make(size : Int) -> TimeseriesforecastseasonalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastseasonalCursor::len(self : TimeseriesforecastseasonalCursor) -> Int { self.size }

pub fn TimeseriesforecastseasonalCursor::get(self : TimeseriesforecastseasonalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastseasonalCursor::set(self : TimeseriesforecastseasonalCursor, i : Int, v : Double) -> TimeseriesforecastseasonalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalCursor::sum(self : TimeseriesforecastseasonalCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastseasonalCursor::mean(self : TimeseriesforecastseasonalCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastseasonalCursor::scale(self : TimeseriesforecastseasonalCursor, f : Double) -> TimeseriesforecastseasonalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalCursor::add(self : TimeseriesforecastseasonalCursor, other : TimeseriesforecastseasonalCursor) -> TimeseriesforecastseasonalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastseasonalCursor::copy(self : TimeseriesforecastseasonalCursor) -> TimeseriesforecastseasonalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalCursor::fill(self : TimeseriesforecastseasonalCursor, v : Double) -> TimeseriesforecastseasonalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalCursor::min(self : TimeseriesforecastseasonalCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastseasonalCursor::max(self : TimeseriesforecastseasonalCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastseasonalCursor::to_string(self : TimeseriesforecastseasonalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_view_make(size : Int) -> TimeseriesforecastseasonalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastseasonalView::len(self : TimeseriesforecastseasonalView) -> Int { self.size }

pub fn TimeseriesforecastseasonalView::get(self : TimeseriesforecastseasonalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastseasonalView::set(self : TimeseriesforecastseasonalView, i : Int, v : Double) -> TimeseriesforecastseasonalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalView::sum(self : TimeseriesforecastseasonalView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastseasonalView::mean(self : TimeseriesforecastseasonalView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastseasonalView::scale(self : TimeseriesforecastseasonalView, f : Double) -> TimeseriesforecastseasonalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalView::add(self : TimeseriesforecastseasonalView, other : TimeseriesforecastseasonalView) -> TimeseriesforecastseasonalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastseasonalView::copy(self : TimeseriesforecastseasonalView) -> TimeseriesforecastseasonalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalView::fill(self : TimeseriesforecastseasonalView, v : Double) -> TimeseriesforecastseasonalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalView::min(self : TimeseriesforecastseasonalView) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastseasonalView::max(self : TimeseriesforecastseasonalView) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastseasonalView::to_string(self : TimeseriesforecastseasonalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_range_make(size : Int) -> TimeseriesforecastseasonalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastseasonalRange::len(self : TimeseriesforecastseasonalRange) -> Int { self.size }

pub fn TimeseriesforecastseasonalRange::get(self : TimeseriesforecastseasonalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastseasonalRange::set(self : TimeseriesforecastseasonalRange, i : Int, v : Double) -> TimeseriesforecastseasonalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalRange::sum(self : TimeseriesforecastseasonalRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastseasonalRange::mean(self : TimeseriesforecastseasonalRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastseasonalRange::scale(self : TimeseriesforecastseasonalRange, f : Double) -> TimeseriesforecastseasonalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalRange::add(self : TimeseriesforecastseasonalRange, other : TimeseriesforecastseasonalRange) -> TimeseriesforecastseasonalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastseasonalRange::copy(self : TimeseriesforecastseasonalRange) -> TimeseriesforecastseasonalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalRange::fill(self : TimeseriesforecastseasonalRange, v : Double) -> TimeseriesforecastseasonalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalRange::min(self : TimeseriesforecastseasonalRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastseasonalRange::max(self : TimeseriesforecastseasonalRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastseasonalRange::to_string(self : TimeseriesforecastseasonalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_slice_make(size : Int) -> TimeseriesforecastseasonalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastseasonalSlice::len(self : TimeseriesforecastseasonalSlice) -> Int { self.size }

pub fn TimeseriesforecastseasonalSlice::get(self : TimeseriesforecastseasonalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastseasonalSlice::set(self : TimeseriesforecastseasonalSlice, i : Int, v : Double) -> TimeseriesforecastseasonalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalSlice::sum(self : TimeseriesforecastseasonalSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastseasonalSlice::mean(self : TimeseriesforecastseasonalSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastseasonalSlice::scale(self : TimeseriesforecastseasonalSlice, f : Double) -> TimeseriesforecastseasonalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalSlice::add(self : TimeseriesforecastseasonalSlice, other : TimeseriesforecastseasonalSlice) -> TimeseriesforecastseasonalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastseasonalSlice::copy(self : TimeseriesforecastseasonalSlice) -> TimeseriesforecastseasonalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalSlice::fill(self : TimeseriesforecastseasonalSlice, v : Double) -> TimeseriesforecastseasonalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastseasonalSlice::min(self : TimeseriesforecastseasonalSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastseasonalSlice::max(self : TimeseriesforecastseasonalSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastseasonalSlice::to_string(self : TimeseriesforecastseasonalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

