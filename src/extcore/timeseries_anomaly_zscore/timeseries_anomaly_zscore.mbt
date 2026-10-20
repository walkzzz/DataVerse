///===
/// extcore/timeseries_anomaly_zscore

pub(all) struct TimeseriesanomalyzscorePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_zscore_make_point(x : Double, y : Double) -> TimeseriesanomalyzscorePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_zscore_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalyzscorePoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalyzscorePoint::x(self : TimeseriesanomalyzscorePoint) -> Double { self.x }

pub fn TimeseriesanomalyzscorePoint::y(self : TimeseriesanomalyzscorePoint) -> Double { self.y }

pub fn TimeseriesanomalyzscorePoint::z(self : TimeseriesanomalyzscorePoint) -> Double { self.z }

pub fn TimeseriesanomalyzscorePoint::label(self : TimeseriesanomalyzscorePoint) -> Int { self.label }

pub fn TimeseriesanomalyzscorePoint::dist(self : TimeseriesanomalyzscorePoint, other : TimeseriesanomalyzscorePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalyzscorePoint::add(self : TimeseriesanomalyzscorePoint, other : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalyzscorePoint::sub(self : TimeseriesanomalyzscorePoint, other : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalyzscorePoint::scale(self : TimeseriesanomalyzscorePoint, s : Double) -> TimeseriesanomalyzscorePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalyzscorePoint::dot(self : TimeseriesanomalyzscorePoint, other : TimeseriesanomalyzscorePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalyzscorePoint::cross(self : TimeseriesanomalyzscorePoint, other : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalyzscorePoint::norm(self : TimeseriesanomalyzscorePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalyzscorePoint::normalize(self : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyzscorePoint::negate(self : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalyzscorePoint::mid(self : TimeseriesanomalyzscorePoint, other : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalyzscorePoint::lerp(self : TimeseriesanomalyzscorePoint, other : TimeseriesanomalyzscorePoint, t : Double) -> TimeseriesanomalyzscorePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalyzscorePoint::to_string(self : TimeseriesanomalyzscorePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_zscore_make_series(vals : Array[Double], name : String) -> TimeseriesanomalyzscoreSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalyzscoreSeries::len(self : TimeseriesanomalyzscoreSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalyzscoreSeries::sum(self : TimeseriesanomalyzscoreSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalyzscoreSeries::mean(self : TimeseriesanomalyzscoreSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalyzscoreSeries::min(self : TimeseriesanomalyzscoreSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalyzscoreSeries::max(self : TimeseriesanomalyzscoreSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalyzscoreSeries::range(self : TimeseriesanomalyzscoreSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalyzscoreSeries::variance(self : TimeseriesanomalyzscoreSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalyzscoreSeries::std(self : TimeseriesanomalyzscoreSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalyzscoreSeries::median(self : TimeseriesanomalyzscoreSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalyzscoreSeries::scale(self : TimeseriesanomalyzscoreSeries, f : Double) -> TimeseriesanomalyzscoreSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalyzscoreSeries::add(self : TimeseriesanomalyzscoreSeries, other : TimeseriesanomalyzscoreSeries) -> TimeseriesanomalyzscoreSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyzscoreSeries::sub(self : TimeseriesanomalyzscoreSeries, other : TimeseriesanomalyzscoreSeries) -> TimeseriesanomalyzscoreSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyzscoreSeries::normalize(self : TimeseriesanomalyzscoreSeries) -> TimeseriesanomalyzscoreSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalyzscoreSeries::cumsum(self : TimeseriesanomalyzscoreSeries) -> TimeseriesanomalyzscoreSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalyzscoreSeries::to_string(self : TimeseriesanomalyzscoreSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyzscoreMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_zscore_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalyzscoreMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_zscore_matrix_identity(n : Int) -> TimeseriesanomalyzscoreMatrix {
  let m = timeseries_anomaly_zscore_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalyzscoreMatrix::get(self : TimeseriesanomalyzscoreMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalyzscoreMatrix::transpose(self : TimeseriesanomalyzscoreMatrix) -> TimeseriesanomalyzscoreMatrix {
  let result = timeseries_anomaly_zscore_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalyzscoreMatrix::add(self : TimeseriesanomalyzscoreMatrix, other : TimeseriesanomalyzscoreMatrix) -> TimeseriesanomalyzscoreMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_zscore_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalyzscoreMatrix::scale(self : TimeseriesanomalyzscoreMatrix, s : Double) -> TimeseriesanomalyzscoreMatrix {
  let result = timeseries_anomaly_zscore_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalyzscoreMatrix::multiply(self : TimeseriesanomalyzscoreMatrix, other : TimeseriesanomalyzscoreMatrix) -> TimeseriesanomalyzscoreMatrix {
  if self.cols != other.rows { return timeseries_anomaly_zscore_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_zscore_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn TimeseriesanomalyzscoreMatrix::trace(self : TimeseriesanomalyzscoreMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalyzscoreMatrix::det(self : TimeseriesanomalyzscoreMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalyzscoreMatrix::norm(self : TimeseriesanomalyzscoreMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalyzscoreMatrix::to_string(self : TimeseriesanomalyzscoreMatrix) -> String {
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

pub(all) struct TimeseriesanomalyzscoreVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_zscore_make_vector(comps : Array[Double]) -> TimeseriesanomalyzscoreVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_zscore_vector_zero(dim : Int) -> TimeseriesanomalyzscoreVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalyzscoreVector::add(self : TimeseriesanomalyzscoreVector, other : TimeseriesanomalyzscoreVector) -> TimeseriesanomalyzscoreVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyzscoreVector::sub(self : TimeseriesanomalyzscoreVector, other : TimeseriesanomalyzscoreVector) -> TimeseriesanomalyzscoreVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyzscoreVector::scale(self : TimeseriesanomalyzscoreVector, s : Double) -> TimeseriesanomalyzscoreVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalyzscoreVector::dot(self : TimeseriesanomalyzscoreVector, other : TimeseriesanomalyzscoreVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalyzscoreVector::norm(self : TimeseriesanomalyzscoreVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalyzscoreVector::normalize(self : TimeseriesanomalyzscoreVector) -> TimeseriesanomalyzscoreVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyzscoreVector::dist(self : TimeseriesanomalyzscoreVector, other : TimeseriesanomalyzscoreVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalyzscoreVector::to_string(self : TimeseriesanomalyzscoreVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyzscoreFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_frame_make(size : Int) -> TimeseriesanomalyzscoreFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyzscoreFrame::len(self : TimeseriesanomalyzscoreFrame) -> Int { self.size }

pub fn TimeseriesanomalyzscoreFrame::get(self : TimeseriesanomalyzscoreFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyzscoreFrame::set(self : TimeseriesanomalyzscoreFrame, i : Int, v : Double) -> TimeseriesanomalyzscoreFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreFrame::sum(self : TimeseriesanomalyzscoreFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyzscoreFrame::mean(self : TimeseriesanomalyzscoreFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyzscoreFrame::scale(self : TimeseriesanomalyzscoreFrame, f : Double) -> TimeseriesanomalyzscoreFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreFrame::add(self : TimeseriesanomalyzscoreFrame, other : TimeseriesanomalyzscoreFrame) -> TimeseriesanomalyzscoreFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreFrame::copy(self : TimeseriesanomalyzscoreFrame) -> TimeseriesanomalyzscoreFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreFrame::fill(self : TimeseriesanomalyzscoreFrame, v : Double) -> TimeseriesanomalyzscoreFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreFrame::min(self : TimeseriesanomalyzscoreFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyzscoreFrame::max(self : TimeseriesanomalyzscoreFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyzscoreFrame::to_string(self : TimeseriesanomalyzscoreFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_table_make(size : Int) -> TimeseriesanomalyzscoreTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyzscoreTable::len(self : TimeseriesanomalyzscoreTable) -> Int { self.size }

pub fn TimeseriesanomalyzscoreTable::get(self : TimeseriesanomalyzscoreTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyzscoreTable::set(self : TimeseriesanomalyzscoreTable, i : Int, v : Double) -> TimeseriesanomalyzscoreTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreTable::sum(self : TimeseriesanomalyzscoreTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyzscoreTable::mean(self : TimeseriesanomalyzscoreTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyzscoreTable::scale(self : TimeseriesanomalyzscoreTable, f : Double) -> TimeseriesanomalyzscoreTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreTable::add(self : TimeseriesanomalyzscoreTable, other : TimeseriesanomalyzscoreTable) -> TimeseriesanomalyzscoreTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreTable::copy(self : TimeseriesanomalyzscoreTable) -> TimeseriesanomalyzscoreTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreTable::fill(self : TimeseriesanomalyzscoreTable, v : Double) -> TimeseriesanomalyzscoreTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreTable::min(self : TimeseriesanomalyzscoreTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyzscoreTable::max(self : TimeseriesanomalyzscoreTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyzscoreTable::to_string(self : TimeseriesanomalyzscoreTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_graphn_make(size : Int) -> TimeseriesanomalyzscoreGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyzscoreGraphN::len(self : TimeseriesanomalyzscoreGraphN) -> Int { self.size }

pub fn TimeseriesanomalyzscoreGraphN::get(self : TimeseriesanomalyzscoreGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyzscoreGraphN::set(self : TimeseriesanomalyzscoreGraphN, i : Int, v : Double) -> TimeseriesanomalyzscoreGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreGraphN::sum(self : TimeseriesanomalyzscoreGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyzscoreGraphN::mean(self : TimeseriesanomalyzscoreGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyzscoreGraphN::scale(self : TimeseriesanomalyzscoreGraphN, f : Double) -> TimeseriesanomalyzscoreGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreGraphN::add(self : TimeseriesanomalyzscoreGraphN, other : TimeseriesanomalyzscoreGraphN) -> TimeseriesanomalyzscoreGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreGraphN::copy(self : TimeseriesanomalyzscoreGraphN) -> TimeseriesanomalyzscoreGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreGraphN::fill(self : TimeseriesanomalyzscoreGraphN, v : Double) -> TimeseriesanomalyzscoreGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreGraphN::min(self : TimeseriesanomalyzscoreGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyzscoreGraphN::max(self : TimeseriesanomalyzscoreGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyzscoreGraphN::to_string(self : TimeseriesanomalyzscoreGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_node_make(size : Int) -> TimeseriesanomalyzscoreNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyzscoreNode::len(self : TimeseriesanomalyzscoreNode) -> Int { self.size }

pub fn TimeseriesanomalyzscoreNode::get(self : TimeseriesanomalyzscoreNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyzscoreNode::set(self : TimeseriesanomalyzscoreNode, i : Int, v : Double) -> TimeseriesanomalyzscoreNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreNode::sum(self : TimeseriesanomalyzscoreNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyzscoreNode::mean(self : TimeseriesanomalyzscoreNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyzscoreNode::scale(self : TimeseriesanomalyzscoreNode, f : Double) -> TimeseriesanomalyzscoreNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreNode::add(self : TimeseriesanomalyzscoreNode, other : TimeseriesanomalyzscoreNode) -> TimeseriesanomalyzscoreNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreNode::copy(self : TimeseriesanomalyzscoreNode) -> TimeseriesanomalyzscoreNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreNode::fill(self : TimeseriesanomalyzscoreNode, v : Double) -> TimeseriesanomalyzscoreNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreNode::min(self : TimeseriesanomalyzscoreNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyzscoreNode::max(self : TimeseriesanomalyzscoreNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyzscoreNode::to_string(self : TimeseriesanomalyzscoreNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_edge_make(size : Int) -> TimeseriesanomalyzscoreEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyzscoreEdge::len(self : TimeseriesanomalyzscoreEdge) -> Int { self.size }

pub fn TimeseriesanomalyzscoreEdge::get(self : TimeseriesanomalyzscoreEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyzscoreEdge::set(self : TimeseriesanomalyzscoreEdge, i : Int, v : Double) -> TimeseriesanomalyzscoreEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreEdge::sum(self : TimeseriesanomalyzscoreEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyzscoreEdge::mean(self : TimeseriesanomalyzscoreEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyzscoreEdge::scale(self : TimeseriesanomalyzscoreEdge, f : Double) -> TimeseriesanomalyzscoreEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreEdge::add(self : TimeseriesanomalyzscoreEdge, other : TimeseriesanomalyzscoreEdge) -> TimeseriesanomalyzscoreEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreEdge::copy(self : TimeseriesanomalyzscoreEdge) -> TimeseriesanomalyzscoreEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreEdge::fill(self : TimeseriesanomalyzscoreEdge, v : Double) -> TimeseriesanomalyzscoreEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreEdge::min(self : TimeseriesanomalyzscoreEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyzscoreEdge::max(self : TimeseriesanomalyzscoreEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyzscoreEdge::to_string(self : TimeseriesanomalyzscoreEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscorePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_path_make(size : Int) -> TimeseriesanomalyzscorePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyzscorePath::len(self : TimeseriesanomalyzscorePath) -> Int { self.size }

pub fn TimeseriesanomalyzscorePath::get(self : TimeseriesanomalyzscorePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyzscorePath::set(self : TimeseriesanomalyzscorePath, i : Int, v : Double) -> TimeseriesanomalyzscorePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscorePath::sum(self : TimeseriesanomalyzscorePath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyzscorePath::mean(self : TimeseriesanomalyzscorePath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyzscorePath::scale(self : TimeseriesanomalyzscorePath, f : Double) -> TimeseriesanomalyzscorePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscorePath::add(self : TimeseriesanomalyzscorePath, other : TimeseriesanomalyzscorePath) -> TimeseriesanomalyzscorePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyzscorePath::copy(self : TimeseriesanomalyzscorePath) -> TimeseriesanomalyzscorePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscorePath::fill(self : TimeseriesanomalyzscorePath, v : Double) -> TimeseriesanomalyzscorePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscorePath::min(self : TimeseriesanomalyzscorePath) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyzscorePath::max(self : TimeseriesanomalyzscorePath) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyzscorePath::to_string(self : TimeseriesanomalyzscorePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_cluster_make(size : Int) -> TimeseriesanomalyzscoreCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyzscoreCluster::len(self : TimeseriesanomalyzscoreCluster) -> Int { self.size }

pub fn TimeseriesanomalyzscoreCluster::get(self : TimeseriesanomalyzscoreCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyzscoreCluster::set(self : TimeseriesanomalyzscoreCluster, i : Int, v : Double) -> TimeseriesanomalyzscoreCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreCluster::sum(self : TimeseriesanomalyzscoreCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyzscoreCluster::mean(self : TimeseriesanomalyzscoreCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyzscoreCluster::scale(self : TimeseriesanomalyzscoreCluster, f : Double) -> TimeseriesanomalyzscoreCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreCluster::add(self : TimeseriesanomalyzscoreCluster, other : TimeseriesanomalyzscoreCluster) -> TimeseriesanomalyzscoreCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreCluster::copy(self : TimeseriesanomalyzscoreCluster) -> TimeseriesanomalyzscoreCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreCluster::fill(self : TimeseriesanomalyzscoreCluster, v : Double) -> TimeseriesanomalyzscoreCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreCluster::min(self : TimeseriesanomalyzscoreCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyzscoreCluster::max(self : TimeseriesanomalyzscoreCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyzscoreCluster::to_string(self : TimeseriesanomalyzscoreCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_model_make(size : Int) -> TimeseriesanomalyzscoreModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyzscoreModel::len(self : TimeseriesanomalyzscoreModel) -> Int { self.size }

pub fn TimeseriesanomalyzscoreModel::get(self : TimeseriesanomalyzscoreModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyzscoreModel::set(self : TimeseriesanomalyzscoreModel, i : Int, v : Double) -> TimeseriesanomalyzscoreModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreModel::sum(self : TimeseriesanomalyzscoreModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyzscoreModel::mean(self : TimeseriesanomalyzscoreModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyzscoreModel::scale(self : TimeseriesanomalyzscoreModel, f : Double) -> TimeseriesanomalyzscoreModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreModel::add(self : TimeseriesanomalyzscoreModel, other : TimeseriesanomalyzscoreModel) -> TimeseriesanomalyzscoreModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreModel::copy(self : TimeseriesanomalyzscoreModel) -> TimeseriesanomalyzscoreModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreModel::fill(self : TimeseriesanomalyzscoreModel, v : Double) -> TimeseriesanomalyzscoreModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreModel::min(self : TimeseriesanomalyzscoreModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyzscoreModel::max(self : TimeseriesanomalyzscoreModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyzscoreModel::to_string(self : TimeseriesanomalyzscoreModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_layer_make(size : Int) -> TimeseriesanomalyzscoreLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyzscoreLayer::len(self : TimeseriesanomalyzscoreLayer) -> Int { self.size }

pub fn TimeseriesanomalyzscoreLayer::get(self : TimeseriesanomalyzscoreLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyzscoreLayer::set(self : TimeseriesanomalyzscoreLayer, i : Int, v : Double) -> TimeseriesanomalyzscoreLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreLayer::sum(self : TimeseriesanomalyzscoreLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyzscoreLayer::mean(self : TimeseriesanomalyzscoreLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyzscoreLayer::scale(self : TimeseriesanomalyzscoreLayer, f : Double) -> TimeseriesanomalyzscoreLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreLayer::add(self : TimeseriesanomalyzscoreLayer, other : TimeseriesanomalyzscoreLayer) -> TimeseriesanomalyzscoreLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreLayer::copy(self : TimeseriesanomalyzscoreLayer) -> TimeseriesanomalyzscoreLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreLayer::fill(self : TimeseriesanomalyzscoreLayer, v : Double) -> TimeseriesanomalyzscoreLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreLayer::min(self : TimeseriesanomalyzscoreLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyzscoreLayer::max(self : TimeseriesanomalyzscoreLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyzscoreLayer::to_string(self : TimeseriesanomalyzscoreLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_buffer_make(size : Int) -> TimeseriesanomalyzscoreBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyzscoreBuffer::len(self : TimeseriesanomalyzscoreBuffer) -> Int { self.size }

pub fn TimeseriesanomalyzscoreBuffer::get(self : TimeseriesanomalyzscoreBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyzscoreBuffer::set(self : TimeseriesanomalyzscoreBuffer, i : Int, v : Double) -> TimeseriesanomalyzscoreBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreBuffer::sum(self : TimeseriesanomalyzscoreBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyzscoreBuffer::mean(self : TimeseriesanomalyzscoreBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyzscoreBuffer::scale(self : TimeseriesanomalyzscoreBuffer, f : Double) -> TimeseriesanomalyzscoreBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreBuffer::add(self : TimeseriesanomalyzscoreBuffer, other : TimeseriesanomalyzscoreBuffer) -> TimeseriesanomalyzscoreBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreBuffer::copy(self : TimeseriesanomalyzscoreBuffer) -> TimeseriesanomalyzscoreBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreBuffer::fill(self : TimeseriesanomalyzscoreBuffer, v : Double) -> TimeseriesanomalyzscoreBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreBuffer::min(self : TimeseriesanomalyzscoreBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyzscoreBuffer::max(self : TimeseriesanomalyzscoreBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyzscoreBuffer::to_string(self : TimeseriesanomalyzscoreBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_cursor_make(size : Int) -> TimeseriesanomalyzscoreCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyzscoreCursor::len(self : TimeseriesanomalyzscoreCursor) -> Int { self.size }

pub fn TimeseriesanomalyzscoreCursor::get(self : TimeseriesanomalyzscoreCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyzscoreCursor::set(self : TimeseriesanomalyzscoreCursor, i : Int, v : Double) -> TimeseriesanomalyzscoreCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreCursor::sum(self : TimeseriesanomalyzscoreCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyzscoreCursor::mean(self : TimeseriesanomalyzscoreCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyzscoreCursor::scale(self : TimeseriesanomalyzscoreCursor, f : Double) -> TimeseriesanomalyzscoreCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreCursor::add(self : TimeseriesanomalyzscoreCursor, other : TimeseriesanomalyzscoreCursor) -> TimeseriesanomalyzscoreCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreCursor::copy(self : TimeseriesanomalyzscoreCursor) -> TimeseriesanomalyzscoreCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreCursor::fill(self : TimeseriesanomalyzscoreCursor, v : Double) -> TimeseriesanomalyzscoreCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreCursor::min(self : TimeseriesanomalyzscoreCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyzscoreCursor::max(self : TimeseriesanomalyzscoreCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyzscoreCursor::to_string(self : TimeseriesanomalyzscoreCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_view_make(size : Int) -> TimeseriesanomalyzscoreView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyzscoreView::len(self : TimeseriesanomalyzscoreView) -> Int { self.size }

pub fn TimeseriesanomalyzscoreView::get(self : TimeseriesanomalyzscoreView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyzscoreView::set(self : TimeseriesanomalyzscoreView, i : Int, v : Double) -> TimeseriesanomalyzscoreView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreView::sum(self : TimeseriesanomalyzscoreView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyzscoreView::mean(self : TimeseriesanomalyzscoreView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyzscoreView::scale(self : TimeseriesanomalyzscoreView, f : Double) -> TimeseriesanomalyzscoreView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreView::add(self : TimeseriesanomalyzscoreView, other : TimeseriesanomalyzscoreView) -> TimeseriesanomalyzscoreView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreView::copy(self : TimeseriesanomalyzscoreView) -> TimeseriesanomalyzscoreView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreView::fill(self : TimeseriesanomalyzscoreView, v : Double) -> TimeseriesanomalyzscoreView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreView::min(self : TimeseriesanomalyzscoreView) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyzscoreView::max(self : TimeseriesanomalyzscoreView) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyzscoreView::to_string(self : TimeseriesanomalyzscoreView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_range_make(size : Int) -> TimeseriesanomalyzscoreRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyzscoreRange::len(self : TimeseriesanomalyzscoreRange) -> Int { self.size }

pub fn TimeseriesanomalyzscoreRange::get(self : TimeseriesanomalyzscoreRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyzscoreRange::set(self : TimeseriesanomalyzscoreRange, i : Int, v : Double) -> TimeseriesanomalyzscoreRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreRange::sum(self : TimeseriesanomalyzscoreRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyzscoreRange::mean(self : TimeseriesanomalyzscoreRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyzscoreRange::scale(self : TimeseriesanomalyzscoreRange, f : Double) -> TimeseriesanomalyzscoreRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreRange::add(self : TimeseriesanomalyzscoreRange, other : TimeseriesanomalyzscoreRange) -> TimeseriesanomalyzscoreRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreRange::copy(self : TimeseriesanomalyzscoreRange) -> TimeseriesanomalyzscoreRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreRange::fill(self : TimeseriesanomalyzscoreRange, v : Double) -> TimeseriesanomalyzscoreRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreRange::min(self : TimeseriesanomalyzscoreRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyzscoreRange::max(self : TimeseriesanomalyzscoreRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyzscoreRange::to_string(self : TimeseriesanomalyzscoreRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_slice_make(size : Int) -> TimeseriesanomalyzscoreSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyzscoreSlice::len(self : TimeseriesanomalyzscoreSlice) -> Int { self.size }

pub fn TimeseriesanomalyzscoreSlice::get(self : TimeseriesanomalyzscoreSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyzscoreSlice::set(self : TimeseriesanomalyzscoreSlice, i : Int, v : Double) -> TimeseriesanomalyzscoreSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreSlice::sum(self : TimeseriesanomalyzscoreSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyzscoreSlice::mean(self : TimeseriesanomalyzscoreSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyzscoreSlice::scale(self : TimeseriesanomalyzscoreSlice, f : Double) -> TimeseriesanomalyzscoreSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreSlice::add(self : TimeseriesanomalyzscoreSlice, other : TimeseriesanomalyzscoreSlice) -> TimeseriesanomalyzscoreSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreSlice::copy(self : TimeseriesanomalyzscoreSlice) -> TimeseriesanomalyzscoreSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreSlice::fill(self : TimeseriesanomalyzscoreSlice, v : Double) -> TimeseriesanomalyzscoreSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyzscoreSlice::min(self : TimeseriesanomalyzscoreSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyzscoreSlice::max(self : TimeseriesanomalyzscoreSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyzscoreSlice::to_string(self : TimeseriesanomalyzscoreSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

