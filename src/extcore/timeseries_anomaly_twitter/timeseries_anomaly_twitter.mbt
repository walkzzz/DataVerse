///===
/// extcore/timeseries_anomaly_twitter

pub(all) struct TimeseriesanomalytwitterPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_twitter_make_point(x : Double, y : Double) -> TimeseriesanomalytwitterPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_twitter_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalytwitterPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalytwitterPoint::x(self : TimeseriesanomalytwitterPoint) -> Double { self.x }

pub fn TimeseriesanomalytwitterPoint::y(self : TimeseriesanomalytwitterPoint) -> Double { self.y }

pub fn TimeseriesanomalytwitterPoint::z(self : TimeseriesanomalytwitterPoint) -> Double { self.z }

pub fn TimeseriesanomalytwitterPoint::label(self : TimeseriesanomalytwitterPoint) -> Int { self.label }

pub fn TimeseriesanomalytwitterPoint::dist(self : TimeseriesanomalytwitterPoint, other : TimeseriesanomalytwitterPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalytwitterPoint::add(self : TimeseriesanomalytwitterPoint, other : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalytwitterPoint::sub(self : TimeseriesanomalytwitterPoint, other : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalytwitterPoint::scale(self : TimeseriesanomalytwitterPoint, s : Double) -> TimeseriesanomalytwitterPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalytwitterPoint::dot(self : TimeseriesanomalytwitterPoint, other : TimeseriesanomalytwitterPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalytwitterPoint::cross(self : TimeseriesanomalytwitterPoint, other : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalytwitterPoint::norm(self : TimeseriesanomalytwitterPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalytwitterPoint::normalize(self : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalytwitterPoint::negate(self : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalytwitterPoint::mid(self : TimeseriesanomalytwitterPoint, other : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalytwitterPoint::lerp(self : TimeseriesanomalytwitterPoint, other : TimeseriesanomalytwitterPoint, t : Double) -> TimeseriesanomalytwitterPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalytwitterPoint::to_string(self : TimeseriesanomalytwitterPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_twitter_make_series(vals : Array[Double], name : String) -> TimeseriesanomalytwitterSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalytwitterSeries::len(self : TimeseriesanomalytwitterSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalytwitterSeries::sum(self : TimeseriesanomalytwitterSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalytwitterSeries::mean(self : TimeseriesanomalytwitterSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalytwitterSeries::min(self : TimeseriesanomalytwitterSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalytwitterSeries::max(self : TimeseriesanomalytwitterSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalytwitterSeries::range(self : TimeseriesanomalytwitterSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalytwitterSeries::variance(self : TimeseriesanomalytwitterSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalytwitterSeries::std(self : TimeseriesanomalytwitterSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalytwitterSeries::median(self : TimeseriesanomalytwitterSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalytwitterSeries::scale(self : TimeseriesanomalytwitterSeries, f : Double) -> TimeseriesanomalytwitterSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalytwitterSeries::add(self : TimeseriesanomalytwitterSeries, other : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalytwitterSeries::sub(self : TimeseriesanomalytwitterSeries, other : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalytwitterSeries::normalize(self : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalytwitterSeries::cumsum(self : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalytwitterSeries::to_string(self : TimeseriesanomalytwitterSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalytwitterMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_twitter_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalytwitterMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_twitter_matrix_identity(n : Int) -> TimeseriesanomalytwitterMatrix {
  let m = timeseries_anomaly_twitter_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalytwitterMatrix::get(self : TimeseriesanomalytwitterMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalytwitterMatrix::transpose(self : TimeseriesanomalytwitterMatrix) -> TimeseriesanomalytwitterMatrix {
  let result = timeseries_anomaly_twitter_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalytwitterMatrix::add(self : TimeseriesanomalytwitterMatrix, other : TimeseriesanomalytwitterMatrix) -> TimeseriesanomalytwitterMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_twitter_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalytwitterMatrix::scale(self : TimeseriesanomalytwitterMatrix, s : Double) -> TimeseriesanomalytwitterMatrix {
  let result = timeseries_anomaly_twitter_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalytwitterMatrix::multiply(self : TimeseriesanomalytwitterMatrix, other : TimeseriesanomalytwitterMatrix) -> TimeseriesanomalytwitterMatrix {
  if self.cols != other.rows { return timeseries_anomaly_twitter_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_twitter_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn TimeseriesanomalytwitterMatrix::trace(self : TimeseriesanomalytwitterMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalytwitterMatrix::det(self : TimeseriesanomalytwitterMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalytwitterMatrix::norm(self : TimeseriesanomalytwitterMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalytwitterMatrix::to_string(self : TimeseriesanomalytwitterMatrix) -> String {
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

pub(all) struct TimeseriesanomalytwitterVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_twitter_make_vector(comps : Array[Double]) -> TimeseriesanomalytwitterVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_twitter_vector_zero(dim : Int) -> TimeseriesanomalytwitterVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalytwitterVector::add(self : TimeseriesanomalytwitterVector, other : TimeseriesanomalytwitterVector) -> TimeseriesanomalytwitterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalytwitterVector::sub(self : TimeseriesanomalytwitterVector, other : TimeseriesanomalytwitterVector) -> TimeseriesanomalytwitterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalytwitterVector::scale(self : TimeseriesanomalytwitterVector, s : Double) -> TimeseriesanomalytwitterVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalytwitterVector::dot(self : TimeseriesanomalytwitterVector, other : TimeseriesanomalytwitterVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalytwitterVector::norm(self : TimeseriesanomalytwitterVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalytwitterVector::normalize(self : TimeseriesanomalytwitterVector) -> TimeseriesanomalytwitterVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalytwitterVector::dist(self : TimeseriesanomalytwitterVector, other : TimeseriesanomalytwitterVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalytwitterVector::to_string(self : TimeseriesanomalytwitterVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalytwitterFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_frame_make(size : Int) -> TimeseriesanomalytwitterFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalytwitterFrame::len(self : TimeseriesanomalytwitterFrame) -> Int { self.size }

pub fn TimeseriesanomalytwitterFrame::get(self : TimeseriesanomalytwitterFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalytwitterFrame::set(self : TimeseriesanomalytwitterFrame, i : Int, v : Double) -> TimeseriesanomalytwitterFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterFrame::sum(self : TimeseriesanomalytwitterFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalytwitterFrame::mean(self : TimeseriesanomalytwitterFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalytwitterFrame::scale(self : TimeseriesanomalytwitterFrame, f : Double) -> TimeseriesanomalytwitterFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterFrame::add(self : TimeseriesanomalytwitterFrame, other : TimeseriesanomalytwitterFrame) -> TimeseriesanomalytwitterFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalytwitterFrame::copy(self : TimeseriesanomalytwitterFrame) -> TimeseriesanomalytwitterFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterFrame::fill(self : TimeseriesanomalytwitterFrame, v : Double) -> TimeseriesanomalytwitterFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterFrame::min(self : TimeseriesanomalytwitterFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalytwitterFrame::max(self : TimeseriesanomalytwitterFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalytwitterFrame::to_string(self : TimeseriesanomalytwitterFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_table_make(size : Int) -> TimeseriesanomalytwitterTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalytwitterTable::len(self : TimeseriesanomalytwitterTable) -> Int { self.size }

pub fn TimeseriesanomalytwitterTable::get(self : TimeseriesanomalytwitterTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalytwitterTable::set(self : TimeseriesanomalytwitterTable, i : Int, v : Double) -> TimeseriesanomalytwitterTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterTable::sum(self : TimeseriesanomalytwitterTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalytwitterTable::mean(self : TimeseriesanomalytwitterTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalytwitterTable::scale(self : TimeseriesanomalytwitterTable, f : Double) -> TimeseriesanomalytwitterTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterTable::add(self : TimeseriesanomalytwitterTable, other : TimeseriesanomalytwitterTable) -> TimeseriesanomalytwitterTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalytwitterTable::copy(self : TimeseriesanomalytwitterTable) -> TimeseriesanomalytwitterTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterTable::fill(self : TimeseriesanomalytwitterTable, v : Double) -> TimeseriesanomalytwitterTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterTable::min(self : TimeseriesanomalytwitterTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalytwitterTable::max(self : TimeseriesanomalytwitterTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalytwitterTable::to_string(self : TimeseriesanomalytwitterTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_graphn_make(size : Int) -> TimeseriesanomalytwitterGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalytwitterGraphN::len(self : TimeseriesanomalytwitterGraphN) -> Int { self.size }

pub fn TimeseriesanomalytwitterGraphN::get(self : TimeseriesanomalytwitterGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalytwitterGraphN::set(self : TimeseriesanomalytwitterGraphN, i : Int, v : Double) -> TimeseriesanomalytwitterGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterGraphN::sum(self : TimeseriesanomalytwitterGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalytwitterGraphN::mean(self : TimeseriesanomalytwitterGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalytwitterGraphN::scale(self : TimeseriesanomalytwitterGraphN, f : Double) -> TimeseriesanomalytwitterGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterGraphN::add(self : TimeseriesanomalytwitterGraphN, other : TimeseriesanomalytwitterGraphN) -> TimeseriesanomalytwitterGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalytwitterGraphN::copy(self : TimeseriesanomalytwitterGraphN) -> TimeseriesanomalytwitterGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterGraphN::fill(self : TimeseriesanomalytwitterGraphN, v : Double) -> TimeseriesanomalytwitterGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterGraphN::min(self : TimeseriesanomalytwitterGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalytwitterGraphN::max(self : TimeseriesanomalytwitterGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalytwitterGraphN::to_string(self : TimeseriesanomalytwitterGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_node_make(size : Int) -> TimeseriesanomalytwitterNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalytwitterNode::len(self : TimeseriesanomalytwitterNode) -> Int { self.size }

pub fn TimeseriesanomalytwitterNode::get(self : TimeseriesanomalytwitterNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalytwitterNode::set(self : TimeseriesanomalytwitterNode, i : Int, v : Double) -> TimeseriesanomalytwitterNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterNode::sum(self : TimeseriesanomalytwitterNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalytwitterNode::mean(self : TimeseriesanomalytwitterNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalytwitterNode::scale(self : TimeseriesanomalytwitterNode, f : Double) -> TimeseriesanomalytwitterNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterNode::add(self : TimeseriesanomalytwitterNode, other : TimeseriesanomalytwitterNode) -> TimeseriesanomalytwitterNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalytwitterNode::copy(self : TimeseriesanomalytwitterNode) -> TimeseriesanomalytwitterNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterNode::fill(self : TimeseriesanomalytwitterNode, v : Double) -> TimeseriesanomalytwitterNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterNode::min(self : TimeseriesanomalytwitterNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalytwitterNode::max(self : TimeseriesanomalytwitterNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalytwitterNode::to_string(self : TimeseriesanomalytwitterNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_edge_make(size : Int) -> TimeseriesanomalytwitterEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalytwitterEdge::len(self : TimeseriesanomalytwitterEdge) -> Int { self.size }

pub fn TimeseriesanomalytwitterEdge::get(self : TimeseriesanomalytwitterEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalytwitterEdge::set(self : TimeseriesanomalytwitterEdge, i : Int, v : Double) -> TimeseriesanomalytwitterEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterEdge::sum(self : TimeseriesanomalytwitterEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalytwitterEdge::mean(self : TimeseriesanomalytwitterEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalytwitterEdge::scale(self : TimeseriesanomalytwitterEdge, f : Double) -> TimeseriesanomalytwitterEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterEdge::add(self : TimeseriesanomalytwitterEdge, other : TimeseriesanomalytwitterEdge) -> TimeseriesanomalytwitterEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalytwitterEdge::copy(self : TimeseriesanomalytwitterEdge) -> TimeseriesanomalytwitterEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterEdge::fill(self : TimeseriesanomalytwitterEdge, v : Double) -> TimeseriesanomalytwitterEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterEdge::min(self : TimeseriesanomalytwitterEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalytwitterEdge::max(self : TimeseriesanomalytwitterEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalytwitterEdge::to_string(self : TimeseriesanomalytwitterEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_path_make(size : Int) -> TimeseriesanomalytwitterPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalytwitterPath::len(self : TimeseriesanomalytwitterPath) -> Int { self.size }

pub fn TimeseriesanomalytwitterPath::get(self : TimeseriesanomalytwitterPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalytwitterPath::set(self : TimeseriesanomalytwitterPath, i : Int, v : Double) -> TimeseriesanomalytwitterPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterPath::sum(self : TimeseriesanomalytwitterPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalytwitterPath::mean(self : TimeseriesanomalytwitterPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalytwitterPath::scale(self : TimeseriesanomalytwitterPath, f : Double) -> TimeseriesanomalytwitterPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterPath::add(self : TimeseriesanomalytwitterPath, other : TimeseriesanomalytwitterPath) -> TimeseriesanomalytwitterPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalytwitterPath::copy(self : TimeseriesanomalytwitterPath) -> TimeseriesanomalytwitterPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterPath::fill(self : TimeseriesanomalytwitterPath, v : Double) -> TimeseriesanomalytwitterPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterPath::min(self : TimeseriesanomalytwitterPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalytwitterPath::max(self : TimeseriesanomalytwitterPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalytwitterPath::to_string(self : TimeseriesanomalytwitterPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_cluster_make(size : Int) -> TimeseriesanomalytwitterCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalytwitterCluster::len(self : TimeseriesanomalytwitterCluster) -> Int { self.size }

pub fn TimeseriesanomalytwitterCluster::get(self : TimeseriesanomalytwitterCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalytwitterCluster::set(self : TimeseriesanomalytwitterCluster, i : Int, v : Double) -> TimeseriesanomalytwitterCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterCluster::sum(self : TimeseriesanomalytwitterCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalytwitterCluster::mean(self : TimeseriesanomalytwitterCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalytwitterCluster::scale(self : TimeseriesanomalytwitterCluster, f : Double) -> TimeseriesanomalytwitterCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterCluster::add(self : TimeseriesanomalytwitterCluster, other : TimeseriesanomalytwitterCluster) -> TimeseriesanomalytwitterCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalytwitterCluster::copy(self : TimeseriesanomalytwitterCluster) -> TimeseriesanomalytwitterCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterCluster::fill(self : TimeseriesanomalytwitterCluster, v : Double) -> TimeseriesanomalytwitterCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterCluster::min(self : TimeseriesanomalytwitterCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalytwitterCluster::max(self : TimeseriesanomalytwitterCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalytwitterCluster::to_string(self : TimeseriesanomalytwitterCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_model_make(size : Int) -> TimeseriesanomalytwitterModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalytwitterModel::len(self : TimeseriesanomalytwitterModel) -> Int { self.size }

pub fn TimeseriesanomalytwitterModel::get(self : TimeseriesanomalytwitterModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalytwitterModel::set(self : TimeseriesanomalytwitterModel, i : Int, v : Double) -> TimeseriesanomalytwitterModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterModel::sum(self : TimeseriesanomalytwitterModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalytwitterModel::mean(self : TimeseriesanomalytwitterModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalytwitterModel::scale(self : TimeseriesanomalytwitterModel, f : Double) -> TimeseriesanomalytwitterModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterModel::add(self : TimeseriesanomalytwitterModel, other : TimeseriesanomalytwitterModel) -> TimeseriesanomalytwitterModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalytwitterModel::copy(self : TimeseriesanomalytwitterModel) -> TimeseriesanomalytwitterModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterModel::fill(self : TimeseriesanomalytwitterModel, v : Double) -> TimeseriesanomalytwitterModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterModel::min(self : TimeseriesanomalytwitterModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalytwitterModel::max(self : TimeseriesanomalytwitterModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalytwitterModel::to_string(self : TimeseriesanomalytwitterModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_layer_make(size : Int) -> TimeseriesanomalytwitterLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalytwitterLayer::len(self : TimeseriesanomalytwitterLayer) -> Int { self.size }

pub fn TimeseriesanomalytwitterLayer::get(self : TimeseriesanomalytwitterLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalytwitterLayer::set(self : TimeseriesanomalytwitterLayer, i : Int, v : Double) -> TimeseriesanomalytwitterLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterLayer::sum(self : TimeseriesanomalytwitterLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalytwitterLayer::mean(self : TimeseriesanomalytwitterLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalytwitterLayer::scale(self : TimeseriesanomalytwitterLayer, f : Double) -> TimeseriesanomalytwitterLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterLayer::add(self : TimeseriesanomalytwitterLayer, other : TimeseriesanomalytwitterLayer) -> TimeseriesanomalytwitterLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalytwitterLayer::copy(self : TimeseriesanomalytwitterLayer) -> TimeseriesanomalytwitterLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterLayer::fill(self : TimeseriesanomalytwitterLayer, v : Double) -> TimeseriesanomalytwitterLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterLayer::min(self : TimeseriesanomalytwitterLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalytwitterLayer::max(self : TimeseriesanomalytwitterLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalytwitterLayer::to_string(self : TimeseriesanomalytwitterLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_buffer_make(size : Int) -> TimeseriesanomalytwitterBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalytwitterBuffer::len(self : TimeseriesanomalytwitterBuffer) -> Int { self.size }

pub fn TimeseriesanomalytwitterBuffer::get(self : TimeseriesanomalytwitterBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalytwitterBuffer::set(self : TimeseriesanomalytwitterBuffer, i : Int, v : Double) -> TimeseriesanomalytwitterBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterBuffer::sum(self : TimeseriesanomalytwitterBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalytwitterBuffer::mean(self : TimeseriesanomalytwitterBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalytwitterBuffer::scale(self : TimeseriesanomalytwitterBuffer, f : Double) -> TimeseriesanomalytwitterBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterBuffer::add(self : TimeseriesanomalytwitterBuffer, other : TimeseriesanomalytwitterBuffer) -> TimeseriesanomalytwitterBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalytwitterBuffer::copy(self : TimeseriesanomalytwitterBuffer) -> TimeseriesanomalytwitterBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterBuffer::fill(self : TimeseriesanomalytwitterBuffer, v : Double) -> TimeseriesanomalytwitterBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterBuffer::min(self : TimeseriesanomalytwitterBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalytwitterBuffer::max(self : TimeseriesanomalytwitterBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalytwitterBuffer::to_string(self : TimeseriesanomalytwitterBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_cursor_make(size : Int) -> TimeseriesanomalytwitterCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalytwitterCursor::len(self : TimeseriesanomalytwitterCursor) -> Int { self.size }

pub fn TimeseriesanomalytwitterCursor::get(self : TimeseriesanomalytwitterCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalytwitterCursor::set(self : TimeseriesanomalytwitterCursor, i : Int, v : Double) -> TimeseriesanomalytwitterCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterCursor::sum(self : TimeseriesanomalytwitterCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalytwitterCursor::mean(self : TimeseriesanomalytwitterCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalytwitterCursor::scale(self : TimeseriesanomalytwitterCursor, f : Double) -> TimeseriesanomalytwitterCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterCursor::add(self : TimeseriesanomalytwitterCursor, other : TimeseriesanomalytwitterCursor) -> TimeseriesanomalytwitterCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalytwitterCursor::copy(self : TimeseriesanomalytwitterCursor) -> TimeseriesanomalytwitterCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterCursor::fill(self : TimeseriesanomalytwitterCursor, v : Double) -> TimeseriesanomalytwitterCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterCursor::min(self : TimeseriesanomalytwitterCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalytwitterCursor::max(self : TimeseriesanomalytwitterCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalytwitterCursor::to_string(self : TimeseriesanomalytwitterCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_view_make(size : Int) -> TimeseriesanomalytwitterView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalytwitterView::len(self : TimeseriesanomalytwitterView) -> Int { self.size }

pub fn TimeseriesanomalytwitterView::get(self : TimeseriesanomalytwitterView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalytwitterView::set(self : TimeseriesanomalytwitterView, i : Int, v : Double) -> TimeseriesanomalytwitterView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterView::sum(self : TimeseriesanomalytwitterView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalytwitterView::mean(self : TimeseriesanomalytwitterView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalytwitterView::scale(self : TimeseriesanomalytwitterView, f : Double) -> TimeseriesanomalytwitterView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterView::add(self : TimeseriesanomalytwitterView, other : TimeseriesanomalytwitterView) -> TimeseriesanomalytwitterView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalytwitterView::copy(self : TimeseriesanomalytwitterView) -> TimeseriesanomalytwitterView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterView::fill(self : TimeseriesanomalytwitterView, v : Double) -> TimeseriesanomalytwitterView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterView::min(self : TimeseriesanomalytwitterView) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalytwitterView::max(self : TimeseriesanomalytwitterView) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalytwitterView::to_string(self : TimeseriesanomalytwitterView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_range_make(size : Int) -> TimeseriesanomalytwitterRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalytwitterRange::len(self : TimeseriesanomalytwitterRange) -> Int { self.size }

pub fn TimeseriesanomalytwitterRange::get(self : TimeseriesanomalytwitterRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalytwitterRange::set(self : TimeseriesanomalytwitterRange, i : Int, v : Double) -> TimeseriesanomalytwitterRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterRange::sum(self : TimeseriesanomalytwitterRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalytwitterRange::mean(self : TimeseriesanomalytwitterRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalytwitterRange::scale(self : TimeseriesanomalytwitterRange, f : Double) -> TimeseriesanomalytwitterRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterRange::add(self : TimeseriesanomalytwitterRange, other : TimeseriesanomalytwitterRange) -> TimeseriesanomalytwitterRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalytwitterRange::copy(self : TimeseriesanomalytwitterRange) -> TimeseriesanomalytwitterRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterRange::fill(self : TimeseriesanomalytwitterRange, v : Double) -> TimeseriesanomalytwitterRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterRange::min(self : TimeseriesanomalytwitterRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalytwitterRange::max(self : TimeseriesanomalytwitterRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalytwitterRange::to_string(self : TimeseriesanomalytwitterRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_slice_make(size : Int) -> TimeseriesanomalytwitterSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalytwitterSlice::len(self : TimeseriesanomalytwitterSlice) -> Int { self.size }

pub fn TimeseriesanomalytwitterSlice::get(self : TimeseriesanomalytwitterSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalytwitterSlice::set(self : TimeseriesanomalytwitterSlice, i : Int, v : Double) -> TimeseriesanomalytwitterSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterSlice::sum(self : TimeseriesanomalytwitterSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalytwitterSlice::mean(self : TimeseriesanomalytwitterSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalytwitterSlice::scale(self : TimeseriesanomalytwitterSlice, f : Double) -> TimeseriesanomalytwitterSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterSlice::add(self : TimeseriesanomalytwitterSlice, other : TimeseriesanomalytwitterSlice) -> TimeseriesanomalytwitterSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalytwitterSlice::copy(self : TimeseriesanomalytwitterSlice) -> TimeseriesanomalytwitterSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterSlice::fill(self : TimeseriesanomalytwitterSlice, v : Double) -> TimeseriesanomalytwitterSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalytwitterSlice::min(self : TimeseriesanomalytwitterSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalytwitterSlice::max(self : TimeseriesanomalytwitterSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalytwitterSlice::to_string(self : TimeseriesanomalytwitterSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

