///===
/// extcore/timeseries_anomaly_isolation

pub(all) struct TimeseriesanomalyisolationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_isolation_make_point(x : Double, y : Double) -> TimeseriesanomalyisolationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_isolation_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalyisolationPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalyisolationPoint::x(self : TimeseriesanomalyisolationPoint) -> Double { self.x }

pub fn TimeseriesanomalyisolationPoint::y(self : TimeseriesanomalyisolationPoint) -> Double { self.y }

pub fn TimeseriesanomalyisolationPoint::z(self : TimeseriesanomalyisolationPoint) -> Double { self.z }

pub fn TimeseriesanomalyisolationPoint::label(self : TimeseriesanomalyisolationPoint) -> Int { self.label }

pub fn TimeseriesanomalyisolationPoint::dist(self : TimeseriesanomalyisolationPoint, other : TimeseriesanomalyisolationPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalyisolationPoint::add(self : TimeseriesanomalyisolationPoint, other : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalyisolationPoint::sub(self : TimeseriesanomalyisolationPoint, other : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalyisolationPoint::scale(self : TimeseriesanomalyisolationPoint, s : Double) -> TimeseriesanomalyisolationPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalyisolationPoint::dot(self : TimeseriesanomalyisolationPoint, other : TimeseriesanomalyisolationPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalyisolationPoint::cross(self : TimeseriesanomalyisolationPoint, other : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalyisolationPoint::norm(self : TimeseriesanomalyisolationPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalyisolationPoint::normalize(self : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyisolationPoint::negate(self : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalyisolationPoint::mid(self : TimeseriesanomalyisolationPoint, other : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalyisolationPoint::lerp(self : TimeseriesanomalyisolationPoint, other : TimeseriesanomalyisolationPoint, t : Double) -> TimeseriesanomalyisolationPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalyisolationPoint::to_string(self : TimeseriesanomalyisolationPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_isolation_make_series(vals : Array[Double], name : String) -> TimeseriesanomalyisolationSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalyisolationSeries::len(self : TimeseriesanomalyisolationSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalyisolationSeries::sum(self : TimeseriesanomalyisolationSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalyisolationSeries::mean(self : TimeseriesanomalyisolationSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalyisolationSeries::min(self : TimeseriesanomalyisolationSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalyisolationSeries::max(self : TimeseriesanomalyisolationSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalyisolationSeries::range(self : TimeseriesanomalyisolationSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalyisolationSeries::variance(self : TimeseriesanomalyisolationSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalyisolationSeries::std(self : TimeseriesanomalyisolationSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalyisolationSeries::median(self : TimeseriesanomalyisolationSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalyisolationSeries::scale(self : TimeseriesanomalyisolationSeries, f : Double) -> TimeseriesanomalyisolationSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalyisolationSeries::add(self : TimeseriesanomalyisolationSeries, other : TimeseriesanomalyisolationSeries) -> TimeseriesanomalyisolationSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyisolationSeries::sub(self : TimeseriesanomalyisolationSeries, other : TimeseriesanomalyisolationSeries) -> TimeseriesanomalyisolationSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyisolationSeries::normalize(self : TimeseriesanomalyisolationSeries) -> TimeseriesanomalyisolationSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalyisolationSeries::cumsum(self : TimeseriesanomalyisolationSeries) -> TimeseriesanomalyisolationSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalyisolationSeries::to_string(self : TimeseriesanomalyisolationSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyisolationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_isolation_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalyisolationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_isolation_matrix_identity(n : Int) -> TimeseriesanomalyisolationMatrix {
  let m = timeseries_anomaly_isolation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalyisolationMatrix::get(self : TimeseriesanomalyisolationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalyisolationMatrix::transpose(self : TimeseriesanomalyisolationMatrix) -> TimeseriesanomalyisolationMatrix {
  let result = timeseries_anomaly_isolation_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalyisolationMatrix::add(self : TimeseriesanomalyisolationMatrix, other : TimeseriesanomalyisolationMatrix) -> TimeseriesanomalyisolationMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_isolation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalyisolationMatrix::scale(self : TimeseriesanomalyisolationMatrix, s : Double) -> TimeseriesanomalyisolationMatrix {
  let result = timeseries_anomaly_isolation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalyisolationMatrix::multiply(self : TimeseriesanomalyisolationMatrix, other : TimeseriesanomalyisolationMatrix) -> TimeseriesanomalyisolationMatrix {
  if self.cols != other.rows { return timeseries_anomaly_isolation_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_isolation_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesanomalyisolationMatrix::trace(self : TimeseriesanomalyisolationMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalyisolationMatrix::det(self : TimeseriesanomalyisolationMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalyisolationMatrix::norm(self : TimeseriesanomalyisolationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalyisolationMatrix::to_string(self : TimeseriesanomalyisolationMatrix) -> String {
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

pub(all) struct TimeseriesanomalyisolationVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_isolation_make_vector(comps : Array[Double]) -> TimeseriesanomalyisolationVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_isolation_vector_zero(dim : Int) -> TimeseriesanomalyisolationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalyisolationVector::add(self : TimeseriesanomalyisolationVector, other : TimeseriesanomalyisolationVector) -> TimeseriesanomalyisolationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyisolationVector::sub(self : TimeseriesanomalyisolationVector, other : TimeseriesanomalyisolationVector) -> TimeseriesanomalyisolationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyisolationVector::scale(self : TimeseriesanomalyisolationVector, s : Double) -> TimeseriesanomalyisolationVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalyisolationVector::dot(self : TimeseriesanomalyisolationVector, other : TimeseriesanomalyisolationVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalyisolationVector::norm(self : TimeseriesanomalyisolationVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalyisolationVector::normalize(self : TimeseriesanomalyisolationVector) -> TimeseriesanomalyisolationVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyisolationVector::dist(self : TimeseriesanomalyisolationVector, other : TimeseriesanomalyisolationVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalyisolationVector::to_string(self : TimeseriesanomalyisolationVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyisolationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_frame_make(size : Int) -> TimeseriesanomalyisolationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyisolationFrame::len(self : TimeseriesanomalyisolationFrame) -> Int { self.size }

pub fn TimeseriesanomalyisolationFrame::get(self : TimeseriesanomalyisolationFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyisolationFrame::set(self : TimeseriesanomalyisolationFrame, i : Int, v : Double) -> TimeseriesanomalyisolationFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationFrame::sum(self : TimeseriesanomalyisolationFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyisolationFrame::mean(self : TimeseriesanomalyisolationFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyisolationFrame::scale(self : TimeseriesanomalyisolationFrame, f : Double) -> TimeseriesanomalyisolationFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationFrame::add(self : TimeseriesanomalyisolationFrame, other : TimeseriesanomalyisolationFrame) -> TimeseriesanomalyisolationFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyisolationFrame::copy(self : TimeseriesanomalyisolationFrame) -> TimeseriesanomalyisolationFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationFrame::fill(self : TimeseriesanomalyisolationFrame, v : Double) -> TimeseriesanomalyisolationFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationFrame::min(self : TimeseriesanomalyisolationFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyisolationFrame::max(self : TimeseriesanomalyisolationFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyisolationFrame::to_string(self : TimeseriesanomalyisolationFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_table_make(size : Int) -> TimeseriesanomalyisolationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyisolationTable::len(self : TimeseriesanomalyisolationTable) -> Int { self.size }

pub fn TimeseriesanomalyisolationTable::get(self : TimeseriesanomalyisolationTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyisolationTable::set(self : TimeseriesanomalyisolationTable, i : Int, v : Double) -> TimeseriesanomalyisolationTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationTable::sum(self : TimeseriesanomalyisolationTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyisolationTable::mean(self : TimeseriesanomalyisolationTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyisolationTable::scale(self : TimeseriesanomalyisolationTable, f : Double) -> TimeseriesanomalyisolationTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationTable::add(self : TimeseriesanomalyisolationTable, other : TimeseriesanomalyisolationTable) -> TimeseriesanomalyisolationTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyisolationTable::copy(self : TimeseriesanomalyisolationTable) -> TimeseriesanomalyisolationTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationTable::fill(self : TimeseriesanomalyisolationTable, v : Double) -> TimeseriesanomalyisolationTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationTable::min(self : TimeseriesanomalyisolationTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyisolationTable::max(self : TimeseriesanomalyisolationTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyisolationTable::to_string(self : TimeseriesanomalyisolationTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_graphn_make(size : Int) -> TimeseriesanomalyisolationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyisolationGraphN::len(self : TimeseriesanomalyisolationGraphN) -> Int { self.size }

pub fn TimeseriesanomalyisolationGraphN::get(self : TimeseriesanomalyisolationGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyisolationGraphN::set(self : TimeseriesanomalyisolationGraphN, i : Int, v : Double) -> TimeseriesanomalyisolationGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationGraphN::sum(self : TimeseriesanomalyisolationGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyisolationGraphN::mean(self : TimeseriesanomalyisolationGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyisolationGraphN::scale(self : TimeseriesanomalyisolationGraphN, f : Double) -> TimeseriesanomalyisolationGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationGraphN::add(self : TimeseriesanomalyisolationGraphN, other : TimeseriesanomalyisolationGraphN) -> TimeseriesanomalyisolationGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyisolationGraphN::copy(self : TimeseriesanomalyisolationGraphN) -> TimeseriesanomalyisolationGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationGraphN::fill(self : TimeseriesanomalyisolationGraphN, v : Double) -> TimeseriesanomalyisolationGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationGraphN::min(self : TimeseriesanomalyisolationGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyisolationGraphN::max(self : TimeseriesanomalyisolationGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyisolationGraphN::to_string(self : TimeseriesanomalyisolationGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_node_make(size : Int) -> TimeseriesanomalyisolationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyisolationNode::len(self : TimeseriesanomalyisolationNode) -> Int { self.size }

pub fn TimeseriesanomalyisolationNode::get(self : TimeseriesanomalyisolationNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyisolationNode::set(self : TimeseriesanomalyisolationNode, i : Int, v : Double) -> TimeseriesanomalyisolationNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationNode::sum(self : TimeseriesanomalyisolationNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyisolationNode::mean(self : TimeseriesanomalyisolationNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyisolationNode::scale(self : TimeseriesanomalyisolationNode, f : Double) -> TimeseriesanomalyisolationNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationNode::add(self : TimeseriesanomalyisolationNode, other : TimeseriesanomalyisolationNode) -> TimeseriesanomalyisolationNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyisolationNode::copy(self : TimeseriesanomalyisolationNode) -> TimeseriesanomalyisolationNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationNode::fill(self : TimeseriesanomalyisolationNode, v : Double) -> TimeseriesanomalyisolationNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationNode::min(self : TimeseriesanomalyisolationNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyisolationNode::max(self : TimeseriesanomalyisolationNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyisolationNode::to_string(self : TimeseriesanomalyisolationNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_edge_make(size : Int) -> TimeseriesanomalyisolationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyisolationEdge::len(self : TimeseriesanomalyisolationEdge) -> Int { self.size }

pub fn TimeseriesanomalyisolationEdge::get(self : TimeseriesanomalyisolationEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyisolationEdge::set(self : TimeseriesanomalyisolationEdge, i : Int, v : Double) -> TimeseriesanomalyisolationEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationEdge::sum(self : TimeseriesanomalyisolationEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyisolationEdge::mean(self : TimeseriesanomalyisolationEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyisolationEdge::scale(self : TimeseriesanomalyisolationEdge, f : Double) -> TimeseriesanomalyisolationEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationEdge::add(self : TimeseriesanomalyisolationEdge, other : TimeseriesanomalyisolationEdge) -> TimeseriesanomalyisolationEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyisolationEdge::copy(self : TimeseriesanomalyisolationEdge) -> TimeseriesanomalyisolationEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationEdge::fill(self : TimeseriesanomalyisolationEdge, v : Double) -> TimeseriesanomalyisolationEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationEdge::min(self : TimeseriesanomalyisolationEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyisolationEdge::max(self : TimeseriesanomalyisolationEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyisolationEdge::to_string(self : TimeseriesanomalyisolationEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_path_make(size : Int) -> TimeseriesanomalyisolationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyisolationPath::len(self : TimeseriesanomalyisolationPath) -> Int { self.size }

pub fn TimeseriesanomalyisolationPath::get(self : TimeseriesanomalyisolationPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyisolationPath::set(self : TimeseriesanomalyisolationPath, i : Int, v : Double) -> TimeseriesanomalyisolationPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationPath::sum(self : TimeseriesanomalyisolationPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyisolationPath::mean(self : TimeseriesanomalyisolationPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyisolationPath::scale(self : TimeseriesanomalyisolationPath, f : Double) -> TimeseriesanomalyisolationPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationPath::add(self : TimeseriesanomalyisolationPath, other : TimeseriesanomalyisolationPath) -> TimeseriesanomalyisolationPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyisolationPath::copy(self : TimeseriesanomalyisolationPath) -> TimeseriesanomalyisolationPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationPath::fill(self : TimeseriesanomalyisolationPath, v : Double) -> TimeseriesanomalyisolationPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationPath::min(self : TimeseriesanomalyisolationPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyisolationPath::max(self : TimeseriesanomalyisolationPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyisolationPath::to_string(self : TimeseriesanomalyisolationPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_cluster_make(size : Int) -> TimeseriesanomalyisolationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyisolationCluster::len(self : TimeseriesanomalyisolationCluster) -> Int { self.size }

pub fn TimeseriesanomalyisolationCluster::get(self : TimeseriesanomalyisolationCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyisolationCluster::set(self : TimeseriesanomalyisolationCluster, i : Int, v : Double) -> TimeseriesanomalyisolationCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationCluster::sum(self : TimeseriesanomalyisolationCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyisolationCluster::mean(self : TimeseriesanomalyisolationCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyisolationCluster::scale(self : TimeseriesanomalyisolationCluster, f : Double) -> TimeseriesanomalyisolationCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationCluster::add(self : TimeseriesanomalyisolationCluster, other : TimeseriesanomalyisolationCluster) -> TimeseriesanomalyisolationCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyisolationCluster::copy(self : TimeseriesanomalyisolationCluster) -> TimeseriesanomalyisolationCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationCluster::fill(self : TimeseriesanomalyisolationCluster, v : Double) -> TimeseriesanomalyisolationCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationCluster::min(self : TimeseriesanomalyisolationCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyisolationCluster::max(self : TimeseriesanomalyisolationCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyisolationCluster::to_string(self : TimeseriesanomalyisolationCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_model_make(size : Int) -> TimeseriesanomalyisolationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyisolationModel::len(self : TimeseriesanomalyisolationModel) -> Int { self.size }

pub fn TimeseriesanomalyisolationModel::get(self : TimeseriesanomalyisolationModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyisolationModel::set(self : TimeseriesanomalyisolationModel, i : Int, v : Double) -> TimeseriesanomalyisolationModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationModel::sum(self : TimeseriesanomalyisolationModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyisolationModel::mean(self : TimeseriesanomalyisolationModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyisolationModel::scale(self : TimeseriesanomalyisolationModel, f : Double) -> TimeseriesanomalyisolationModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationModel::add(self : TimeseriesanomalyisolationModel, other : TimeseriesanomalyisolationModel) -> TimeseriesanomalyisolationModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyisolationModel::copy(self : TimeseriesanomalyisolationModel) -> TimeseriesanomalyisolationModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationModel::fill(self : TimeseriesanomalyisolationModel, v : Double) -> TimeseriesanomalyisolationModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationModel::min(self : TimeseriesanomalyisolationModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyisolationModel::max(self : TimeseriesanomalyisolationModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyisolationModel::to_string(self : TimeseriesanomalyisolationModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_layer_make(size : Int) -> TimeseriesanomalyisolationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyisolationLayer::len(self : TimeseriesanomalyisolationLayer) -> Int { self.size }

pub fn TimeseriesanomalyisolationLayer::get(self : TimeseriesanomalyisolationLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyisolationLayer::set(self : TimeseriesanomalyisolationLayer, i : Int, v : Double) -> TimeseriesanomalyisolationLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationLayer::sum(self : TimeseriesanomalyisolationLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyisolationLayer::mean(self : TimeseriesanomalyisolationLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyisolationLayer::scale(self : TimeseriesanomalyisolationLayer, f : Double) -> TimeseriesanomalyisolationLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationLayer::add(self : TimeseriesanomalyisolationLayer, other : TimeseriesanomalyisolationLayer) -> TimeseriesanomalyisolationLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyisolationLayer::copy(self : TimeseriesanomalyisolationLayer) -> TimeseriesanomalyisolationLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationLayer::fill(self : TimeseriesanomalyisolationLayer, v : Double) -> TimeseriesanomalyisolationLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationLayer::min(self : TimeseriesanomalyisolationLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyisolationLayer::max(self : TimeseriesanomalyisolationLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyisolationLayer::to_string(self : TimeseriesanomalyisolationLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_buffer_make(size : Int) -> TimeseriesanomalyisolationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyisolationBuffer::len(self : TimeseriesanomalyisolationBuffer) -> Int { self.size }

pub fn TimeseriesanomalyisolationBuffer::get(self : TimeseriesanomalyisolationBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyisolationBuffer::set(self : TimeseriesanomalyisolationBuffer, i : Int, v : Double) -> TimeseriesanomalyisolationBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationBuffer::sum(self : TimeseriesanomalyisolationBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyisolationBuffer::mean(self : TimeseriesanomalyisolationBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyisolationBuffer::scale(self : TimeseriesanomalyisolationBuffer, f : Double) -> TimeseriesanomalyisolationBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationBuffer::add(self : TimeseriesanomalyisolationBuffer, other : TimeseriesanomalyisolationBuffer) -> TimeseriesanomalyisolationBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyisolationBuffer::copy(self : TimeseriesanomalyisolationBuffer) -> TimeseriesanomalyisolationBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationBuffer::fill(self : TimeseriesanomalyisolationBuffer, v : Double) -> TimeseriesanomalyisolationBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationBuffer::min(self : TimeseriesanomalyisolationBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyisolationBuffer::max(self : TimeseriesanomalyisolationBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyisolationBuffer::to_string(self : TimeseriesanomalyisolationBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_cursor_make(size : Int) -> TimeseriesanomalyisolationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyisolationCursor::len(self : TimeseriesanomalyisolationCursor) -> Int { self.size }

pub fn TimeseriesanomalyisolationCursor::get(self : TimeseriesanomalyisolationCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyisolationCursor::set(self : TimeseriesanomalyisolationCursor, i : Int, v : Double) -> TimeseriesanomalyisolationCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationCursor::sum(self : TimeseriesanomalyisolationCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyisolationCursor::mean(self : TimeseriesanomalyisolationCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyisolationCursor::scale(self : TimeseriesanomalyisolationCursor, f : Double) -> TimeseriesanomalyisolationCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationCursor::add(self : TimeseriesanomalyisolationCursor, other : TimeseriesanomalyisolationCursor) -> TimeseriesanomalyisolationCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyisolationCursor::copy(self : TimeseriesanomalyisolationCursor) -> TimeseriesanomalyisolationCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationCursor::fill(self : TimeseriesanomalyisolationCursor, v : Double) -> TimeseriesanomalyisolationCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationCursor::min(self : TimeseriesanomalyisolationCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyisolationCursor::max(self : TimeseriesanomalyisolationCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyisolationCursor::to_string(self : TimeseriesanomalyisolationCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_view_make(size : Int) -> TimeseriesanomalyisolationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyisolationView::len(self : TimeseriesanomalyisolationView) -> Int { self.size }

pub fn TimeseriesanomalyisolationView::get(self : TimeseriesanomalyisolationView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyisolationView::set(self : TimeseriesanomalyisolationView, i : Int, v : Double) -> TimeseriesanomalyisolationView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationView::sum(self : TimeseriesanomalyisolationView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyisolationView::mean(self : TimeseriesanomalyisolationView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyisolationView::scale(self : TimeseriesanomalyisolationView, f : Double) -> TimeseriesanomalyisolationView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationView::add(self : TimeseriesanomalyisolationView, other : TimeseriesanomalyisolationView) -> TimeseriesanomalyisolationView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyisolationView::copy(self : TimeseriesanomalyisolationView) -> TimeseriesanomalyisolationView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationView::fill(self : TimeseriesanomalyisolationView, v : Double) -> TimeseriesanomalyisolationView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationView::min(self : TimeseriesanomalyisolationView) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyisolationView::max(self : TimeseriesanomalyisolationView) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyisolationView::to_string(self : TimeseriesanomalyisolationView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_range_make(size : Int) -> TimeseriesanomalyisolationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyisolationRange::len(self : TimeseriesanomalyisolationRange) -> Int { self.size }

pub fn TimeseriesanomalyisolationRange::get(self : TimeseriesanomalyisolationRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyisolationRange::set(self : TimeseriesanomalyisolationRange, i : Int, v : Double) -> TimeseriesanomalyisolationRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationRange::sum(self : TimeseriesanomalyisolationRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyisolationRange::mean(self : TimeseriesanomalyisolationRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyisolationRange::scale(self : TimeseriesanomalyisolationRange, f : Double) -> TimeseriesanomalyisolationRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationRange::add(self : TimeseriesanomalyisolationRange, other : TimeseriesanomalyisolationRange) -> TimeseriesanomalyisolationRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyisolationRange::copy(self : TimeseriesanomalyisolationRange) -> TimeseriesanomalyisolationRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationRange::fill(self : TimeseriesanomalyisolationRange, v : Double) -> TimeseriesanomalyisolationRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationRange::min(self : TimeseriesanomalyisolationRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyisolationRange::max(self : TimeseriesanomalyisolationRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyisolationRange::to_string(self : TimeseriesanomalyisolationRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_slice_make(size : Int) -> TimeseriesanomalyisolationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyisolationSlice::len(self : TimeseriesanomalyisolationSlice) -> Int { self.size }

pub fn TimeseriesanomalyisolationSlice::get(self : TimeseriesanomalyisolationSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyisolationSlice::set(self : TimeseriesanomalyisolationSlice, i : Int, v : Double) -> TimeseriesanomalyisolationSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationSlice::sum(self : TimeseriesanomalyisolationSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyisolationSlice::mean(self : TimeseriesanomalyisolationSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyisolationSlice::scale(self : TimeseriesanomalyisolationSlice, f : Double) -> TimeseriesanomalyisolationSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationSlice::add(self : TimeseriesanomalyisolationSlice, other : TimeseriesanomalyisolationSlice) -> TimeseriesanomalyisolationSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyisolationSlice::copy(self : TimeseriesanomalyisolationSlice) -> TimeseriesanomalyisolationSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationSlice::fill(self : TimeseriesanomalyisolationSlice, v : Double) -> TimeseriesanomalyisolationSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyisolationSlice::min(self : TimeseriesanomalyisolationSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyisolationSlice::max(self : TimeseriesanomalyisolationSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyisolationSlice::to_string(self : TimeseriesanomalyisolationSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

