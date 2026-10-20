///===
/// extcore/timeseries_winters

pub(all) struct TimeserieswintersPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_winters_make_point(x : Double, y : Double) -> TimeserieswintersPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_winters_make_point3(x : Double, y : Double, z : Double) -> TimeserieswintersPoint {
  { x, y, z, label: 0 }
}

pub fn TimeserieswintersPoint::x(self : TimeserieswintersPoint) -> Double { self.x }

pub fn TimeserieswintersPoint::y(self : TimeserieswintersPoint) -> Double { self.y }

pub fn TimeserieswintersPoint::z(self : TimeserieswintersPoint) -> Double { self.z }

pub fn TimeserieswintersPoint::label(self : TimeserieswintersPoint) -> Int { self.label }

pub fn TimeserieswintersPoint::dist(self : TimeserieswintersPoint, other : TimeserieswintersPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeserieswintersPoint::add(self : TimeserieswintersPoint, other : TimeserieswintersPoint) -> TimeserieswintersPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeserieswintersPoint::sub(self : TimeserieswintersPoint, other : TimeserieswintersPoint) -> TimeserieswintersPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeserieswintersPoint::scale(self : TimeserieswintersPoint, s : Double) -> TimeserieswintersPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeserieswintersPoint::dot(self : TimeserieswintersPoint, other : TimeserieswintersPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeserieswintersPoint::cross(self : TimeserieswintersPoint, other : TimeserieswintersPoint) -> TimeserieswintersPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeserieswintersPoint::norm(self : TimeserieswintersPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeserieswintersPoint::normalize(self : TimeserieswintersPoint) -> TimeserieswintersPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeserieswintersPoint::negate(self : TimeserieswintersPoint) -> TimeserieswintersPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeserieswintersPoint::mid(self : TimeserieswintersPoint, other : TimeserieswintersPoint) -> TimeserieswintersPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeserieswintersPoint::lerp(self : TimeserieswintersPoint, other : TimeserieswintersPoint, t : Double) -> TimeserieswintersPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeserieswintersPoint::to_string(self : TimeserieswintersPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeserieswintersSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_winters_make_series(vals : Array[Double], name : String) -> TimeserieswintersSeries {
  { vals, name, meta: 0 }
}

pub fn TimeserieswintersSeries::len(self : TimeserieswintersSeries) -> Int { self.vals.length() }

pub fn TimeserieswintersSeries::sum(self : TimeserieswintersSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeserieswintersSeries::mean(self : TimeserieswintersSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeserieswintersSeries::min(self : TimeserieswintersSeries) -> Double { @_common.min(self.vals) }

pub fn TimeserieswintersSeries::max(self : TimeserieswintersSeries) -> Double { @_common.max(self.vals) }

pub fn TimeserieswintersSeries::range(self : TimeserieswintersSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeserieswintersSeries::variance(self : TimeserieswintersSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeserieswintersSeries::std(self : TimeserieswintersSeries) -> Double { @_common.std(self.vals) }

pub fn TimeserieswintersSeries::median(self : TimeserieswintersSeries) -> Double { @_common.median(self.vals) }

pub fn TimeserieswintersSeries::scale(self : TimeserieswintersSeries, f : Double) -> TimeserieswintersSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeserieswintersSeries::add(self : TimeserieswintersSeries, other : TimeserieswintersSeries) -> TimeserieswintersSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeserieswintersSeries::sub(self : TimeserieswintersSeries, other : TimeserieswintersSeries) -> TimeserieswintersSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeserieswintersSeries::normalize(self : TimeserieswintersSeries) -> TimeserieswintersSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeserieswintersSeries::cumsum(self : TimeserieswintersSeries) -> TimeserieswintersSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeserieswintersSeries::to_string(self : TimeserieswintersSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeserieswintersMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_winters_make_matrix(rows : Int, cols : Int, val : Double) -> TimeserieswintersMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_winters_matrix_identity(n : Int) -> TimeserieswintersMatrix {
  let m = timeseries_winters_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeserieswintersMatrix::get(self : TimeserieswintersMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeserieswintersMatrix::transpose(self : TimeserieswintersMatrix) -> TimeserieswintersMatrix {
  let result = timeseries_winters_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeserieswintersMatrix::add(self : TimeserieswintersMatrix, other : TimeserieswintersMatrix) -> TimeserieswintersMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_winters_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeserieswintersMatrix::scale(self : TimeserieswintersMatrix, s : Double) -> TimeserieswintersMatrix {
  let result = timeseries_winters_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeserieswintersMatrix::multiply(self : TimeserieswintersMatrix, other : TimeserieswintersMatrix) -> TimeserieswintersMatrix {
  if self.cols != other.rows { return timeseries_winters_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_winters_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeserieswintersMatrix::trace(self : TimeserieswintersMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeserieswintersMatrix::det(self : TimeserieswintersMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeserieswintersMatrix::norm(self : TimeserieswintersMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeserieswintersMatrix::to_string(self : TimeserieswintersMatrix) -> String {
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

pub(all) struct TimeserieswintersVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_winters_make_vector(comps : Array[Double]) -> TimeserieswintersVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_winters_vector_zero(dim : Int) -> TimeserieswintersVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeserieswintersVector::add(self : TimeserieswintersVector, other : TimeserieswintersVector) -> TimeserieswintersVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeserieswintersVector::sub(self : TimeserieswintersVector, other : TimeserieswintersVector) -> TimeserieswintersVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeserieswintersVector::scale(self : TimeserieswintersVector, s : Double) -> TimeserieswintersVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeserieswintersVector::dot(self : TimeserieswintersVector, other : TimeserieswintersVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeserieswintersVector::norm(self : TimeserieswintersVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeserieswintersVector::normalize(self : TimeserieswintersVector) -> TimeserieswintersVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeserieswintersVector::dist(self : TimeserieswintersVector, other : TimeserieswintersVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeserieswintersVector::to_string(self : TimeserieswintersVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeserieswintersFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_frame_make(size : Int) -> TimeserieswintersFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeserieswintersFrame::len(self : TimeserieswintersFrame) -> Int { self.size }

pub fn TimeserieswintersFrame::get(self : TimeserieswintersFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeserieswintersFrame::set(self : TimeserieswintersFrame, i : Int, v : Double) -> TimeserieswintersFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeserieswintersFrame::sum(self : TimeserieswintersFrame) -> Double { @_common.sum(self.data) }

pub fn TimeserieswintersFrame::mean(self : TimeserieswintersFrame) -> Double { @_common.mean(self.data) }

pub fn TimeserieswintersFrame::scale(self : TimeserieswintersFrame, f : Double) -> TimeserieswintersFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersFrame::add(self : TimeserieswintersFrame, other : TimeserieswintersFrame) -> TimeserieswintersFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeserieswintersFrame::copy(self : TimeserieswintersFrame) -> TimeserieswintersFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersFrame::fill(self : TimeserieswintersFrame, v : Double) -> TimeserieswintersFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersFrame::min(self : TimeserieswintersFrame) -> Double { @_common.min(self.data) }

pub fn TimeserieswintersFrame::max(self : TimeserieswintersFrame) -> Double { @_common.max(self.data) }

pub fn TimeserieswintersFrame::to_string(self : TimeserieswintersFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_table_make(size : Int) -> TimeserieswintersTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeserieswintersTable::len(self : TimeserieswintersTable) -> Int { self.size }

pub fn TimeserieswintersTable::get(self : TimeserieswintersTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeserieswintersTable::set(self : TimeserieswintersTable, i : Int, v : Double) -> TimeserieswintersTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeserieswintersTable::sum(self : TimeserieswintersTable) -> Double { @_common.sum(self.data) }

pub fn TimeserieswintersTable::mean(self : TimeserieswintersTable) -> Double { @_common.mean(self.data) }

pub fn TimeserieswintersTable::scale(self : TimeserieswintersTable, f : Double) -> TimeserieswintersTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersTable::add(self : TimeserieswintersTable, other : TimeserieswintersTable) -> TimeserieswintersTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeserieswintersTable::copy(self : TimeserieswintersTable) -> TimeserieswintersTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersTable::fill(self : TimeserieswintersTable, v : Double) -> TimeserieswintersTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersTable::min(self : TimeserieswintersTable) -> Double { @_common.min(self.data) }

pub fn TimeserieswintersTable::max(self : TimeserieswintersTable) -> Double { @_common.max(self.data) }

pub fn TimeserieswintersTable::to_string(self : TimeserieswintersTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_graphn_make(size : Int) -> TimeserieswintersGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeserieswintersGraphN::len(self : TimeserieswintersGraphN) -> Int { self.size }

pub fn TimeserieswintersGraphN::get(self : TimeserieswintersGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeserieswintersGraphN::set(self : TimeserieswintersGraphN, i : Int, v : Double) -> TimeserieswintersGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeserieswintersGraphN::sum(self : TimeserieswintersGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeserieswintersGraphN::mean(self : TimeserieswintersGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeserieswintersGraphN::scale(self : TimeserieswintersGraphN, f : Double) -> TimeserieswintersGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersGraphN::add(self : TimeserieswintersGraphN, other : TimeserieswintersGraphN) -> TimeserieswintersGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeserieswintersGraphN::copy(self : TimeserieswintersGraphN) -> TimeserieswintersGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersGraphN::fill(self : TimeserieswintersGraphN, v : Double) -> TimeserieswintersGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersGraphN::min(self : TimeserieswintersGraphN) -> Double { @_common.min(self.data) }

pub fn TimeserieswintersGraphN::max(self : TimeserieswintersGraphN) -> Double { @_common.max(self.data) }

pub fn TimeserieswintersGraphN::to_string(self : TimeserieswintersGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_node_make(size : Int) -> TimeserieswintersNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeserieswintersNode::len(self : TimeserieswintersNode) -> Int { self.size }

pub fn TimeserieswintersNode::get(self : TimeserieswintersNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeserieswintersNode::set(self : TimeserieswintersNode, i : Int, v : Double) -> TimeserieswintersNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeserieswintersNode::sum(self : TimeserieswintersNode) -> Double { @_common.sum(self.data) }

pub fn TimeserieswintersNode::mean(self : TimeserieswintersNode) -> Double { @_common.mean(self.data) }

pub fn TimeserieswintersNode::scale(self : TimeserieswintersNode, f : Double) -> TimeserieswintersNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersNode::add(self : TimeserieswintersNode, other : TimeserieswintersNode) -> TimeserieswintersNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeserieswintersNode::copy(self : TimeserieswintersNode) -> TimeserieswintersNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersNode::fill(self : TimeserieswintersNode, v : Double) -> TimeserieswintersNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersNode::min(self : TimeserieswintersNode) -> Double { @_common.min(self.data) }

pub fn TimeserieswintersNode::max(self : TimeserieswintersNode) -> Double { @_common.max(self.data) }

pub fn TimeserieswintersNode::to_string(self : TimeserieswintersNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_edge_make(size : Int) -> TimeserieswintersEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeserieswintersEdge::len(self : TimeserieswintersEdge) -> Int { self.size }

pub fn TimeserieswintersEdge::get(self : TimeserieswintersEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeserieswintersEdge::set(self : TimeserieswintersEdge, i : Int, v : Double) -> TimeserieswintersEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeserieswintersEdge::sum(self : TimeserieswintersEdge) -> Double { @_common.sum(self.data) }

pub fn TimeserieswintersEdge::mean(self : TimeserieswintersEdge) -> Double { @_common.mean(self.data) }

pub fn TimeserieswintersEdge::scale(self : TimeserieswintersEdge, f : Double) -> TimeserieswintersEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersEdge::add(self : TimeserieswintersEdge, other : TimeserieswintersEdge) -> TimeserieswintersEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeserieswintersEdge::copy(self : TimeserieswintersEdge) -> TimeserieswintersEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersEdge::fill(self : TimeserieswintersEdge, v : Double) -> TimeserieswintersEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersEdge::min(self : TimeserieswintersEdge) -> Double { @_common.min(self.data) }

pub fn TimeserieswintersEdge::max(self : TimeserieswintersEdge) -> Double { @_common.max(self.data) }

pub fn TimeserieswintersEdge::to_string(self : TimeserieswintersEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_path_make(size : Int) -> TimeserieswintersPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeserieswintersPath::len(self : TimeserieswintersPath) -> Int { self.size }

pub fn TimeserieswintersPath::get(self : TimeserieswintersPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeserieswintersPath::set(self : TimeserieswintersPath, i : Int, v : Double) -> TimeserieswintersPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeserieswintersPath::sum(self : TimeserieswintersPath) -> Double { @_common.sum(self.data) }

pub fn TimeserieswintersPath::mean(self : TimeserieswintersPath) -> Double { @_common.mean(self.data) }

pub fn TimeserieswintersPath::scale(self : TimeserieswintersPath, f : Double) -> TimeserieswintersPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersPath::add(self : TimeserieswintersPath, other : TimeserieswintersPath) -> TimeserieswintersPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeserieswintersPath::copy(self : TimeserieswintersPath) -> TimeserieswintersPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersPath::fill(self : TimeserieswintersPath, v : Double) -> TimeserieswintersPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersPath::min(self : TimeserieswintersPath) -> Double { @_common.min(self.data) }

pub fn TimeserieswintersPath::max(self : TimeserieswintersPath) -> Double { @_common.max(self.data) }

pub fn TimeserieswintersPath::to_string(self : TimeserieswintersPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_cluster_make(size : Int) -> TimeserieswintersCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeserieswintersCluster::len(self : TimeserieswintersCluster) -> Int { self.size }

pub fn TimeserieswintersCluster::get(self : TimeserieswintersCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeserieswintersCluster::set(self : TimeserieswintersCluster, i : Int, v : Double) -> TimeserieswintersCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeserieswintersCluster::sum(self : TimeserieswintersCluster) -> Double { @_common.sum(self.data) }

pub fn TimeserieswintersCluster::mean(self : TimeserieswintersCluster) -> Double { @_common.mean(self.data) }

pub fn TimeserieswintersCluster::scale(self : TimeserieswintersCluster, f : Double) -> TimeserieswintersCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersCluster::add(self : TimeserieswintersCluster, other : TimeserieswintersCluster) -> TimeserieswintersCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeserieswintersCluster::copy(self : TimeserieswintersCluster) -> TimeserieswintersCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersCluster::fill(self : TimeserieswintersCluster, v : Double) -> TimeserieswintersCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersCluster::min(self : TimeserieswintersCluster) -> Double { @_common.min(self.data) }

pub fn TimeserieswintersCluster::max(self : TimeserieswintersCluster) -> Double { @_common.max(self.data) }

pub fn TimeserieswintersCluster::to_string(self : TimeserieswintersCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_model_make(size : Int) -> TimeserieswintersModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeserieswintersModel::len(self : TimeserieswintersModel) -> Int { self.size }

pub fn TimeserieswintersModel::get(self : TimeserieswintersModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeserieswintersModel::set(self : TimeserieswintersModel, i : Int, v : Double) -> TimeserieswintersModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeserieswintersModel::sum(self : TimeserieswintersModel) -> Double { @_common.sum(self.data) }

pub fn TimeserieswintersModel::mean(self : TimeserieswintersModel) -> Double { @_common.mean(self.data) }

pub fn TimeserieswintersModel::scale(self : TimeserieswintersModel, f : Double) -> TimeserieswintersModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersModel::add(self : TimeserieswintersModel, other : TimeserieswintersModel) -> TimeserieswintersModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeserieswintersModel::copy(self : TimeserieswintersModel) -> TimeserieswintersModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersModel::fill(self : TimeserieswintersModel, v : Double) -> TimeserieswintersModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersModel::min(self : TimeserieswintersModel) -> Double { @_common.min(self.data) }

pub fn TimeserieswintersModel::max(self : TimeserieswintersModel) -> Double { @_common.max(self.data) }

pub fn TimeserieswintersModel::to_string(self : TimeserieswintersModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_layer_make(size : Int) -> TimeserieswintersLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeserieswintersLayer::len(self : TimeserieswintersLayer) -> Int { self.size }

pub fn TimeserieswintersLayer::get(self : TimeserieswintersLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeserieswintersLayer::set(self : TimeserieswintersLayer, i : Int, v : Double) -> TimeserieswintersLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeserieswintersLayer::sum(self : TimeserieswintersLayer) -> Double { @_common.sum(self.data) }

pub fn TimeserieswintersLayer::mean(self : TimeserieswintersLayer) -> Double { @_common.mean(self.data) }

pub fn TimeserieswintersLayer::scale(self : TimeserieswintersLayer, f : Double) -> TimeserieswintersLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersLayer::add(self : TimeserieswintersLayer, other : TimeserieswintersLayer) -> TimeserieswintersLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeserieswintersLayer::copy(self : TimeserieswintersLayer) -> TimeserieswintersLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersLayer::fill(self : TimeserieswintersLayer, v : Double) -> TimeserieswintersLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersLayer::min(self : TimeserieswintersLayer) -> Double { @_common.min(self.data) }

pub fn TimeserieswintersLayer::max(self : TimeserieswintersLayer) -> Double { @_common.max(self.data) }

pub fn TimeserieswintersLayer::to_string(self : TimeserieswintersLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_buffer_make(size : Int) -> TimeserieswintersBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeserieswintersBuffer::len(self : TimeserieswintersBuffer) -> Int { self.size }

pub fn TimeserieswintersBuffer::get(self : TimeserieswintersBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeserieswintersBuffer::set(self : TimeserieswintersBuffer, i : Int, v : Double) -> TimeserieswintersBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeserieswintersBuffer::sum(self : TimeserieswintersBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeserieswintersBuffer::mean(self : TimeserieswintersBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeserieswintersBuffer::scale(self : TimeserieswintersBuffer, f : Double) -> TimeserieswintersBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersBuffer::add(self : TimeserieswintersBuffer, other : TimeserieswintersBuffer) -> TimeserieswintersBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeserieswintersBuffer::copy(self : TimeserieswintersBuffer) -> TimeserieswintersBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersBuffer::fill(self : TimeserieswintersBuffer, v : Double) -> TimeserieswintersBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersBuffer::min(self : TimeserieswintersBuffer) -> Double { @_common.min(self.data) }

pub fn TimeserieswintersBuffer::max(self : TimeserieswintersBuffer) -> Double { @_common.max(self.data) }

pub fn TimeserieswintersBuffer::to_string(self : TimeserieswintersBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_cursor_make(size : Int) -> TimeserieswintersCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeserieswintersCursor::len(self : TimeserieswintersCursor) -> Int { self.size }

pub fn TimeserieswintersCursor::get(self : TimeserieswintersCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeserieswintersCursor::set(self : TimeserieswintersCursor, i : Int, v : Double) -> TimeserieswintersCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeserieswintersCursor::sum(self : TimeserieswintersCursor) -> Double { @_common.sum(self.data) }

pub fn TimeserieswintersCursor::mean(self : TimeserieswintersCursor) -> Double { @_common.mean(self.data) }

pub fn TimeserieswintersCursor::scale(self : TimeserieswintersCursor, f : Double) -> TimeserieswintersCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersCursor::add(self : TimeserieswintersCursor, other : TimeserieswintersCursor) -> TimeserieswintersCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeserieswintersCursor::copy(self : TimeserieswintersCursor) -> TimeserieswintersCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersCursor::fill(self : TimeserieswintersCursor, v : Double) -> TimeserieswintersCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersCursor::min(self : TimeserieswintersCursor) -> Double { @_common.min(self.data) }

pub fn TimeserieswintersCursor::max(self : TimeserieswintersCursor) -> Double { @_common.max(self.data) }

pub fn TimeserieswintersCursor::to_string(self : TimeserieswintersCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_view_make(size : Int) -> TimeserieswintersView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeserieswintersView::len(self : TimeserieswintersView) -> Int { self.size }

pub fn TimeserieswintersView::get(self : TimeserieswintersView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeserieswintersView::set(self : TimeserieswintersView, i : Int, v : Double) -> TimeserieswintersView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeserieswintersView::sum(self : TimeserieswintersView) -> Double { @_common.sum(self.data) }

pub fn TimeserieswintersView::mean(self : TimeserieswintersView) -> Double { @_common.mean(self.data) }

pub fn TimeserieswintersView::scale(self : TimeserieswintersView, f : Double) -> TimeserieswintersView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersView::add(self : TimeserieswintersView, other : TimeserieswintersView) -> TimeserieswintersView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeserieswintersView::copy(self : TimeserieswintersView) -> TimeserieswintersView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersView::fill(self : TimeserieswintersView, v : Double) -> TimeserieswintersView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersView::min(self : TimeserieswintersView) -> Double { @_common.min(self.data) }

pub fn TimeserieswintersView::max(self : TimeserieswintersView) -> Double { @_common.max(self.data) }

pub fn TimeserieswintersView::to_string(self : TimeserieswintersView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_range_make(size : Int) -> TimeserieswintersRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeserieswintersRange::len(self : TimeserieswintersRange) -> Int { self.size }

pub fn TimeserieswintersRange::get(self : TimeserieswintersRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeserieswintersRange::set(self : TimeserieswintersRange, i : Int, v : Double) -> TimeserieswintersRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeserieswintersRange::sum(self : TimeserieswintersRange) -> Double { @_common.sum(self.data) }

pub fn TimeserieswintersRange::mean(self : TimeserieswintersRange) -> Double { @_common.mean(self.data) }

pub fn TimeserieswintersRange::scale(self : TimeserieswintersRange, f : Double) -> TimeserieswintersRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersRange::add(self : TimeserieswintersRange, other : TimeserieswintersRange) -> TimeserieswintersRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeserieswintersRange::copy(self : TimeserieswintersRange) -> TimeserieswintersRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersRange::fill(self : TimeserieswintersRange, v : Double) -> TimeserieswintersRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersRange::min(self : TimeserieswintersRange) -> Double { @_common.min(self.data) }

pub fn TimeserieswintersRange::max(self : TimeserieswintersRange) -> Double { @_common.max(self.data) }

pub fn TimeserieswintersRange::to_string(self : TimeserieswintersRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_slice_make(size : Int) -> TimeserieswintersSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeserieswintersSlice::len(self : TimeserieswintersSlice) -> Int { self.size }

pub fn TimeserieswintersSlice::get(self : TimeserieswintersSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeserieswintersSlice::set(self : TimeserieswintersSlice, i : Int, v : Double) -> TimeserieswintersSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeserieswintersSlice::sum(self : TimeserieswintersSlice) -> Double { @_common.sum(self.data) }

pub fn TimeserieswintersSlice::mean(self : TimeserieswintersSlice) -> Double { @_common.mean(self.data) }

pub fn TimeserieswintersSlice::scale(self : TimeserieswintersSlice, f : Double) -> TimeserieswintersSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersSlice::add(self : TimeserieswintersSlice, other : TimeserieswintersSlice) -> TimeserieswintersSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeserieswintersSlice::copy(self : TimeserieswintersSlice) -> TimeserieswintersSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersSlice::fill(self : TimeserieswintersSlice, v : Double) -> TimeserieswintersSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeserieswintersSlice::min(self : TimeserieswintersSlice) -> Double { @_common.min(self.data) }

pub fn TimeserieswintersSlice::max(self : TimeserieswintersSlice) -> Double { @_common.max(self.data) }

pub fn TimeserieswintersSlice::to_string(self : TimeserieswintersSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

