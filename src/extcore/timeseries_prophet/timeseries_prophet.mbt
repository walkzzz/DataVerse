///===
/// extcore/timeseries_prophet

pub(all) struct TimeseriesprophetPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_prophet_make_point(x : Double, y : Double) -> TimeseriesprophetPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_prophet_make_point3(x : Double, y : Double, z : Double) -> TimeseriesprophetPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesprophetPoint::x(self : TimeseriesprophetPoint) -> Double { self.x }

pub fn TimeseriesprophetPoint::y(self : TimeseriesprophetPoint) -> Double { self.y }

pub fn TimeseriesprophetPoint::z(self : TimeseriesprophetPoint) -> Double { self.z }

pub fn TimeseriesprophetPoint::label(self : TimeseriesprophetPoint) -> Int { self.label }

pub fn TimeseriesprophetPoint::dist(self : TimeseriesprophetPoint, other : TimeseriesprophetPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesprophetPoint::add(self : TimeseriesprophetPoint, other : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesprophetPoint::sub(self : TimeseriesprophetPoint, other : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesprophetPoint::scale(self : TimeseriesprophetPoint, s : Double) -> TimeseriesprophetPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesprophetPoint::dot(self : TimeseriesprophetPoint, other : TimeseriesprophetPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesprophetPoint::cross(self : TimeseriesprophetPoint, other : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesprophetPoint::norm(self : TimeseriesprophetPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesprophetPoint::normalize(self : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesprophetPoint::negate(self : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesprophetPoint::mid(self : TimeseriesprophetPoint, other : TimeseriesprophetPoint) -> TimeseriesprophetPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesprophetPoint::lerp(self : TimeseriesprophetPoint, other : TimeseriesprophetPoint, t : Double) -> TimeseriesprophetPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesprophetPoint::to_string(self : TimeseriesprophetPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesprophetSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_prophet_make_series(vals : Array[Double], name : String) -> TimeseriesprophetSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesprophetSeries::len(self : TimeseriesprophetSeries) -> Int { self.vals.length() }

pub fn TimeseriesprophetSeries::sum(self : TimeseriesprophetSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesprophetSeries::mean(self : TimeseriesprophetSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesprophetSeries::min(self : TimeseriesprophetSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesprophetSeries::max(self : TimeseriesprophetSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesprophetSeries::range(self : TimeseriesprophetSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesprophetSeries::variance(self : TimeseriesprophetSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesprophetSeries::std(self : TimeseriesprophetSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesprophetSeries::median(self : TimeseriesprophetSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesprophetSeries::scale(self : TimeseriesprophetSeries, f : Double) -> TimeseriesprophetSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesprophetSeries::add(self : TimeseriesprophetSeries, other : TimeseriesprophetSeries) -> TimeseriesprophetSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesprophetSeries::sub(self : TimeseriesprophetSeries, other : TimeseriesprophetSeries) -> TimeseriesprophetSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesprophetSeries::normalize(self : TimeseriesprophetSeries) -> TimeseriesprophetSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesprophetSeries::cumsum(self : TimeseriesprophetSeries) -> TimeseriesprophetSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesprophetSeries::to_string(self : TimeseriesprophetSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesprophetMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_prophet_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesprophetMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn timeseries_prophet_matrix_identity(n : Int) -> TimeseriesprophetMatrix {
  let m = timeseries_prophet_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesprophetMatrix::get(self : TimeseriesprophetMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesprophetMatrix::transpose(self : TimeseriesprophetMatrix) -> TimeseriesprophetMatrix {
  let result = timeseries_prophet_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesprophetMatrix::add(self : TimeseriesprophetMatrix, other : TimeseriesprophetMatrix) -> TimeseriesprophetMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_prophet_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesprophetMatrix::scale(self : TimeseriesprophetMatrix, s : Double) -> TimeseriesprophetMatrix {
  let result = timeseries_prophet_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesprophetMatrix::multiply(self : TimeseriesprophetMatrix, other : TimeseriesprophetMatrix) -> TimeseriesprophetMatrix {
  if self.cols != other.rows { return timeseries_prophet_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_prophet_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn TimeseriesprophetMatrix::trace(self : TimeseriesprophetMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesprophetMatrix::det(self : TimeseriesprophetMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesprophetMatrix::norm(self : TimeseriesprophetMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesprophetMatrix::to_string(self : TimeseriesprophetMatrix) -> String {
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

pub(all) struct TimeseriesprophetVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_prophet_make_vector(comps : Array[Double]) -> TimeseriesprophetVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_prophet_vector_zero(dim : Int) -> TimeseriesprophetVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesprophetVector::add(self : TimeseriesprophetVector, other : TimeseriesprophetVector) -> TimeseriesprophetVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesprophetVector::sub(self : TimeseriesprophetVector, other : TimeseriesprophetVector) -> TimeseriesprophetVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesprophetVector::scale(self : TimeseriesprophetVector, s : Double) -> TimeseriesprophetVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesprophetVector::dot(self : TimeseriesprophetVector, other : TimeseriesprophetVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesprophetVector::norm(self : TimeseriesprophetVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesprophetVector::normalize(self : TimeseriesprophetVector) -> TimeseriesprophetVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesprophetVector::dist(self : TimeseriesprophetVector, other : TimeseriesprophetVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesprophetVector::to_string(self : TimeseriesprophetVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesprophetFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_frame_make(size : Int) -> TimeseriesprophetFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesprophetFrame::len(self : TimeseriesprophetFrame) -> Int { self.size }

pub fn TimeseriesprophetFrame::get(self : TimeseriesprophetFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesprophetFrame::set(self : TimeseriesprophetFrame, i : Int, v : Double) -> TimeseriesprophetFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetFrame::sum(self : TimeseriesprophetFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesprophetFrame::mean(self : TimeseriesprophetFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesprophetFrame::scale(self : TimeseriesprophetFrame, f : Double) -> TimeseriesprophetFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetFrame::add(self : TimeseriesprophetFrame, other : TimeseriesprophetFrame) -> TimeseriesprophetFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesprophetFrame::copy(self : TimeseriesprophetFrame) -> TimeseriesprophetFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetFrame::fill(self : TimeseriesprophetFrame, v : Double) -> TimeseriesprophetFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetFrame::min(self : TimeseriesprophetFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesprophetFrame::max(self : TimeseriesprophetFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesprophetFrame::to_string(self : TimeseriesprophetFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_table_make(size : Int) -> TimeseriesprophetTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesprophetTable::len(self : TimeseriesprophetTable) -> Int { self.size }

pub fn TimeseriesprophetTable::get(self : TimeseriesprophetTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesprophetTable::set(self : TimeseriesprophetTable, i : Int, v : Double) -> TimeseriesprophetTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetTable::sum(self : TimeseriesprophetTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesprophetTable::mean(self : TimeseriesprophetTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesprophetTable::scale(self : TimeseriesprophetTable, f : Double) -> TimeseriesprophetTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetTable::add(self : TimeseriesprophetTable, other : TimeseriesprophetTable) -> TimeseriesprophetTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesprophetTable::copy(self : TimeseriesprophetTable) -> TimeseriesprophetTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetTable::fill(self : TimeseriesprophetTable, v : Double) -> TimeseriesprophetTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetTable::min(self : TimeseriesprophetTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesprophetTable::max(self : TimeseriesprophetTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesprophetTable::to_string(self : TimeseriesprophetTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_graphn_make(size : Int) -> TimeseriesprophetGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesprophetGraphN::len(self : TimeseriesprophetGraphN) -> Int { self.size }

pub fn TimeseriesprophetGraphN::get(self : TimeseriesprophetGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesprophetGraphN::set(self : TimeseriesprophetGraphN, i : Int, v : Double) -> TimeseriesprophetGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetGraphN::sum(self : TimeseriesprophetGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesprophetGraphN::mean(self : TimeseriesprophetGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesprophetGraphN::scale(self : TimeseriesprophetGraphN, f : Double) -> TimeseriesprophetGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetGraphN::add(self : TimeseriesprophetGraphN, other : TimeseriesprophetGraphN) -> TimeseriesprophetGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesprophetGraphN::copy(self : TimeseriesprophetGraphN) -> TimeseriesprophetGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetGraphN::fill(self : TimeseriesprophetGraphN, v : Double) -> TimeseriesprophetGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetGraphN::min(self : TimeseriesprophetGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesprophetGraphN::max(self : TimeseriesprophetGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesprophetGraphN::to_string(self : TimeseriesprophetGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_node_make(size : Int) -> TimeseriesprophetNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesprophetNode::len(self : TimeseriesprophetNode) -> Int { self.size }

pub fn TimeseriesprophetNode::get(self : TimeseriesprophetNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesprophetNode::set(self : TimeseriesprophetNode, i : Int, v : Double) -> TimeseriesprophetNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetNode::sum(self : TimeseriesprophetNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesprophetNode::mean(self : TimeseriesprophetNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesprophetNode::scale(self : TimeseriesprophetNode, f : Double) -> TimeseriesprophetNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetNode::add(self : TimeseriesprophetNode, other : TimeseriesprophetNode) -> TimeseriesprophetNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesprophetNode::copy(self : TimeseriesprophetNode) -> TimeseriesprophetNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetNode::fill(self : TimeseriesprophetNode, v : Double) -> TimeseriesprophetNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetNode::min(self : TimeseriesprophetNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesprophetNode::max(self : TimeseriesprophetNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesprophetNode::to_string(self : TimeseriesprophetNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_edge_make(size : Int) -> TimeseriesprophetEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesprophetEdge::len(self : TimeseriesprophetEdge) -> Int { self.size }

pub fn TimeseriesprophetEdge::get(self : TimeseriesprophetEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesprophetEdge::set(self : TimeseriesprophetEdge, i : Int, v : Double) -> TimeseriesprophetEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetEdge::sum(self : TimeseriesprophetEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesprophetEdge::mean(self : TimeseriesprophetEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesprophetEdge::scale(self : TimeseriesprophetEdge, f : Double) -> TimeseriesprophetEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetEdge::add(self : TimeseriesprophetEdge, other : TimeseriesprophetEdge) -> TimeseriesprophetEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesprophetEdge::copy(self : TimeseriesprophetEdge) -> TimeseriesprophetEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetEdge::fill(self : TimeseriesprophetEdge, v : Double) -> TimeseriesprophetEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetEdge::min(self : TimeseriesprophetEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesprophetEdge::max(self : TimeseriesprophetEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesprophetEdge::to_string(self : TimeseriesprophetEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_path_make(size : Int) -> TimeseriesprophetPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesprophetPath::len(self : TimeseriesprophetPath) -> Int { self.size }

pub fn TimeseriesprophetPath::get(self : TimeseriesprophetPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesprophetPath::set(self : TimeseriesprophetPath, i : Int, v : Double) -> TimeseriesprophetPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetPath::sum(self : TimeseriesprophetPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesprophetPath::mean(self : TimeseriesprophetPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesprophetPath::scale(self : TimeseriesprophetPath, f : Double) -> TimeseriesprophetPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetPath::add(self : TimeseriesprophetPath, other : TimeseriesprophetPath) -> TimeseriesprophetPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesprophetPath::copy(self : TimeseriesprophetPath) -> TimeseriesprophetPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetPath::fill(self : TimeseriesprophetPath, v : Double) -> TimeseriesprophetPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetPath::min(self : TimeseriesprophetPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesprophetPath::max(self : TimeseriesprophetPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesprophetPath::to_string(self : TimeseriesprophetPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_cluster_make(size : Int) -> TimeseriesprophetCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesprophetCluster::len(self : TimeseriesprophetCluster) -> Int { self.size }

pub fn TimeseriesprophetCluster::get(self : TimeseriesprophetCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesprophetCluster::set(self : TimeseriesprophetCluster, i : Int, v : Double) -> TimeseriesprophetCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetCluster::sum(self : TimeseriesprophetCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesprophetCluster::mean(self : TimeseriesprophetCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesprophetCluster::scale(self : TimeseriesprophetCluster, f : Double) -> TimeseriesprophetCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetCluster::add(self : TimeseriesprophetCluster, other : TimeseriesprophetCluster) -> TimeseriesprophetCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesprophetCluster::copy(self : TimeseriesprophetCluster) -> TimeseriesprophetCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetCluster::fill(self : TimeseriesprophetCluster, v : Double) -> TimeseriesprophetCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetCluster::min(self : TimeseriesprophetCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesprophetCluster::max(self : TimeseriesprophetCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesprophetCluster::to_string(self : TimeseriesprophetCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_model_make(size : Int) -> TimeseriesprophetModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesprophetModel::len(self : TimeseriesprophetModel) -> Int { self.size }

pub fn TimeseriesprophetModel::get(self : TimeseriesprophetModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesprophetModel::set(self : TimeseriesprophetModel, i : Int, v : Double) -> TimeseriesprophetModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetModel::sum(self : TimeseriesprophetModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesprophetModel::mean(self : TimeseriesprophetModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesprophetModel::scale(self : TimeseriesprophetModel, f : Double) -> TimeseriesprophetModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetModel::add(self : TimeseriesprophetModel, other : TimeseriesprophetModel) -> TimeseriesprophetModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesprophetModel::copy(self : TimeseriesprophetModel) -> TimeseriesprophetModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetModel::fill(self : TimeseriesprophetModel, v : Double) -> TimeseriesprophetModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetModel::min(self : TimeseriesprophetModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesprophetModel::max(self : TimeseriesprophetModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesprophetModel::to_string(self : TimeseriesprophetModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_layer_make(size : Int) -> TimeseriesprophetLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesprophetLayer::len(self : TimeseriesprophetLayer) -> Int { self.size }

pub fn TimeseriesprophetLayer::get(self : TimeseriesprophetLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesprophetLayer::set(self : TimeseriesprophetLayer, i : Int, v : Double) -> TimeseriesprophetLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetLayer::sum(self : TimeseriesprophetLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesprophetLayer::mean(self : TimeseriesprophetLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesprophetLayer::scale(self : TimeseriesprophetLayer, f : Double) -> TimeseriesprophetLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetLayer::add(self : TimeseriesprophetLayer, other : TimeseriesprophetLayer) -> TimeseriesprophetLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesprophetLayer::copy(self : TimeseriesprophetLayer) -> TimeseriesprophetLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetLayer::fill(self : TimeseriesprophetLayer, v : Double) -> TimeseriesprophetLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetLayer::min(self : TimeseriesprophetLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesprophetLayer::max(self : TimeseriesprophetLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesprophetLayer::to_string(self : TimeseriesprophetLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_buffer_make(size : Int) -> TimeseriesprophetBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesprophetBuffer::len(self : TimeseriesprophetBuffer) -> Int { self.size }

pub fn TimeseriesprophetBuffer::get(self : TimeseriesprophetBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesprophetBuffer::set(self : TimeseriesprophetBuffer, i : Int, v : Double) -> TimeseriesprophetBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetBuffer::sum(self : TimeseriesprophetBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesprophetBuffer::mean(self : TimeseriesprophetBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesprophetBuffer::scale(self : TimeseriesprophetBuffer, f : Double) -> TimeseriesprophetBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetBuffer::add(self : TimeseriesprophetBuffer, other : TimeseriesprophetBuffer) -> TimeseriesprophetBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesprophetBuffer::copy(self : TimeseriesprophetBuffer) -> TimeseriesprophetBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetBuffer::fill(self : TimeseriesprophetBuffer, v : Double) -> TimeseriesprophetBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetBuffer::min(self : TimeseriesprophetBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesprophetBuffer::max(self : TimeseriesprophetBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesprophetBuffer::to_string(self : TimeseriesprophetBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_cursor_make(size : Int) -> TimeseriesprophetCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesprophetCursor::len(self : TimeseriesprophetCursor) -> Int { self.size }

pub fn TimeseriesprophetCursor::get(self : TimeseriesprophetCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesprophetCursor::set(self : TimeseriesprophetCursor, i : Int, v : Double) -> TimeseriesprophetCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetCursor::sum(self : TimeseriesprophetCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesprophetCursor::mean(self : TimeseriesprophetCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesprophetCursor::scale(self : TimeseriesprophetCursor, f : Double) -> TimeseriesprophetCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetCursor::add(self : TimeseriesprophetCursor, other : TimeseriesprophetCursor) -> TimeseriesprophetCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesprophetCursor::copy(self : TimeseriesprophetCursor) -> TimeseriesprophetCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetCursor::fill(self : TimeseriesprophetCursor, v : Double) -> TimeseriesprophetCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetCursor::min(self : TimeseriesprophetCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesprophetCursor::max(self : TimeseriesprophetCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesprophetCursor::to_string(self : TimeseriesprophetCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_view_make(size : Int) -> TimeseriesprophetView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesprophetView::len(self : TimeseriesprophetView) -> Int { self.size }

pub fn TimeseriesprophetView::get(self : TimeseriesprophetView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesprophetView::set(self : TimeseriesprophetView, i : Int, v : Double) -> TimeseriesprophetView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetView::sum(self : TimeseriesprophetView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesprophetView::mean(self : TimeseriesprophetView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesprophetView::scale(self : TimeseriesprophetView, f : Double) -> TimeseriesprophetView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetView::add(self : TimeseriesprophetView, other : TimeseriesprophetView) -> TimeseriesprophetView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesprophetView::copy(self : TimeseriesprophetView) -> TimeseriesprophetView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetView::fill(self : TimeseriesprophetView, v : Double) -> TimeseriesprophetView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetView::min(self : TimeseriesprophetView) -> Double { @_common.min(self.data) }

pub fn TimeseriesprophetView::max(self : TimeseriesprophetView) -> Double { @_common.max(self.data) }

pub fn TimeseriesprophetView::to_string(self : TimeseriesprophetView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_range_make(size : Int) -> TimeseriesprophetRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesprophetRange::len(self : TimeseriesprophetRange) -> Int { self.size }

pub fn TimeseriesprophetRange::get(self : TimeseriesprophetRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesprophetRange::set(self : TimeseriesprophetRange, i : Int, v : Double) -> TimeseriesprophetRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetRange::sum(self : TimeseriesprophetRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesprophetRange::mean(self : TimeseriesprophetRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesprophetRange::scale(self : TimeseriesprophetRange, f : Double) -> TimeseriesprophetRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetRange::add(self : TimeseriesprophetRange, other : TimeseriesprophetRange) -> TimeseriesprophetRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesprophetRange::copy(self : TimeseriesprophetRange) -> TimeseriesprophetRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetRange::fill(self : TimeseriesprophetRange, v : Double) -> TimeseriesprophetRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetRange::min(self : TimeseriesprophetRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesprophetRange::max(self : TimeseriesprophetRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesprophetRange::to_string(self : TimeseriesprophetRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesprophetSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_prophet_slice_make(size : Int) -> TimeseriesprophetSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesprophetSlice::len(self : TimeseriesprophetSlice) -> Int { self.size }

pub fn TimeseriesprophetSlice::get(self : TimeseriesprophetSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesprophetSlice::set(self : TimeseriesprophetSlice, i : Int, v : Double) -> TimeseriesprophetSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetSlice::sum(self : TimeseriesprophetSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesprophetSlice::mean(self : TimeseriesprophetSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesprophetSlice::scale(self : TimeseriesprophetSlice, f : Double) -> TimeseriesprophetSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetSlice::add(self : TimeseriesprophetSlice, other : TimeseriesprophetSlice) -> TimeseriesprophetSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesprophetSlice::copy(self : TimeseriesprophetSlice) -> TimeseriesprophetSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetSlice::fill(self : TimeseriesprophetSlice, v : Double) -> TimeseriesprophetSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesprophetSlice::min(self : TimeseriesprophetSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesprophetSlice::max(self : TimeseriesprophetSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesprophetSlice::to_string(self : TimeseriesprophetSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

