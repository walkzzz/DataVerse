///===
/// extcore/timeseries_anomaly_iqr

pub(all) struct TimeseriesanomalyiqrPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_iqr_make_point(x : Double, y : Double) -> TimeseriesanomalyiqrPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_iqr_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalyiqrPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalyiqrPoint::x(self : TimeseriesanomalyiqrPoint) -> Double { self.x }

pub fn TimeseriesanomalyiqrPoint::y(self : TimeseriesanomalyiqrPoint) -> Double { self.y }

pub fn TimeseriesanomalyiqrPoint::z(self : TimeseriesanomalyiqrPoint) -> Double { self.z }

pub fn TimeseriesanomalyiqrPoint::label(self : TimeseriesanomalyiqrPoint) -> Int { self.label }

pub fn TimeseriesanomalyiqrPoint::dist(self : TimeseriesanomalyiqrPoint, other : TimeseriesanomalyiqrPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalyiqrPoint::add(self : TimeseriesanomalyiqrPoint, other : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalyiqrPoint::sub(self : TimeseriesanomalyiqrPoint, other : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalyiqrPoint::scale(self : TimeseriesanomalyiqrPoint, s : Double) -> TimeseriesanomalyiqrPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalyiqrPoint::dot(self : TimeseriesanomalyiqrPoint, other : TimeseriesanomalyiqrPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalyiqrPoint::cross(self : TimeseriesanomalyiqrPoint, other : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalyiqrPoint::norm(self : TimeseriesanomalyiqrPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalyiqrPoint::normalize(self : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyiqrPoint::negate(self : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalyiqrPoint::mid(self : TimeseriesanomalyiqrPoint, other : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalyiqrPoint::lerp(self : TimeseriesanomalyiqrPoint, other : TimeseriesanomalyiqrPoint, t : Double) -> TimeseriesanomalyiqrPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalyiqrPoint::to_string(self : TimeseriesanomalyiqrPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_iqr_make_series(vals : Array[Double], name : String) -> TimeseriesanomalyiqrSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalyiqrSeries::len(self : TimeseriesanomalyiqrSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalyiqrSeries::sum(self : TimeseriesanomalyiqrSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalyiqrSeries::mean(self : TimeseriesanomalyiqrSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalyiqrSeries::min(self : TimeseriesanomalyiqrSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalyiqrSeries::max(self : TimeseriesanomalyiqrSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalyiqrSeries::range(self : TimeseriesanomalyiqrSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalyiqrSeries::variance(self : TimeseriesanomalyiqrSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalyiqrSeries::std(self : TimeseriesanomalyiqrSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalyiqrSeries::median(self : TimeseriesanomalyiqrSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalyiqrSeries::scale(self : TimeseriesanomalyiqrSeries, f : Double) -> TimeseriesanomalyiqrSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalyiqrSeries::add(self : TimeseriesanomalyiqrSeries, other : TimeseriesanomalyiqrSeries) -> TimeseriesanomalyiqrSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyiqrSeries::sub(self : TimeseriesanomalyiqrSeries, other : TimeseriesanomalyiqrSeries) -> TimeseriesanomalyiqrSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyiqrSeries::normalize(self : TimeseriesanomalyiqrSeries) -> TimeseriesanomalyiqrSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalyiqrSeries::cumsum(self : TimeseriesanomalyiqrSeries) -> TimeseriesanomalyiqrSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalyiqrSeries::to_string(self : TimeseriesanomalyiqrSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyiqrMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_iqr_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalyiqrMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_iqr_matrix_identity(n : Int) -> TimeseriesanomalyiqrMatrix {
  let m = timeseries_anomaly_iqr_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalyiqrMatrix::get(self : TimeseriesanomalyiqrMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalyiqrMatrix::transpose(self : TimeseriesanomalyiqrMatrix) -> TimeseriesanomalyiqrMatrix {
  let result = timeseries_anomaly_iqr_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalyiqrMatrix::add(self : TimeseriesanomalyiqrMatrix, other : TimeseriesanomalyiqrMatrix) -> TimeseriesanomalyiqrMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_iqr_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalyiqrMatrix::scale(self : TimeseriesanomalyiqrMatrix, s : Double) -> TimeseriesanomalyiqrMatrix {
  let result = timeseries_anomaly_iqr_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalyiqrMatrix::multiply(self : TimeseriesanomalyiqrMatrix, other : TimeseriesanomalyiqrMatrix) -> TimeseriesanomalyiqrMatrix {
  if self.cols != other.rows { return timeseries_anomaly_iqr_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_iqr_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesanomalyiqrMatrix::trace(self : TimeseriesanomalyiqrMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalyiqrMatrix::det(self : TimeseriesanomalyiqrMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalyiqrMatrix::norm(self : TimeseriesanomalyiqrMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalyiqrMatrix::to_string(self : TimeseriesanomalyiqrMatrix) -> String {
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

pub(all) struct TimeseriesanomalyiqrVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_iqr_make_vector(comps : Array[Double]) -> TimeseriesanomalyiqrVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_iqr_vector_zero(dim : Int) -> TimeseriesanomalyiqrVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalyiqrVector::add(self : TimeseriesanomalyiqrVector, other : TimeseriesanomalyiqrVector) -> TimeseriesanomalyiqrVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyiqrVector::sub(self : TimeseriesanomalyiqrVector, other : TimeseriesanomalyiqrVector) -> TimeseriesanomalyiqrVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyiqrVector::scale(self : TimeseriesanomalyiqrVector, s : Double) -> TimeseriesanomalyiqrVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalyiqrVector::dot(self : TimeseriesanomalyiqrVector, other : TimeseriesanomalyiqrVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalyiqrVector::norm(self : TimeseriesanomalyiqrVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalyiqrVector::normalize(self : TimeseriesanomalyiqrVector) -> TimeseriesanomalyiqrVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyiqrVector::dist(self : TimeseriesanomalyiqrVector, other : TimeseriesanomalyiqrVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalyiqrVector::to_string(self : TimeseriesanomalyiqrVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyiqrFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_frame_make(size : Int) -> TimeseriesanomalyiqrFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyiqrFrame::len(self : TimeseriesanomalyiqrFrame) -> Int { self.size }

pub fn TimeseriesanomalyiqrFrame::get(self : TimeseriesanomalyiqrFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyiqrFrame::set(self : TimeseriesanomalyiqrFrame, i : Int, v : Double) -> TimeseriesanomalyiqrFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrFrame::sum(self : TimeseriesanomalyiqrFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyiqrFrame::mean(self : TimeseriesanomalyiqrFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyiqrFrame::scale(self : TimeseriesanomalyiqrFrame, f : Double) -> TimeseriesanomalyiqrFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrFrame::add(self : TimeseriesanomalyiqrFrame, other : TimeseriesanomalyiqrFrame) -> TimeseriesanomalyiqrFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyiqrFrame::copy(self : TimeseriesanomalyiqrFrame) -> TimeseriesanomalyiqrFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrFrame::fill(self : TimeseriesanomalyiqrFrame, v : Double) -> TimeseriesanomalyiqrFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrFrame::min(self : TimeseriesanomalyiqrFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyiqrFrame::max(self : TimeseriesanomalyiqrFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyiqrFrame::to_string(self : TimeseriesanomalyiqrFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_table_make(size : Int) -> TimeseriesanomalyiqrTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyiqrTable::len(self : TimeseriesanomalyiqrTable) -> Int { self.size }

pub fn TimeseriesanomalyiqrTable::get(self : TimeseriesanomalyiqrTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyiqrTable::set(self : TimeseriesanomalyiqrTable, i : Int, v : Double) -> TimeseriesanomalyiqrTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrTable::sum(self : TimeseriesanomalyiqrTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyiqrTable::mean(self : TimeseriesanomalyiqrTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyiqrTable::scale(self : TimeseriesanomalyiqrTable, f : Double) -> TimeseriesanomalyiqrTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrTable::add(self : TimeseriesanomalyiqrTable, other : TimeseriesanomalyiqrTable) -> TimeseriesanomalyiqrTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyiqrTable::copy(self : TimeseriesanomalyiqrTable) -> TimeseriesanomalyiqrTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrTable::fill(self : TimeseriesanomalyiqrTable, v : Double) -> TimeseriesanomalyiqrTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrTable::min(self : TimeseriesanomalyiqrTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyiqrTable::max(self : TimeseriesanomalyiqrTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyiqrTable::to_string(self : TimeseriesanomalyiqrTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_graphn_make(size : Int) -> TimeseriesanomalyiqrGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyiqrGraphN::len(self : TimeseriesanomalyiqrGraphN) -> Int { self.size }

pub fn TimeseriesanomalyiqrGraphN::get(self : TimeseriesanomalyiqrGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyiqrGraphN::set(self : TimeseriesanomalyiqrGraphN, i : Int, v : Double) -> TimeseriesanomalyiqrGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrGraphN::sum(self : TimeseriesanomalyiqrGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyiqrGraphN::mean(self : TimeseriesanomalyiqrGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyiqrGraphN::scale(self : TimeseriesanomalyiqrGraphN, f : Double) -> TimeseriesanomalyiqrGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrGraphN::add(self : TimeseriesanomalyiqrGraphN, other : TimeseriesanomalyiqrGraphN) -> TimeseriesanomalyiqrGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyiqrGraphN::copy(self : TimeseriesanomalyiqrGraphN) -> TimeseriesanomalyiqrGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrGraphN::fill(self : TimeseriesanomalyiqrGraphN, v : Double) -> TimeseriesanomalyiqrGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrGraphN::min(self : TimeseriesanomalyiqrGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyiqrGraphN::max(self : TimeseriesanomalyiqrGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyiqrGraphN::to_string(self : TimeseriesanomalyiqrGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_node_make(size : Int) -> TimeseriesanomalyiqrNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyiqrNode::len(self : TimeseriesanomalyiqrNode) -> Int { self.size }

pub fn TimeseriesanomalyiqrNode::get(self : TimeseriesanomalyiqrNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyiqrNode::set(self : TimeseriesanomalyiqrNode, i : Int, v : Double) -> TimeseriesanomalyiqrNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrNode::sum(self : TimeseriesanomalyiqrNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyiqrNode::mean(self : TimeseriesanomalyiqrNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyiqrNode::scale(self : TimeseriesanomalyiqrNode, f : Double) -> TimeseriesanomalyiqrNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrNode::add(self : TimeseriesanomalyiqrNode, other : TimeseriesanomalyiqrNode) -> TimeseriesanomalyiqrNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyiqrNode::copy(self : TimeseriesanomalyiqrNode) -> TimeseriesanomalyiqrNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrNode::fill(self : TimeseriesanomalyiqrNode, v : Double) -> TimeseriesanomalyiqrNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrNode::min(self : TimeseriesanomalyiqrNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyiqrNode::max(self : TimeseriesanomalyiqrNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyiqrNode::to_string(self : TimeseriesanomalyiqrNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_edge_make(size : Int) -> TimeseriesanomalyiqrEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyiqrEdge::len(self : TimeseriesanomalyiqrEdge) -> Int { self.size }

pub fn TimeseriesanomalyiqrEdge::get(self : TimeseriesanomalyiqrEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyiqrEdge::set(self : TimeseriesanomalyiqrEdge, i : Int, v : Double) -> TimeseriesanomalyiqrEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrEdge::sum(self : TimeseriesanomalyiqrEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyiqrEdge::mean(self : TimeseriesanomalyiqrEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyiqrEdge::scale(self : TimeseriesanomalyiqrEdge, f : Double) -> TimeseriesanomalyiqrEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrEdge::add(self : TimeseriesanomalyiqrEdge, other : TimeseriesanomalyiqrEdge) -> TimeseriesanomalyiqrEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyiqrEdge::copy(self : TimeseriesanomalyiqrEdge) -> TimeseriesanomalyiqrEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrEdge::fill(self : TimeseriesanomalyiqrEdge, v : Double) -> TimeseriesanomalyiqrEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrEdge::min(self : TimeseriesanomalyiqrEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyiqrEdge::max(self : TimeseriesanomalyiqrEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyiqrEdge::to_string(self : TimeseriesanomalyiqrEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_path_make(size : Int) -> TimeseriesanomalyiqrPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyiqrPath::len(self : TimeseriesanomalyiqrPath) -> Int { self.size }

pub fn TimeseriesanomalyiqrPath::get(self : TimeseriesanomalyiqrPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyiqrPath::set(self : TimeseriesanomalyiqrPath, i : Int, v : Double) -> TimeseriesanomalyiqrPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrPath::sum(self : TimeseriesanomalyiqrPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyiqrPath::mean(self : TimeseriesanomalyiqrPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyiqrPath::scale(self : TimeseriesanomalyiqrPath, f : Double) -> TimeseriesanomalyiqrPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrPath::add(self : TimeseriesanomalyiqrPath, other : TimeseriesanomalyiqrPath) -> TimeseriesanomalyiqrPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyiqrPath::copy(self : TimeseriesanomalyiqrPath) -> TimeseriesanomalyiqrPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrPath::fill(self : TimeseriesanomalyiqrPath, v : Double) -> TimeseriesanomalyiqrPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrPath::min(self : TimeseriesanomalyiqrPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyiqrPath::max(self : TimeseriesanomalyiqrPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyiqrPath::to_string(self : TimeseriesanomalyiqrPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_cluster_make(size : Int) -> TimeseriesanomalyiqrCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyiqrCluster::len(self : TimeseriesanomalyiqrCluster) -> Int { self.size }

pub fn TimeseriesanomalyiqrCluster::get(self : TimeseriesanomalyiqrCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyiqrCluster::set(self : TimeseriesanomalyiqrCluster, i : Int, v : Double) -> TimeseriesanomalyiqrCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrCluster::sum(self : TimeseriesanomalyiqrCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyiqrCluster::mean(self : TimeseriesanomalyiqrCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyiqrCluster::scale(self : TimeseriesanomalyiqrCluster, f : Double) -> TimeseriesanomalyiqrCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrCluster::add(self : TimeseriesanomalyiqrCluster, other : TimeseriesanomalyiqrCluster) -> TimeseriesanomalyiqrCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyiqrCluster::copy(self : TimeseriesanomalyiqrCluster) -> TimeseriesanomalyiqrCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrCluster::fill(self : TimeseriesanomalyiqrCluster, v : Double) -> TimeseriesanomalyiqrCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrCluster::min(self : TimeseriesanomalyiqrCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyiqrCluster::max(self : TimeseriesanomalyiqrCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyiqrCluster::to_string(self : TimeseriesanomalyiqrCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_model_make(size : Int) -> TimeseriesanomalyiqrModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyiqrModel::len(self : TimeseriesanomalyiqrModel) -> Int { self.size }

pub fn TimeseriesanomalyiqrModel::get(self : TimeseriesanomalyiqrModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyiqrModel::set(self : TimeseriesanomalyiqrModel, i : Int, v : Double) -> TimeseriesanomalyiqrModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrModel::sum(self : TimeseriesanomalyiqrModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyiqrModel::mean(self : TimeseriesanomalyiqrModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyiqrModel::scale(self : TimeseriesanomalyiqrModel, f : Double) -> TimeseriesanomalyiqrModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrModel::add(self : TimeseriesanomalyiqrModel, other : TimeseriesanomalyiqrModel) -> TimeseriesanomalyiqrModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyiqrModel::copy(self : TimeseriesanomalyiqrModel) -> TimeseriesanomalyiqrModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrModel::fill(self : TimeseriesanomalyiqrModel, v : Double) -> TimeseriesanomalyiqrModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrModel::min(self : TimeseriesanomalyiqrModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyiqrModel::max(self : TimeseriesanomalyiqrModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyiqrModel::to_string(self : TimeseriesanomalyiqrModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_layer_make(size : Int) -> TimeseriesanomalyiqrLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyiqrLayer::len(self : TimeseriesanomalyiqrLayer) -> Int { self.size }

pub fn TimeseriesanomalyiqrLayer::get(self : TimeseriesanomalyiqrLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyiqrLayer::set(self : TimeseriesanomalyiqrLayer, i : Int, v : Double) -> TimeseriesanomalyiqrLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrLayer::sum(self : TimeseriesanomalyiqrLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyiqrLayer::mean(self : TimeseriesanomalyiqrLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyiqrLayer::scale(self : TimeseriesanomalyiqrLayer, f : Double) -> TimeseriesanomalyiqrLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrLayer::add(self : TimeseriesanomalyiqrLayer, other : TimeseriesanomalyiqrLayer) -> TimeseriesanomalyiqrLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyiqrLayer::copy(self : TimeseriesanomalyiqrLayer) -> TimeseriesanomalyiqrLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrLayer::fill(self : TimeseriesanomalyiqrLayer, v : Double) -> TimeseriesanomalyiqrLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrLayer::min(self : TimeseriesanomalyiqrLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyiqrLayer::max(self : TimeseriesanomalyiqrLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyiqrLayer::to_string(self : TimeseriesanomalyiqrLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_buffer_make(size : Int) -> TimeseriesanomalyiqrBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyiqrBuffer::len(self : TimeseriesanomalyiqrBuffer) -> Int { self.size }

pub fn TimeseriesanomalyiqrBuffer::get(self : TimeseriesanomalyiqrBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyiqrBuffer::set(self : TimeseriesanomalyiqrBuffer, i : Int, v : Double) -> TimeseriesanomalyiqrBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrBuffer::sum(self : TimeseriesanomalyiqrBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyiqrBuffer::mean(self : TimeseriesanomalyiqrBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyiqrBuffer::scale(self : TimeseriesanomalyiqrBuffer, f : Double) -> TimeseriesanomalyiqrBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrBuffer::add(self : TimeseriesanomalyiqrBuffer, other : TimeseriesanomalyiqrBuffer) -> TimeseriesanomalyiqrBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyiqrBuffer::copy(self : TimeseriesanomalyiqrBuffer) -> TimeseriesanomalyiqrBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrBuffer::fill(self : TimeseriesanomalyiqrBuffer, v : Double) -> TimeseriesanomalyiqrBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrBuffer::min(self : TimeseriesanomalyiqrBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyiqrBuffer::max(self : TimeseriesanomalyiqrBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyiqrBuffer::to_string(self : TimeseriesanomalyiqrBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_cursor_make(size : Int) -> TimeseriesanomalyiqrCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyiqrCursor::len(self : TimeseriesanomalyiqrCursor) -> Int { self.size }

pub fn TimeseriesanomalyiqrCursor::get(self : TimeseriesanomalyiqrCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyiqrCursor::set(self : TimeseriesanomalyiqrCursor, i : Int, v : Double) -> TimeseriesanomalyiqrCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrCursor::sum(self : TimeseriesanomalyiqrCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyiqrCursor::mean(self : TimeseriesanomalyiqrCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyiqrCursor::scale(self : TimeseriesanomalyiqrCursor, f : Double) -> TimeseriesanomalyiqrCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrCursor::add(self : TimeseriesanomalyiqrCursor, other : TimeseriesanomalyiqrCursor) -> TimeseriesanomalyiqrCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyiqrCursor::copy(self : TimeseriesanomalyiqrCursor) -> TimeseriesanomalyiqrCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrCursor::fill(self : TimeseriesanomalyiqrCursor, v : Double) -> TimeseriesanomalyiqrCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrCursor::min(self : TimeseriesanomalyiqrCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyiqrCursor::max(self : TimeseriesanomalyiqrCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyiqrCursor::to_string(self : TimeseriesanomalyiqrCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_view_make(size : Int) -> TimeseriesanomalyiqrView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyiqrView::len(self : TimeseriesanomalyiqrView) -> Int { self.size }

pub fn TimeseriesanomalyiqrView::get(self : TimeseriesanomalyiqrView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyiqrView::set(self : TimeseriesanomalyiqrView, i : Int, v : Double) -> TimeseriesanomalyiqrView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrView::sum(self : TimeseriesanomalyiqrView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyiqrView::mean(self : TimeseriesanomalyiqrView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyiqrView::scale(self : TimeseriesanomalyiqrView, f : Double) -> TimeseriesanomalyiqrView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrView::add(self : TimeseriesanomalyiqrView, other : TimeseriesanomalyiqrView) -> TimeseriesanomalyiqrView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyiqrView::copy(self : TimeseriesanomalyiqrView) -> TimeseriesanomalyiqrView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrView::fill(self : TimeseriesanomalyiqrView, v : Double) -> TimeseriesanomalyiqrView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrView::min(self : TimeseriesanomalyiqrView) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyiqrView::max(self : TimeseriesanomalyiqrView) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyiqrView::to_string(self : TimeseriesanomalyiqrView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_range_make(size : Int) -> TimeseriesanomalyiqrRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyiqrRange::len(self : TimeseriesanomalyiqrRange) -> Int { self.size }

pub fn TimeseriesanomalyiqrRange::get(self : TimeseriesanomalyiqrRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyiqrRange::set(self : TimeseriesanomalyiqrRange, i : Int, v : Double) -> TimeseriesanomalyiqrRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrRange::sum(self : TimeseriesanomalyiqrRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyiqrRange::mean(self : TimeseriesanomalyiqrRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyiqrRange::scale(self : TimeseriesanomalyiqrRange, f : Double) -> TimeseriesanomalyiqrRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrRange::add(self : TimeseriesanomalyiqrRange, other : TimeseriesanomalyiqrRange) -> TimeseriesanomalyiqrRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyiqrRange::copy(self : TimeseriesanomalyiqrRange) -> TimeseriesanomalyiqrRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrRange::fill(self : TimeseriesanomalyiqrRange, v : Double) -> TimeseriesanomalyiqrRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrRange::min(self : TimeseriesanomalyiqrRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyiqrRange::max(self : TimeseriesanomalyiqrRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyiqrRange::to_string(self : TimeseriesanomalyiqrRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_slice_make(size : Int) -> TimeseriesanomalyiqrSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyiqrSlice::len(self : TimeseriesanomalyiqrSlice) -> Int { self.size }

pub fn TimeseriesanomalyiqrSlice::get(self : TimeseriesanomalyiqrSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyiqrSlice::set(self : TimeseriesanomalyiqrSlice, i : Int, v : Double) -> TimeseriesanomalyiqrSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrSlice::sum(self : TimeseriesanomalyiqrSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyiqrSlice::mean(self : TimeseriesanomalyiqrSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyiqrSlice::scale(self : TimeseriesanomalyiqrSlice, f : Double) -> TimeseriesanomalyiqrSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrSlice::add(self : TimeseriesanomalyiqrSlice, other : TimeseriesanomalyiqrSlice) -> TimeseriesanomalyiqrSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyiqrSlice::copy(self : TimeseriesanomalyiqrSlice) -> TimeseriesanomalyiqrSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrSlice::fill(self : TimeseriesanomalyiqrSlice, v : Double) -> TimeseriesanomalyiqrSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyiqrSlice::min(self : TimeseriesanomalyiqrSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyiqrSlice::max(self : TimeseriesanomalyiqrSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyiqrSlice::to_string(self : TimeseriesanomalyiqrSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

