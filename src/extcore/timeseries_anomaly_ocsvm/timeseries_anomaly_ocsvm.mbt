///===
/// extcore/timeseries_anomaly_ocsvm

pub(all) struct TimeseriesanomalyocsvmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_ocsvm_make_point(x : Double, y : Double) -> TimeseriesanomalyocsvmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_ocsvm_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalyocsvmPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalyocsvmPoint::x(self : TimeseriesanomalyocsvmPoint) -> Double { self.x }

pub fn TimeseriesanomalyocsvmPoint::y(self : TimeseriesanomalyocsvmPoint) -> Double { self.y }

pub fn TimeseriesanomalyocsvmPoint::z(self : TimeseriesanomalyocsvmPoint) -> Double { self.z }

pub fn TimeseriesanomalyocsvmPoint::label(self : TimeseriesanomalyocsvmPoint) -> Int { self.label }

pub fn TimeseriesanomalyocsvmPoint::dist(self : TimeseriesanomalyocsvmPoint, other : TimeseriesanomalyocsvmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalyocsvmPoint::add(self : TimeseriesanomalyocsvmPoint, other : TimeseriesanomalyocsvmPoint) -> TimeseriesanomalyocsvmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalyocsvmPoint::sub(self : TimeseriesanomalyocsvmPoint, other : TimeseriesanomalyocsvmPoint) -> TimeseriesanomalyocsvmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalyocsvmPoint::scale(self : TimeseriesanomalyocsvmPoint, s : Double) -> TimeseriesanomalyocsvmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalyocsvmPoint::dot(self : TimeseriesanomalyocsvmPoint, other : TimeseriesanomalyocsvmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalyocsvmPoint::cross(self : TimeseriesanomalyocsvmPoint, other : TimeseriesanomalyocsvmPoint) -> TimeseriesanomalyocsvmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalyocsvmPoint::norm(self : TimeseriesanomalyocsvmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalyocsvmPoint::normalize(self : TimeseriesanomalyocsvmPoint) -> TimeseriesanomalyocsvmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyocsvmPoint::negate(self : TimeseriesanomalyocsvmPoint) -> TimeseriesanomalyocsvmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalyocsvmPoint::mid(self : TimeseriesanomalyocsvmPoint, other : TimeseriesanomalyocsvmPoint) -> TimeseriesanomalyocsvmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalyocsvmPoint::lerp(self : TimeseriesanomalyocsvmPoint, other : TimeseriesanomalyocsvmPoint, t : Double) -> TimeseriesanomalyocsvmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalyocsvmPoint::to_string(self : TimeseriesanomalyocsvmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_ocsvm_make_series(vals : Array[Double], name : String) -> TimeseriesanomalyocsvmSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalyocsvmSeries::len(self : TimeseriesanomalyocsvmSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalyocsvmSeries::sum(self : TimeseriesanomalyocsvmSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalyocsvmSeries::mean(self : TimeseriesanomalyocsvmSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalyocsvmSeries::min(self : TimeseriesanomalyocsvmSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalyocsvmSeries::max(self : TimeseriesanomalyocsvmSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalyocsvmSeries::range(self : TimeseriesanomalyocsvmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalyocsvmSeries::variance(self : TimeseriesanomalyocsvmSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalyocsvmSeries::std(self : TimeseriesanomalyocsvmSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalyocsvmSeries::median(self : TimeseriesanomalyocsvmSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalyocsvmSeries::scale(self : TimeseriesanomalyocsvmSeries, f : Double) -> TimeseriesanomalyocsvmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalyocsvmSeries::add(self : TimeseriesanomalyocsvmSeries, other : TimeseriesanomalyocsvmSeries) -> TimeseriesanomalyocsvmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyocsvmSeries::sub(self : TimeseriesanomalyocsvmSeries, other : TimeseriesanomalyocsvmSeries) -> TimeseriesanomalyocsvmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyocsvmSeries::normalize(self : TimeseriesanomalyocsvmSeries) -> TimeseriesanomalyocsvmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalyocsvmSeries::cumsum(self : TimeseriesanomalyocsvmSeries) -> TimeseriesanomalyocsvmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalyocsvmSeries::to_string(self : TimeseriesanomalyocsvmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyocsvmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_ocsvm_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalyocsvmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_ocsvm_matrix_identity(n : Int) -> TimeseriesanomalyocsvmMatrix {
  let m = timeseries_anomaly_ocsvm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalyocsvmMatrix::get(self : TimeseriesanomalyocsvmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalyocsvmMatrix::transpose(self : TimeseriesanomalyocsvmMatrix) -> TimeseriesanomalyocsvmMatrix {
  let result = timeseries_anomaly_ocsvm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalyocsvmMatrix::add(self : TimeseriesanomalyocsvmMatrix, other : TimeseriesanomalyocsvmMatrix) -> TimeseriesanomalyocsvmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_ocsvm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalyocsvmMatrix::scale(self : TimeseriesanomalyocsvmMatrix, s : Double) -> TimeseriesanomalyocsvmMatrix {
  let result = timeseries_anomaly_ocsvm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalyocsvmMatrix::multiply(self : TimeseriesanomalyocsvmMatrix, other : TimeseriesanomalyocsvmMatrix) -> TimeseriesanomalyocsvmMatrix {
  if self.cols != other.rows { return timeseries_anomaly_ocsvm_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_ocsvm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesanomalyocsvmMatrix::trace(self : TimeseriesanomalyocsvmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalyocsvmMatrix::det(self : TimeseriesanomalyocsvmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalyocsvmMatrix::norm(self : TimeseriesanomalyocsvmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalyocsvmMatrix::to_string(self : TimeseriesanomalyocsvmMatrix) -> String {
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

pub(all) struct TimeseriesanomalyocsvmVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_ocsvm_make_vector(comps : Array[Double]) -> TimeseriesanomalyocsvmVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_ocsvm_vector_zero(dim : Int) -> TimeseriesanomalyocsvmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalyocsvmVector::add(self : TimeseriesanomalyocsvmVector, other : TimeseriesanomalyocsvmVector) -> TimeseriesanomalyocsvmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyocsvmVector::sub(self : TimeseriesanomalyocsvmVector, other : TimeseriesanomalyocsvmVector) -> TimeseriesanomalyocsvmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyocsvmVector::scale(self : TimeseriesanomalyocsvmVector, s : Double) -> TimeseriesanomalyocsvmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalyocsvmVector::dot(self : TimeseriesanomalyocsvmVector, other : TimeseriesanomalyocsvmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalyocsvmVector::norm(self : TimeseriesanomalyocsvmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalyocsvmVector::normalize(self : TimeseriesanomalyocsvmVector) -> TimeseriesanomalyocsvmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyocsvmVector::dist(self : TimeseriesanomalyocsvmVector, other : TimeseriesanomalyocsvmVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalyocsvmVector::to_string(self : TimeseriesanomalyocsvmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyocsvmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_frame_make(size : Int) -> TimeseriesanomalyocsvmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyocsvmFrame::len(self : TimeseriesanomalyocsvmFrame) -> Int { self.size }

pub fn TimeseriesanomalyocsvmFrame::get(self : TimeseriesanomalyocsvmFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyocsvmFrame::set(self : TimeseriesanomalyocsvmFrame, i : Int, v : Double) -> TimeseriesanomalyocsvmFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmFrame::sum(self : TimeseriesanomalyocsvmFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyocsvmFrame::mean(self : TimeseriesanomalyocsvmFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyocsvmFrame::scale(self : TimeseriesanomalyocsvmFrame, f : Double) -> TimeseriesanomalyocsvmFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmFrame::add(self : TimeseriesanomalyocsvmFrame, other : TimeseriesanomalyocsvmFrame) -> TimeseriesanomalyocsvmFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmFrame::copy(self : TimeseriesanomalyocsvmFrame) -> TimeseriesanomalyocsvmFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmFrame::fill(self : TimeseriesanomalyocsvmFrame, v : Double) -> TimeseriesanomalyocsvmFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmFrame::min(self : TimeseriesanomalyocsvmFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyocsvmFrame::max(self : TimeseriesanomalyocsvmFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyocsvmFrame::to_string(self : TimeseriesanomalyocsvmFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_table_make(size : Int) -> TimeseriesanomalyocsvmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyocsvmTable::len(self : TimeseriesanomalyocsvmTable) -> Int { self.size }

pub fn TimeseriesanomalyocsvmTable::get(self : TimeseriesanomalyocsvmTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyocsvmTable::set(self : TimeseriesanomalyocsvmTable, i : Int, v : Double) -> TimeseriesanomalyocsvmTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmTable::sum(self : TimeseriesanomalyocsvmTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyocsvmTable::mean(self : TimeseriesanomalyocsvmTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyocsvmTable::scale(self : TimeseriesanomalyocsvmTable, f : Double) -> TimeseriesanomalyocsvmTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmTable::add(self : TimeseriesanomalyocsvmTable, other : TimeseriesanomalyocsvmTable) -> TimeseriesanomalyocsvmTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmTable::copy(self : TimeseriesanomalyocsvmTable) -> TimeseriesanomalyocsvmTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmTable::fill(self : TimeseriesanomalyocsvmTable, v : Double) -> TimeseriesanomalyocsvmTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmTable::min(self : TimeseriesanomalyocsvmTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyocsvmTable::max(self : TimeseriesanomalyocsvmTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyocsvmTable::to_string(self : TimeseriesanomalyocsvmTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_graphn_make(size : Int) -> TimeseriesanomalyocsvmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyocsvmGraphN::len(self : TimeseriesanomalyocsvmGraphN) -> Int { self.size }

pub fn TimeseriesanomalyocsvmGraphN::get(self : TimeseriesanomalyocsvmGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyocsvmGraphN::set(self : TimeseriesanomalyocsvmGraphN, i : Int, v : Double) -> TimeseriesanomalyocsvmGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmGraphN::sum(self : TimeseriesanomalyocsvmGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyocsvmGraphN::mean(self : TimeseriesanomalyocsvmGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyocsvmGraphN::scale(self : TimeseriesanomalyocsvmGraphN, f : Double) -> TimeseriesanomalyocsvmGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmGraphN::add(self : TimeseriesanomalyocsvmGraphN, other : TimeseriesanomalyocsvmGraphN) -> TimeseriesanomalyocsvmGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmGraphN::copy(self : TimeseriesanomalyocsvmGraphN) -> TimeseriesanomalyocsvmGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmGraphN::fill(self : TimeseriesanomalyocsvmGraphN, v : Double) -> TimeseriesanomalyocsvmGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmGraphN::min(self : TimeseriesanomalyocsvmGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyocsvmGraphN::max(self : TimeseriesanomalyocsvmGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyocsvmGraphN::to_string(self : TimeseriesanomalyocsvmGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_node_make(size : Int) -> TimeseriesanomalyocsvmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyocsvmNode::len(self : TimeseriesanomalyocsvmNode) -> Int { self.size }

pub fn TimeseriesanomalyocsvmNode::get(self : TimeseriesanomalyocsvmNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyocsvmNode::set(self : TimeseriesanomalyocsvmNode, i : Int, v : Double) -> TimeseriesanomalyocsvmNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmNode::sum(self : TimeseriesanomalyocsvmNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyocsvmNode::mean(self : TimeseriesanomalyocsvmNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyocsvmNode::scale(self : TimeseriesanomalyocsvmNode, f : Double) -> TimeseriesanomalyocsvmNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmNode::add(self : TimeseriesanomalyocsvmNode, other : TimeseriesanomalyocsvmNode) -> TimeseriesanomalyocsvmNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmNode::copy(self : TimeseriesanomalyocsvmNode) -> TimeseriesanomalyocsvmNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmNode::fill(self : TimeseriesanomalyocsvmNode, v : Double) -> TimeseriesanomalyocsvmNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmNode::min(self : TimeseriesanomalyocsvmNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyocsvmNode::max(self : TimeseriesanomalyocsvmNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyocsvmNode::to_string(self : TimeseriesanomalyocsvmNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_edge_make(size : Int) -> TimeseriesanomalyocsvmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyocsvmEdge::len(self : TimeseriesanomalyocsvmEdge) -> Int { self.size }

pub fn TimeseriesanomalyocsvmEdge::get(self : TimeseriesanomalyocsvmEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyocsvmEdge::set(self : TimeseriesanomalyocsvmEdge, i : Int, v : Double) -> TimeseriesanomalyocsvmEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmEdge::sum(self : TimeseriesanomalyocsvmEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyocsvmEdge::mean(self : TimeseriesanomalyocsvmEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyocsvmEdge::scale(self : TimeseriesanomalyocsvmEdge, f : Double) -> TimeseriesanomalyocsvmEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmEdge::add(self : TimeseriesanomalyocsvmEdge, other : TimeseriesanomalyocsvmEdge) -> TimeseriesanomalyocsvmEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmEdge::copy(self : TimeseriesanomalyocsvmEdge) -> TimeseriesanomalyocsvmEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmEdge::fill(self : TimeseriesanomalyocsvmEdge, v : Double) -> TimeseriesanomalyocsvmEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmEdge::min(self : TimeseriesanomalyocsvmEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyocsvmEdge::max(self : TimeseriesanomalyocsvmEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyocsvmEdge::to_string(self : TimeseriesanomalyocsvmEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_path_make(size : Int) -> TimeseriesanomalyocsvmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyocsvmPath::len(self : TimeseriesanomalyocsvmPath) -> Int { self.size }

pub fn TimeseriesanomalyocsvmPath::get(self : TimeseriesanomalyocsvmPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyocsvmPath::set(self : TimeseriesanomalyocsvmPath, i : Int, v : Double) -> TimeseriesanomalyocsvmPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmPath::sum(self : TimeseriesanomalyocsvmPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyocsvmPath::mean(self : TimeseriesanomalyocsvmPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyocsvmPath::scale(self : TimeseriesanomalyocsvmPath, f : Double) -> TimeseriesanomalyocsvmPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmPath::add(self : TimeseriesanomalyocsvmPath, other : TimeseriesanomalyocsvmPath) -> TimeseriesanomalyocsvmPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmPath::copy(self : TimeseriesanomalyocsvmPath) -> TimeseriesanomalyocsvmPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmPath::fill(self : TimeseriesanomalyocsvmPath, v : Double) -> TimeseriesanomalyocsvmPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmPath::min(self : TimeseriesanomalyocsvmPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyocsvmPath::max(self : TimeseriesanomalyocsvmPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyocsvmPath::to_string(self : TimeseriesanomalyocsvmPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_cluster_make(size : Int) -> TimeseriesanomalyocsvmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyocsvmCluster::len(self : TimeseriesanomalyocsvmCluster) -> Int { self.size }

pub fn TimeseriesanomalyocsvmCluster::get(self : TimeseriesanomalyocsvmCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyocsvmCluster::set(self : TimeseriesanomalyocsvmCluster, i : Int, v : Double) -> TimeseriesanomalyocsvmCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmCluster::sum(self : TimeseriesanomalyocsvmCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyocsvmCluster::mean(self : TimeseriesanomalyocsvmCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyocsvmCluster::scale(self : TimeseriesanomalyocsvmCluster, f : Double) -> TimeseriesanomalyocsvmCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmCluster::add(self : TimeseriesanomalyocsvmCluster, other : TimeseriesanomalyocsvmCluster) -> TimeseriesanomalyocsvmCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmCluster::copy(self : TimeseriesanomalyocsvmCluster) -> TimeseriesanomalyocsvmCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmCluster::fill(self : TimeseriesanomalyocsvmCluster, v : Double) -> TimeseriesanomalyocsvmCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmCluster::min(self : TimeseriesanomalyocsvmCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyocsvmCluster::max(self : TimeseriesanomalyocsvmCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyocsvmCluster::to_string(self : TimeseriesanomalyocsvmCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_model_make(size : Int) -> TimeseriesanomalyocsvmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyocsvmModel::len(self : TimeseriesanomalyocsvmModel) -> Int { self.size }

pub fn TimeseriesanomalyocsvmModel::get(self : TimeseriesanomalyocsvmModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyocsvmModel::set(self : TimeseriesanomalyocsvmModel, i : Int, v : Double) -> TimeseriesanomalyocsvmModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmModel::sum(self : TimeseriesanomalyocsvmModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyocsvmModel::mean(self : TimeseriesanomalyocsvmModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyocsvmModel::scale(self : TimeseriesanomalyocsvmModel, f : Double) -> TimeseriesanomalyocsvmModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmModel::add(self : TimeseriesanomalyocsvmModel, other : TimeseriesanomalyocsvmModel) -> TimeseriesanomalyocsvmModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmModel::copy(self : TimeseriesanomalyocsvmModel) -> TimeseriesanomalyocsvmModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmModel::fill(self : TimeseriesanomalyocsvmModel, v : Double) -> TimeseriesanomalyocsvmModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmModel::min(self : TimeseriesanomalyocsvmModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyocsvmModel::max(self : TimeseriesanomalyocsvmModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyocsvmModel::to_string(self : TimeseriesanomalyocsvmModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_layer_make(size : Int) -> TimeseriesanomalyocsvmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyocsvmLayer::len(self : TimeseriesanomalyocsvmLayer) -> Int { self.size }

pub fn TimeseriesanomalyocsvmLayer::get(self : TimeseriesanomalyocsvmLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyocsvmLayer::set(self : TimeseriesanomalyocsvmLayer, i : Int, v : Double) -> TimeseriesanomalyocsvmLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmLayer::sum(self : TimeseriesanomalyocsvmLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyocsvmLayer::mean(self : TimeseriesanomalyocsvmLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyocsvmLayer::scale(self : TimeseriesanomalyocsvmLayer, f : Double) -> TimeseriesanomalyocsvmLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmLayer::add(self : TimeseriesanomalyocsvmLayer, other : TimeseriesanomalyocsvmLayer) -> TimeseriesanomalyocsvmLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmLayer::copy(self : TimeseriesanomalyocsvmLayer) -> TimeseriesanomalyocsvmLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmLayer::fill(self : TimeseriesanomalyocsvmLayer, v : Double) -> TimeseriesanomalyocsvmLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmLayer::min(self : TimeseriesanomalyocsvmLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyocsvmLayer::max(self : TimeseriesanomalyocsvmLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyocsvmLayer::to_string(self : TimeseriesanomalyocsvmLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_buffer_make(size : Int) -> TimeseriesanomalyocsvmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyocsvmBuffer::len(self : TimeseriesanomalyocsvmBuffer) -> Int { self.size }

pub fn TimeseriesanomalyocsvmBuffer::get(self : TimeseriesanomalyocsvmBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyocsvmBuffer::set(self : TimeseriesanomalyocsvmBuffer, i : Int, v : Double) -> TimeseriesanomalyocsvmBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmBuffer::sum(self : TimeseriesanomalyocsvmBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyocsvmBuffer::mean(self : TimeseriesanomalyocsvmBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyocsvmBuffer::scale(self : TimeseriesanomalyocsvmBuffer, f : Double) -> TimeseriesanomalyocsvmBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmBuffer::add(self : TimeseriesanomalyocsvmBuffer, other : TimeseriesanomalyocsvmBuffer) -> TimeseriesanomalyocsvmBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmBuffer::copy(self : TimeseriesanomalyocsvmBuffer) -> TimeseriesanomalyocsvmBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmBuffer::fill(self : TimeseriesanomalyocsvmBuffer, v : Double) -> TimeseriesanomalyocsvmBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmBuffer::min(self : TimeseriesanomalyocsvmBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyocsvmBuffer::max(self : TimeseriesanomalyocsvmBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyocsvmBuffer::to_string(self : TimeseriesanomalyocsvmBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_cursor_make(size : Int) -> TimeseriesanomalyocsvmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyocsvmCursor::len(self : TimeseriesanomalyocsvmCursor) -> Int { self.size }

pub fn TimeseriesanomalyocsvmCursor::get(self : TimeseriesanomalyocsvmCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyocsvmCursor::set(self : TimeseriesanomalyocsvmCursor, i : Int, v : Double) -> TimeseriesanomalyocsvmCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmCursor::sum(self : TimeseriesanomalyocsvmCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyocsvmCursor::mean(self : TimeseriesanomalyocsvmCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyocsvmCursor::scale(self : TimeseriesanomalyocsvmCursor, f : Double) -> TimeseriesanomalyocsvmCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmCursor::add(self : TimeseriesanomalyocsvmCursor, other : TimeseriesanomalyocsvmCursor) -> TimeseriesanomalyocsvmCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmCursor::copy(self : TimeseriesanomalyocsvmCursor) -> TimeseriesanomalyocsvmCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmCursor::fill(self : TimeseriesanomalyocsvmCursor, v : Double) -> TimeseriesanomalyocsvmCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmCursor::min(self : TimeseriesanomalyocsvmCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyocsvmCursor::max(self : TimeseriesanomalyocsvmCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyocsvmCursor::to_string(self : TimeseriesanomalyocsvmCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_view_make(size : Int) -> TimeseriesanomalyocsvmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyocsvmView::len(self : TimeseriesanomalyocsvmView) -> Int { self.size }

pub fn TimeseriesanomalyocsvmView::get(self : TimeseriesanomalyocsvmView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyocsvmView::set(self : TimeseriesanomalyocsvmView, i : Int, v : Double) -> TimeseriesanomalyocsvmView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmView::sum(self : TimeseriesanomalyocsvmView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyocsvmView::mean(self : TimeseriesanomalyocsvmView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyocsvmView::scale(self : TimeseriesanomalyocsvmView, f : Double) -> TimeseriesanomalyocsvmView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmView::add(self : TimeseriesanomalyocsvmView, other : TimeseriesanomalyocsvmView) -> TimeseriesanomalyocsvmView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmView::copy(self : TimeseriesanomalyocsvmView) -> TimeseriesanomalyocsvmView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmView::fill(self : TimeseriesanomalyocsvmView, v : Double) -> TimeseriesanomalyocsvmView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmView::min(self : TimeseriesanomalyocsvmView) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyocsvmView::max(self : TimeseriesanomalyocsvmView) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyocsvmView::to_string(self : TimeseriesanomalyocsvmView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_range_make(size : Int) -> TimeseriesanomalyocsvmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyocsvmRange::len(self : TimeseriesanomalyocsvmRange) -> Int { self.size }

pub fn TimeseriesanomalyocsvmRange::get(self : TimeseriesanomalyocsvmRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyocsvmRange::set(self : TimeseriesanomalyocsvmRange, i : Int, v : Double) -> TimeseriesanomalyocsvmRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmRange::sum(self : TimeseriesanomalyocsvmRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyocsvmRange::mean(self : TimeseriesanomalyocsvmRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyocsvmRange::scale(self : TimeseriesanomalyocsvmRange, f : Double) -> TimeseriesanomalyocsvmRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmRange::add(self : TimeseriesanomalyocsvmRange, other : TimeseriesanomalyocsvmRange) -> TimeseriesanomalyocsvmRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmRange::copy(self : TimeseriesanomalyocsvmRange) -> TimeseriesanomalyocsvmRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmRange::fill(self : TimeseriesanomalyocsvmRange, v : Double) -> TimeseriesanomalyocsvmRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmRange::min(self : TimeseriesanomalyocsvmRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyocsvmRange::max(self : TimeseriesanomalyocsvmRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyocsvmRange::to_string(self : TimeseriesanomalyocsvmRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_slice_make(size : Int) -> TimeseriesanomalyocsvmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyocsvmSlice::len(self : TimeseriesanomalyocsvmSlice) -> Int { self.size }

pub fn TimeseriesanomalyocsvmSlice::get(self : TimeseriesanomalyocsvmSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyocsvmSlice::set(self : TimeseriesanomalyocsvmSlice, i : Int, v : Double) -> TimeseriesanomalyocsvmSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmSlice::sum(self : TimeseriesanomalyocsvmSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyocsvmSlice::mean(self : TimeseriesanomalyocsvmSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyocsvmSlice::scale(self : TimeseriesanomalyocsvmSlice, f : Double) -> TimeseriesanomalyocsvmSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmSlice::add(self : TimeseriesanomalyocsvmSlice, other : TimeseriesanomalyocsvmSlice) -> TimeseriesanomalyocsvmSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmSlice::copy(self : TimeseriesanomalyocsvmSlice) -> TimeseriesanomalyocsvmSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmSlice::fill(self : TimeseriesanomalyocsvmSlice, v : Double) -> TimeseriesanomalyocsvmSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyocsvmSlice::min(self : TimeseriesanomalyocsvmSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyocsvmSlice::max(self : TimeseriesanomalyocsvmSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyocsvmSlice::to_string(self : TimeseriesanomalyocsvmSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

