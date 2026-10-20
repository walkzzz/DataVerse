///===
/// extcore/timeseries_anomaly_lstm

pub(all) struct TimeseriesanomalylstmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_lstm_make_point(x : Double, y : Double) -> TimeseriesanomalylstmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_lstm_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalylstmPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalylstmPoint::x(self : TimeseriesanomalylstmPoint) -> Double { self.x }

pub fn TimeseriesanomalylstmPoint::y(self : TimeseriesanomalylstmPoint) -> Double { self.y }

pub fn TimeseriesanomalylstmPoint::z(self : TimeseriesanomalylstmPoint) -> Double { self.z }

pub fn TimeseriesanomalylstmPoint::label(self : TimeseriesanomalylstmPoint) -> Int { self.label }

pub fn TimeseriesanomalylstmPoint::dist(self : TimeseriesanomalylstmPoint, other : TimeseriesanomalylstmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalylstmPoint::add(self : TimeseriesanomalylstmPoint, other : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalylstmPoint::sub(self : TimeseriesanomalylstmPoint, other : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalylstmPoint::scale(self : TimeseriesanomalylstmPoint, s : Double) -> TimeseriesanomalylstmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalylstmPoint::dot(self : TimeseriesanomalylstmPoint, other : TimeseriesanomalylstmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalylstmPoint::cross(self : TimeseriesanomalylstmPoint, other : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalylstmPoint::norm(self : TimeseriesanomalylstmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalylstmPoint::normalize(self : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalylstmPoint::negate(self : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalylstmPoint::mid(self : TimeseriesanomalylstmPoint, other : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalylstmPoint::lerp(self : TimeseriesanomalylstmPoint, other : TimeseriesanomalylstmPoint, t : Double) -> TimeseriesanomalylstmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalylstmPoint::to_string(self : TimeseriesanomalylstmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_lstm_make_series(vals : Array[Double], name : String) -> TimeseriesanomalylstmSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalylstmSeries::len(self : TimeseriesanomalylstmSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalylstmSeries::sum(self : TimeseriesanomalylstmSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalylstmSeries::mean(self : TimeseriesanomalylstmSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalylstmSeries::min(self : TimeseriesanomalylstmSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalylstmSeries::max(self : TimeseriesanomalylstmSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalylstmSeries::range(self : TimeseriesanomalylstmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalylstmSeries::variance(self : TimeseriesanomalylstmSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalylstmSeries::std(self : TimeseriesanomalylstmSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalylstmSeries::median(self : TimeseriesanomalylstmSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalylstmSeries::scale(self : TimeseriesanomalylstmSeries, f : Double) -> TimeseriesanomalylstmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalylstmSeries::add(self : TimeseriesanomalylstmSeries, other : TimeseriesanomalylstmSeries) -> TimeseriesanomalylstmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalylstmSeries::sub(self : TimeseriesanomalylstmSeries, other : TimeseriesanomalylstmSeries) -> TimeseriesanomalylstmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalylstmSeries::normalize(self : TimeseriesanomalylstmSeries) -> TimeseriesanomalylstmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalylstmSeries::cumsum(self : TimeseriesanomalylstmSeries) -> TimeseriesanomalylstmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalylstmSeries::to_string(self : TimeseriesanomalylstmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalylstmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_lstm_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalylstmMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_lstm_matrix_identity(n : Int) -> TimeseriesanomalylstmMatrix {
  let m = timeseries_anomaly_lstm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalylstmMatrix::get(self : TimeseriesanomalylstmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalylstmMatrix::transpose(self : TimeseriesanomalylstmMatrix) -> TimeseriesanomalylstmMatrix {
  let result = timeseries_anomaly_lstm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalylstmMatrix::add(self : TimeseriesanomalylstmMatrix, other : TimeseriesanomalylstmMatrix) -> TimeseriesanomalylstmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_lstm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalylstmMatrix::scale(self : TimeseriesanomalylstmMatrix, s : Double) -> TimeseriesanomalylstmMatrix {
  let result = timeseries_anomaly_lstm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalylstmMatrix::multiply(self : TimeseriesanomalylstmMatrix, other : TimeseriesanomalylstmMatrix) -> TimeseriesanomalylstmMatrix {
  if self.cols != other.rows { return timeseries_anomaly_lstm_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_lstm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn TimeseriesanomalylstmMatrix::trace(self : TimeseriesanomalylstmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalylstmMatrix::det(self : TimeseriesanomalylstmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalylstmMatrix::norm(self : TimeseriesanomalylstmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalylstmMatrix::to_string(self : TimeseriesanomalylstmMatrix) -> String {
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

pub(all) struct TimeseriesanomalylstmVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_lstm_make_vector(comps : Array[Double]) -> TimeseriesanomalylstmVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_lstm_vector_zero(dim : Int) -> TimeseriesanomalylstmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalylstmVector::add(self : TimeseriesanomalylstmVector, other : TimeseriesanomalylstmVector) -> TimeseriesanomalylstmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalylstmVector::sub(self : TimeseriesanomalylstmVector, other : TimeseriesanomalylstmVector) -> TimeseriesanomalylstmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalylstmVector::scale(self : TimeseriesanomalylstmVector, s : Double) -> TimeseriesanomalylstmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalylstmVector::dot(self : TimeseriesanomalylstmVector, other : TimeseriesanomalylstmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalylstmVector::norm(self : TimeseriesanomalylstmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalylstmVector::normalize(self : TimeseriesanomalylstmVector) -> TimeseriesanomalylstmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalylstmVector::dist(self : TimeseriesanomalylstmVector, other : TimeseriesanomalylstmVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalylstmVector::to_string(self : TimeseriesanomalylstmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalylstmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_frame_make(size : Int) -> TimeseriesanomalylstmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylstmFrame::len(self : TimeseriesanomalylstmFrame) -> Int { self.size }

pub fn TimeseriesanomalylstmFrame::get(self : TimeseriesanomalylstmFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylstmFrame::set(self : TimeseriesanomalylstmFrame, i : Int, v : Double) -> TimeseriesanomalylstmFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmFrame::sum(self : TimeseriesanomalylstmFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylstmFrame::mean(self : TimeseriesanomalylstmFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylstmFrame::scale(self : TimeseriesanomalylstmFrame, f : Double) -> TimeseriesanomalylstmFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmFrame::add(self : TimeseriesanomalylstmFrame, other : TimeseriesanomalylstmFrame) -> TimeseriesanomalylstmFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylstmFrame::copy(self : TimeseriesanomalylstmFrame) -> TimeseriesanomalylstmFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmFrame::fill(self : TimeseriesanomalylstmFrame, v : Double) -> TimeseriesanomalylstmFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmFrame::min(self : TimeseriesanomalylstmFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylstmFrame::max(self : TimeseriesanomalylstmFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylstmFrame::to_string(self : TimeseriesanomalylstmFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_table_make(size : Int) -> TimeseriesanomalylstmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylstmTable::len(self : TimeseriesanomalylstmTable) -> Int { self.size }

pub fn TimeseriesanomalylstmTable::get(self : TimeseriesanomalylstmTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylstmTable::set(self : TimeseriesanomalylstmTable, i : Int, v : Double) -> TimeseriesanomalylstmTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmTable::sum(self : TimeseriesanomalylstmTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylstmTable::mean(self : TimeseriesanomalylstmTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylstmTable::scale(self : TimeseriesanomalylstmTable, f : Double) -> TimeseriesanomalylstmTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmTable::add(self : TimeseriesanomalylstmTable, other : TimeseriesanomalylstmTable) -> TimeseriesanomalylstmTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylstmTable::copy(self : TimeseriesanomalylstmTable) -> TimeseriesanomalylstmTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmTable::fill(self : TimeseriesanomalylstmTable, v : Double) -> TimeseriesanomalylstmTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmTable::min(self : TimeseriesanomalylstmTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylstmTable::max(self : TimeseriesanomalylstmTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylstmTable::to_string(self : TimeseriesanomalylstmTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_graphn_make(size : Int) -> TimeseriesanomalylstmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylstmGraphN::len(self : TimeseriesanomalylstmGraphN) -> Int { self.size }

pub fn TimeseriesanomalylstmGraphN::get(self : TimeseriesanomalylstmGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylstmGraphN::set(self : TimeseriesanomalylstmGraphN, i : Int, v : Double) -> TimeseriesanomalylstmGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmGraphN::sum(self : TimeseriesanomalylstmGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylstmGraphN::mean(self : TimeseriesanomalylstmGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylstmGraphN::scale(self : TimeseriesanomalylstmGraphN, f : Double) -> TimeseriesanomalylstmGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmGraphN::add(self : TimeseriesanomalylstmGraphN, other : TimeseriesanomalylstmGraphN) -> TimeseriesanomalylstmGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylstmGraphN::copy(self : TimeseriesanomalylstmGraphN) -> TimeseriesanomalylstmGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmGraphN::fill(self : TimeseriesanomalylstmGraphN, v : Double) -> TimeseriesanomalylstmGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmGraphN::min(self : TimeseriesanomalylstmGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylstmGraphN::max(self : TimeseriesanomalylstmGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylstmGraphN::to_string(self : TimeseriesanomalylstmGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_node_make(size : Int) -> TimeseriesanomalylstmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylstmNode::len(self : TimeseriesanomalylstmNode) -> Int { self.size }

pub fn TimeseriesanomalylstmNode::get(self : TimeseriesanomalylstmNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylstmNode::set(self : TimeseriesanomalylstmNode, i : Int, v : Double) -> TimeseriesanomalylstmNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmNode::sum(self : TimeseriesanomalylstmNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylstmNode::mean(self : TimeseriesanomalylstmNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylstmNode::scale(self : TimeseriesanomalylstmNode, f : Double) -> TimeseriesanomalylstmNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmNode::add(self : TimeseriesanomalylstmNode, other : TimeseriesanomalylstmNode) -> TimeseriesanomalylstmNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylstmNode::copy(self : TimeseriesanomalylstmNode) -> TimeseriesanomalylstmNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmNode::fill(self : TimeseriesanomalylstmNode, v : Double) -> TimeseriesanomalylstmNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmNode::min(self : TimeseriesanomalylstmNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylstmNode::max(self : TimeseriesanomalylstmNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylstmNode::to_string(self : TimeseriesanomalylstmNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_edge_make(size : Int) -> TimeseriesanomalylstmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylstmEdge::len(self : TimeseriesanomalylstmEdge) -> Int { self.size }

pub fn TimeseriesanomalylstmEdge::get(self : TimeseriesanomalylstmEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylstmEdge::set(self : TimeseriesanomalylstmEdge, i : Int, v : Double) -> TimeseriesanomalylstmEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmEdge::sum(self : TimeseriesanomalylstmEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylstmEdge::mean(self : TimeseriesanomalylstmEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylstmEdge::scale(self : TimeseriesanomalylstmEdge, f : Double) -> TimeseriesanomalylstmEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmEdge::add(self : TimeseriesanomalylstmEdge, other : TimeseriesanomalylstmEdge) -> TimeseriesanomalylstmEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylstmEdge::copy(self : TimeseriesanomalylstmEdge) -> TimeseriesanomalylstmEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmEdge::fill(self : TimeseriesanomalylstmEdge, v : Double) -> TimeseriesanomalylstmEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmEdge::min(self : TimeseriesanomalylstmEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylstmEdge::max(self : TimeseriesanomalylstmEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylstmEdge::to_string(self : TimeseriesanomalylstmEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_path_make(size : Int) -> TimeseriesanomalylstmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylstmPath::len(self : TimeseriesanomalylstmPath) -> Int { self.size }

pub fn TimeseriesanomalylstmPath::get(self : TimeseriesanomalylstmPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylstmPath::set(self : TimeseriesanomalylstmPath, i : Int, v : Double) -> TimeseriesanomalylstmPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmPath::sum(self : TimeseriesanomalylstmPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylstmPath::mean(self : TimeseriesanomalylstmPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylstmPath::scale(self : TimeseriesanomalylstmPath, f : Double) -> TimeseriesanomalylstmPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmPath::add(self : TimeseriesanomalylstmPath, other : TimeseriesanomalylstmPath) -> TimeseriesanomalylstmPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylstmPath::copy(self : TimeseriesanomalylstmPath) -> TimeseriesanomalylstmPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmPath::fill(self : TimeseriesanomalylstmPath, v : Double) -> TimeseriesanomalylstmPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmPath::min(self : TimeseriesanomalylstmPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylstmPath::max(self : TimeseriesanomalylstmPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylstmPath::to_string(self : TimeseriesanomalylstmPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_cluster_make(size : Int) -> TimeseriesanomalylstmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylstmCluster::len(self : TimeseriesanomalylstmCluster) -> Int { self.size }

pub fn TimeseriesanomalylstmCluster::get(self : TimeseriesanomalylstmCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylstmCluster::set(self : TimeseriesanomalylstmCluster, i : Int, v : Double) -> TimeseriesanomalylstmCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmCluster::sum(self : TimeseriesanomalylstmCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylstmCluster::mean(self : TimeseriesanomalylstmCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylstmCluster::scale(self : TimeseriesanomalylstmCluster, f : Double) -> TimeseriesanomalylstmCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmCluster::add(self : TimeseriesanomalylstmCluster, other : TimeseriesanomalylstmCluster) -> TimeseriesanomalylstmCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylstmCluster::copy(self : TimeseriesanomalylstmCluster) -> TimeseriesanomalylstmCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmCluster::fill(self : TimeseriesanomalylstmCluster, v : Double) -> TimeseriesanomalylstmCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmCluster::min(self : TimeseriesanomalylstmCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylstmCluster::max(self : TimeseriesanomalylstmCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylstmCluster::to_string(self : TimeseriesanomalylstmCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_model_make(size : Int) -> TimeseriesanomalylstmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylstmModel::len(self : TimeseriesanomalylstmModel) -> Int { self.size }

pub fn TimeseriesanomalylstmModel::get(self : TimeseriesanomalylstmModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylstmModel::set(self : TimeseriesanomalylstmModel, i : Int, v : Double) -> TimeseriesanomalylstmModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmModel::sum(self : TimeseriesanomalylstmModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylstmModel::mean(self : TimeseriesanomalylstmModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylstmModel::scale(self : TimeseriesanomalylstmModel, f : Double) -> TimeseriesanomalylstmModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmModel::add(self : TimeseriesanomalylstmModel, other : TimeseriesanomalylstmModel) -> TimeseriesanomalylstmModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylstmModel::copy(self : TimeseriesanomalylstmModel) -> TimeseriesanomalylstmModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmModel::fill(self : TimeseriesanomalylstmModel, v : Double) -> TimeseriesanomalylstmModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmModel::min(self : TimeseriesanomalylstmModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylstmModel::max(self : TimeseriesanomalylstmModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylstmModel::to_string(self : TimeseriesanomalylstmModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_layer_make(size : Int) -> TimeseriesanomalylstmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylstmLayer::len(self : TimeseriesanomalylstmLayer) -> Int { self.size }

pub fn TimeseriesanomalylstmLayer::get(self : TimeseriesanomalylstmLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylstmLayer::set(self : TimeseriesanomalylstmLayer, i : Int, v : Double) -> TimeseriesanomalylstmLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmLayer::sum(self : TimeseriesanomalylstmLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylstmLayer::mean(self : TimeseriesanomalylstmLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylstmLayer::scale(self : TimeseriesanomalylstmLayer, f : Double) -> TimeseriesanomalylstmLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmLayer::add(self : TimeseriesanomalylstmLayer, other : TimeseriesanomalylstmLayer) -> TimeseriesanomalylstmLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylstmLayer::copy(self : TimeseriesanomalylstmLayer) -> TimeseriesanomalylstmLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmLayer::fill(self : TimeseriesanomalylstmLayer, v : Double) -> TimeseriesanomalylstmLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmLayer::min(self : TimeseriesanomalylstmLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylstmLayer::max(self : TimeseriesanomalylstmLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylstmLayer::to_string(self : TimeseriesanomalylstmLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_buffer_make(size : Int) -> TimeseriesanomalylstmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylstmBuffer::len(self : TimeseriesanomalylstmBuffer) -> Int { self.size }

pub fn TimeseriesanomalylstmBuffer::get(self : TimeseriesanomalylstmBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylstmBuffer::set(self : TimeseriesanomalylstmBuffer, i : Int, v : Double) -> TimeseriesanomalylstmBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmBuffer::sum(self : TimeseriesanomalylstmBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylstmBuffer::mean(self : TimeseriesanomalylstmBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylstmBuffer::scale(self : TimeseriesanomalylstmBuffer, f : Double) -> TimeseriesanomalylstmBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmBuffer::add(self : TimeseriesanomalylstmBuffer, other : TimeseriesanomalylstmBuffer) -> TimeseriesanomalylstmBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylstmBuffer::copy(self : TimeseriesanomalylstmBuffer) -> TimeseriesanomalylstmBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmBuffer::fill(self : TimeseriesanomalylstmBuffer, v : Double) -> TimeseriesanomalylstmBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmBuffer::min(self : TimeseriesanomalylstmBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylstmBuffer::max(self : TimeseriesanomalylstmBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylstmBuffer::to_string(self : TimeseriesanomalylstmBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_cursor_make(size : Int) -> TimeseriesanomalylstmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylstmCursor::len(self : TimeseriesanomalylstmCursor) -> Int { self.size }

pub fn TimeseriesanomalylstmCursor::get(self : TimeseriesanomalylstmCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylstmCursor::set(self : TimeseriesanomalylstmCursor, i : Int, v : Double) -> TimeseriesanomalylstmCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmCursor::sum(self : TimeseriesanomalylstmCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylstmCursor::mean(self : TimeseriesanomalylstmCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylstmCursor::scale(self : TimeseriesanomalylstmCursor, f : Double) -> TimeseriesanomalylstmCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmCursor::add(self : TimeseriesanomalylstmCursor, other : TimeseriesanomalylstmCursor) -> TimeseriesanomalylstmCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylstmCursor::copy(self : TimeseriesanomalylstmCursor) -> TimeseriesanomalylstmCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmCursor::fill(self : TimeseriesanomalylstmCursor, v : Double) -> TimeseriesanomalylstmCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmCursor::min(self : TimeseriesanomalylstmCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylstmCursor::max(self : TimeseriesanomalylstmCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylstmCursor::to_string(self : TimeseriesanomalylstmCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_view_make(size : Int) -> TimeseriesanomalylstmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylstmView::len(self : TimeseriesanomalylstmView) -> Int { self.size }

pub fn TimeseriesanomalylstmView::get(self : TimeseriesanomalylstmView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylstmView::set(self : TimeseriesanomalylstmView, i : Int, v : Double) -> TimeseriesanomalylstmView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmView::sum(self : TimeseriesanomalylstmView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylstmView::mean(self : TimeseriesanomalylstmView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylstmView::scale(self : TimeseriesanomalylstmView, f : Double) -> TimeseriesanomalylstmView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmView::add(self : TimeseriesanomalylstmView, other : TimeseriesanomalylstmView) -> TimeseriesanomalylstmView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylstmView::copy(self : TimeseriesanomalylstmView) -> TimeseriesanomalylstmView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmView::fill(self : TimeseriesanomalylstmView, v : Double) -> TimeseriesanomalylstmView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmView::min(self : TimeseriesanomalylstmView) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylstmView::max(self : TimeseriesanomalylstmView) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylstmView::to_string(self : TimeseriesanomalylstmView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_range_make(size : Int) -> TimeseriesanomalylstmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylstmRange::len(self : TimeseriesanomalylstmRange) -> Int { self.size }

pub fn TimeseriesanomalylstmRange::get(self : TimeseriesanomalylstmRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylstmRange::set(self : TimeseriesanomalylstmRange, i : Int, v : Double) -> TimeseriesanomalylstmRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmRange::sum(self : TimeseriesanomalylstmRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylstmRange::mean(self : TimeseriesanomalylstmRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylstmRange::scale(self : TimeseriesanomalylstmRange, f : Double) -> TimeseriesanomalylstmRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmRange::add(self : TimeseriesanomalylstmRange, other : TimeseriesanomalylstmRange) -> TimeseriesanomalylstmRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylstmRange::copy(self : TimeseriesanomalylstmRange) -> TimeseriesanomalylstmRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmRange::fill(self : TimeseriesanomalylstmRange, v : Double) -> TimeseriesanomalylstmRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmRange::min(self : TimeseriesanomalylstmRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylstmRange::max(self : TimeseriesanomalylstmRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylstmRange::to_string(self : TimeseriesanomalylstmRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_slice_make(size : Int) -> TimeseriesanomalylstmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalylstmSlice::len(self : TimeseriesanomalylstmSlice) -> Int { self.size }

pub fn TimeseriesanomalylstmSlice::get(self : TimeseriesanomalylstmSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalylstmSlice::set(self : TimeseriesanomalylstmSlice, i : Int, v : Double) -> TimeseriesanomalylstmSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmSlice::sum(self : TimeseriesanomalylstmSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalylstmSlice::mean(self : TimeseriesanomalylstmSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalylstmSlice::scale(self : TimeseriesanomalylstmSlice, f : Double) -> TimeseriesanomalylstmSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmSlice::add(self : TimeseriesanomalylstmSlice, other : TimeseriesanomalylstmSlice) -> TimeseriesanomalylstmSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalylstmSlice::copy(self : TimeseriesanomalylstmSlice) -> TimeseriesanomalylstmSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmSlice::fill(self : TimeseriesanomalylstmSlice, v : Double) -> TimeseriesanomalylstmSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalylstmSlice::min(self : TimeseriesanomalylstmSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalylstmSlice::max(self : TimeseriesanomalylstmSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalylstmSlice::to_string(self : TimeseriesanomalylstmSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

