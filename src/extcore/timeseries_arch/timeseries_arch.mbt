///===
/// extcore/timeseries_arch

pub(all) struct TimeseriesarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_arch_make_point(x : Double, y : Double) -> TimeseriesarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_arch_make_point3(x : Double, y : Double, z : Double) -> TimeseriesarchPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesarchPoint::x(self : TimeseriesarchPoint) -> Double { self.x }

pub fn TimeseriesarchPoint::y(self : TimeseriesarchPoint) -> Double { self.y }

pub fn TimeseriesarchPoint::z(self : TimeseriesarchPoint) -> Double { self.z }

pub fn TimeseriesarchPoint::label(self : TimeseriesarchPoint) -> Int { self.label }

pub fn TimeseriesarchPoint::dist(self : TimeseriesarchPoint, other : TimeseriesarchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesarchPoint::add(self : TimeseriesarchPoint, other : TimeseriesarchPoint) -> TimeseriesarchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesarchPoint::sub(self : TimeseriesarchPoint, other : TimeseriesarchPoint) -> TimeseriesarchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesarchPoint::scale(self : TimeseriesarchPoint, s : Double) -> TimeseriesarchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesarchPoint::dot(self : TimeseriesarchPoint, other : TimeseriesarchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesarchPoint::cross(self : TimeseriesarchPoint, other : TimeseriesarchPoint) -> TimeseriesarchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesarchPoint::norm(self : TimeseriesarchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesarchPoint::normalize(self : TimeseriesarchPoint) -> TimeseriesarchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesarchPoint::negate(self : TimeseriesarchPoint) -> TimeseriesarchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesarchPoint::mid(self : TimeseriesarchPoint, other : TimeseriesarchPoint) -> TimeseriesarchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesarchPoint::lerp(self : TimeseriesarchPoint, other : TimeseriesarchPoint, t : Double) -> TimeseriesarchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesarchPoint::to_string(self : TimeseriesarchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_arch_make_series(vals : Array[Double], name : String) -> TimeseriesarchSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesarchSeries::len(self : TimeseriesarchSeries) -> Int { self.vals.length() }

pub fn TimeseriesarchSeries::sum(self : TimeseriesarchSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesarchSeries::mean(self : TimeseriesarchSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesarchSeries::min(self : TimeseriesarchSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesarchSeries::max(self : TimeseriesarchSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesarchSeries::range(self : TimeseriesarchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesarchSeries::variance(self : TimeseriesarchSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesarchSeries::std(self : TimeseriesarchSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesarchSeries::median(self : TimeseriesarchSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesarchSeries::scale(self : TimeseriesarchSeries, f : Double) -> TimeseriesarchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesarchSeries::add(self : TimeseriesarchSeries, other : TimeseriesarchSeries) -> TimeseriesarchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesarchSeries::sub(self : TimeseriesarchSeries, other : TimeseriesarchSeries) -> TimeseriesarchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesarchSeries::normalize(self : TimeseriesarchSeries) -> TimeseriesarchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesarchSeries::cumsum(self : TimeseriesarchSeries) -> TimeseriesarchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesarchSeries::to_string(self : TimeseriesarchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_arch_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_arch_matrix_identity(n : Int) -> TimeseriesarchMatrix {
  let m = timeseries_arch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesarchMatrix::get(self : TimeseriesarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesarchMatrix::transpose(self : TimeseriesarchMatrix) -> TimeseriesarchMatrix {
  let result = timeseries_arch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesarchMatrix::add(self : TimeseriesarchMatrix, other : TimeseriesarchMatrix) -> TimeseriesarchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_arch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesarchMatrix::scale(self : TimeseriesarchMatrix, s : Double) -> TimeseriesarchMatrix {
  let result = timeseries_arch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesarchMatrix::multiply(self : TimeseriesarchMatrix, other : TimeseriesarchMatrix) -> TimeseriesarchMatrix {
  if self.cols != other.rows { return timeseries_arch_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_arch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn TimeseriesarchMatrix::trace(self : TimeseriesarchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesarchMatrix::det(self : TimeseriesarchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesarchMatrix::norm(self : TimeseriesarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesarchMatrix::to_string(self : TimeseriesarchMatrix) -> String {
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

pub(all) struct TimeseriesarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_arch_make_vector(comps : Array[Double]) -> TimeseriesarchVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_arch_vector_zero(dim : Int) -> TimeseriesarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesarchVector::add(self : TimeseriesarchVector, other : TimeseriesarchVector) -> TimeseriesarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesarchVector::sub(self : TimeseriesarchVector, other : TimeseriesarchVector) -> TimeseriesarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesarchVector::scale(self : TimeseriesarchVector, s : Double) -> TimeseriesarchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesarchVector::dot(self : TimeseriesarchVector, other : TimeseriesarchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesarchVector::norm(self : TimeseriesarchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesarchVector::normalize(self : TimeseriesarchVector) -> TimeseriesarchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesarchVector::dist(self : TimeseriesarchVector, other : TimeseriesarchVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesarchVector::to_string(self : TimeseriesarchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_frame_make(size : Int) -> TimeseriesarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarchFrame::len(self : TimeseriesarchFrame) -> Int { self.size }

pub fn TimeseriesarchFrame::get(self : TimeseriesarchFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarchFrame::set(self : TimeseriesarchFrame, i : Int, v : Double) -> TimeseriesarchFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarchFrame::sum(self : TimeseriesarchFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarchFrame::mean(self : TimeseriesarchFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarchFrame::scale(self : TimeseriesarchFrame, f : Double) -> TimeseriesarchFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchFrame::add(self : TimeseriesarchFrame, other : TimeseriesarchFrame) -> TimeseriesarchFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarchFrame::copy(self : TimeseriesarchFrame) -> TimeseriesarchFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchFrame::fill(self : TimeseriesarchFrame, v : Double) -> TimeseriesarchFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchFrame::min(self : TimeseriesarchFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesarchFrame::max(self : TimeseriesarchFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesarchFrame::to_string(self : TimeseriesarchFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_table_make(size : Int) -> TimeseriesarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarchTable::len(self : TimeseriesarchTable) -> Int { self.size }

pub fn TimeseriesarchTable::get(self : TimeseriesarchTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarchTable::set(self : TimeseriesarchTable, i : Int, v : Double) -> TimeseriesarchTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarchTable::sum(self : TimeseriesarchTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarchTable::mean(self : TimeseriesarchTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarchTable::scale(self : TimeseriesarchTable, f : Double) -> TimeseriesarchTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchTable::add(self : TimeseriesarchTable, other : TimeseriesarchTable) -> TimeseriesarchTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarchTable::copy(self : TimeseriesarchTable) -> TimeseriesarchTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchTable::fill(self : TimeseriesarchTable, v : Double) -> TimeseriesarchTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchTable::min(self : TimeseriesarchTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesarchTable::max(self : TimeseriesarchTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesarchTable::to_string(self : TimeseriesarchTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_graphn_make(size : Int) -> TimeseriesarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarchGraphN::len(self : TimeseriesarchGraphN) -> Int { self.size }

pub fn TimeseriesarchGraphN::get(self : TimeseriesarchGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarchGraphN::set(self : TimeseriesarchGraphN, i : Int, v : Double) -> TimeseriesarchGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarchGraphN::sum(self : TimeseriesarchGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarchGraphN::mean(self : TimeseriesarchGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarchGraphN::scale(self : TimeseriesarchGraphN, f : Double) -> TimeseriesarchGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchGraphN::add(self : TimeseriesarchGraphN, other : TimeseriesarchGraphN) -> TimeseriesarchGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarchGraphN::copy(self : TimeseriesarchGraphN) -> TimeseriesarchGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchGraphN::fill(self : TimeseriesarchGraphN, v : Double) -> TimeseriesarchGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchGraphN::min(self : TimeseriesarchGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesarchGraphN::max(self : TimeseriesarchGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesarchGraphN::to_string(self : TimeseriesarchGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_node_make(size : Int) -> TimeseriesarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarchNode::len(self : TimeseriesarchNode) -> Int { self.size }

pub fn TimeseriesarchNode::get(self : TimeseriesarchNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarchNode::set(self : TimeseriesarchNode, i : Int, v : Double) -> TimeseriesarchNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarchNode::sum(self : TimeseriesarchNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarchNode::mean(self : TimeseriesarchNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarchNode::scale(self : TimeseriesarchNode, f : Double) -> TimeseriesarchNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchNode::add(self : TimeseriesarchNode, other : TimeseriesarchNode) -> TimeseriesarchNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarchNode::copy(self : TimeseriesarchNode) -> TimeseriesarchNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchNode::fill(self : TimeseriesarchNode, v : Double) -> TimeseriesarchNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchNode::min(self : TimeseriesarchNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesarchNode::max(self : TimeseriesarchNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesarchNode::to_string(self : TimeseriesarchNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_edge_make(size : Int) -> TimeseriesarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarchEdge::len(self : TimeseriesarchEdge) -> Int { self.size }

pub fn TimeseriesarchEdge::get(self : TimeseriesarchEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarchEdge::set(self : TimeseriesarchEdge, i : Int, v : Double) -> TimeseriesarchEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarchEdge::sum(self : TimeseriesarchEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarchEdge::mean(self : TimeseriesarchEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarchEdge::scale(self : TimeseriesarchEdge, f : Double) -> TimeseriesarchEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchEdge::add(self : TimeseriesarchEdge, other : TimeseriesarchEdge) -> TimeseriesarchEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarchEdge::copy(self : TimeseriesarchEdge) -> TimeseriesarchEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchEdge::fill(self : TimeseriesarchEdge, v : Double) -> TimeseriesarchEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchEdge::min(self : TimeseriesarchEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesarchEdge::max(self : TimeseriesarchEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesarchEdge::to_string(self : TimeseriesarchEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_path_make(size : Int) -> TimeseriesarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarchPath::len(self : TimeseriesarchPath) -> Int { self.size }

pub fn TimeseriesarchPath::get(self : TimeseriesarchPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarchPath::set(self : TimeseriesarchPath, i : Int, v : Double) -> TimeseriesarchPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarchPath::sum(self : TimeseriesarchPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarchPath::mean(self : TimeseriesarchPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarchPath::scale(self : TimeseriesarchPath, f : Double) -> TimeseriesarchPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchPath::add(self : TimeseriesarchPath, other : TimeseriesarchPath) -> TimeseriesarchPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarchPath::copy(self : TimeseriesarchPath) -> TimeseriesarchPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchPath::fill(self : TimeseriesarchPath, v : Double) -> TimeseriesarchPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchPath::min(self : TimeseriesarchPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesarchPath::max(self : TimeseriesarchPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesarchPath::to_string(self : TimeseriesarchPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_cluster_make(size : Int) -> TimeseriesarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarchCluster::len(self : TimeseriesarchCluster) -> Int { self.size }

pub fn TimeseriesarchCluster::get(self : TimeseriesarchCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarchCluster::set(self : TimeseriesarchCluster, i : Int, v : Double) -> TimeseriesarchCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarchCluster::sum(self : TimeseriesarchCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarchCluster::mean(self : TimeseriesarchCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarchCluster::scale(self : TimeseriesarchCluster, f : Double) -> TimeseriesarchCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchCluster::add(self : TimeseriesarchCluster, other : TimeseriesarchCluster) -> TimeseriesarchCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarchCluster::copy(self : TimeseriesarchCluster) -> TimeseriesarchCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchCluster::fill(self : TimeseriesarchCluster, v : Double) -> TimeseriesarchCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchCluster::min(self : TimeseriesarchCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesarchCluster::max(self : TimeseriesarchCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesarchCluster::to_string(self : TimeseriesarchCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_model_make(size : Int) -> TimeseriesarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarchModel::len(self : TimeseriesarchModel) -> Int { self.size }

pub fn TimeseriesarchModel::get(self : TimeseriesarchModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarchModel::set(self : TimeseriesarchModel, i : Int, v : Double) -> TimeseriesarchModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarchModel::sum(self : TimeseriesarchModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarchModel::mean(self : TimeseriesarchModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarchModel::scale(self : TimeseriesarchModel, f : Double) -> TimeseriesarchModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchModel::add(self : TimeseriesarchModel, other : TimeseriesarchModel) -> TimeseriesarchModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarchModel::copy(self : TimeseriesarchModel) -> TimeseriesarchModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchModel::fill(self : TimeseriesarchModel, v : Double) -> TimeseriesarchModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchModel::min(self : TimeseriesarchModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesarchModel::max(self : TimeseriesarchModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesarchModel::to_string(self : TimeseriesarchModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_layer_make(size : Int) -> TimeseriesarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarchLayer::len(self : TimeseriesarchLayer) -> Int { self.size }

pub fn TimeseriesarchLayer::get(self : TimeseriesarchLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarchLayer::set(self : TimeseriesarchLayer, i : Int, v : Double) -> TimeseriesarchLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarchLayer::sum(self : TimeseriesarchLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarchLayer::mean(self : TimeseriesarchLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarchLayer::scale(self : TimeseriesarchLayer, f : Double) -> TimeseriesarchLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchLayer::add(self : TimeseriesarchLayer, other : TimeseriesarchLayer) -> TimeseriesarchLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarchLayer::copy(self : TimeseriesarchLayer) -> TimeseriesarchLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchLayer::fill(self : TimeseriesarchLayer, v : Double) -> TimeseriesarchLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchLayer::min(self : TimeseriesarchLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesarchLayer::max(self : TimeseriesarchLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesarchLayer::to_string(self : TimeseriesarchLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_buffer_make(size : Int) -> TimeseriesarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarchBuffer::len(self : TimeseriesarchBuffer) -> Int { self.size }

pub fn TimeseriesarchBuffer::get(self : TimeseriesarchBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarchBuffer::set(self : TimeseriesarchBuffer, i : Int, v : Double) -> TimeseriesarchBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarchBuffer::sum(self : TimeseriesarchBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarchBuffer::mean(self : TimeseriesarchBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarchBuffer::scale(self : TimeseriesarchBuffer, f : Double) -> TimeseriesarchBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchBuffer::add(self : TimeseriesarchBuffer, other : TimeseriesarchBuffer) -> TimeseriesarchBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarchBuffer::copy(self : TimeseriesarchBuffer) -> TimeseriesarchBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchBuffer::fill(self : TimeseriesarchBuffer, v : Double) -> TimeseriesarchBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchBuffer::min(self : TimeseriesarchBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesarchBuffer::max(self : TimeseriesarchBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesarchBuffer::to_string(self : TimeseriesarchBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_cursor_make(size : Int) -> TimeseriesarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarchCursor::len(self : TimeseriesarchCursor) -> Int { self.size }

pub fn TimeseriesarchCursor::get(self : TimeseriesarchCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarchCursor::set(self : TimeseriesarchCursor, i : Int, v : Double) -> TimeseriesarchCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarchCursor::sum(self : TimeseriesarchCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarchCursor::mean(self : TimeseriesarchCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarchCursor::scale(self : TimeseriesarchCursor, f : Double) -> TimeseriesarchCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchCursor::add(self : TimeseriesarchCursor, other : TimeseriesarchCursor) -> TimeseriesarchCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarchCursor::copy(self : TimeseriesarchCursor) -> TimeseriesarchCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchCursor::fill(self : TimeseriesarchCursor, v : Double) -> TimeseriesarchCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchCursor::min(self : TimeseriesarchCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesarchCursor::max(self : TimeseriesarchCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesarchCursor::to_string(self : TimeseriesarchCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_view_make(size : Int) -> TimeseriesarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarchView::len(self : TimeseriesarchView) -> Int { self.size }

pub fn TimeseriesarchView::get(self : TimeseriesarchView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarchView::set(self : TimeseriesarchView, i : Int, v : Double) -> TimeseriesarchView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarchView::sum(self : TimeseriesarchView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarchView::mean(self : TimeseriesarchView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarchView::scale(self : TimeseriesarchView, f : Double) -> TimeseriesarchView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchView::add(self : TimeseriesarchView, other : TimeseriesarchView) -> TimeseriesarchView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarchView::copy(self : TimeseriesarchView) -> TimeseriesarchView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchView::fill(self : TimeseriesarchView, v : Double) -> TimeseriesarchView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchView::min(self : TimeseriesarchView) -> Double { @_common.min(self.data) }

pub fn TimeseriesarchView::max(self : TimeseriesarchView) -> Double { @_common.max(self.data) }

pub fn TimeseriesarchView::to_string(self : TimeseriesarchView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_range_make(size : Int) -> TimeseriesarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarchRange::len(self : TimeseriesarchRange) -> Int { self.size }

pub fn TimeseriesarchRange::get(self : TimeseriesarchRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarchRange::set(self : TimeseriesarchRange, i : Int, v : Double) -> TimeseriesarchRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarchRange::sum(self : TimeseriesarchRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarchRange::mean(self : TimeseriesarchRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarchRange::scale(self : TimeseriesarchRange, f : Double) -> TimeseriesarchRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchRange::add(self : TimeseriesarchRange, other : TimeseriesarchRange) -> TimeseriesarchRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarchRange::copy(self : TimeseriesarchRange) -> TimeseriesarchRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchRange::fill(self : TimeseriesarchRange, v : Double) -> TimeseriesarchRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchRange::min(self : TimeseriesarchRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesarchRange::max(self : TimeseriesarchRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesarchRange::to_string(self : TimeseriesarchRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_slice_make(size : Int) -> TimeseriesarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesarchSlice::len(self : TimeseriesarchSlice) -> Int { self.size }

pub fn TimeseriesarchSlice::get(self : TimeseriesarchSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesarchSlice::set(self : TimeseriesarchSlice, i : Int, v : Double) -> TimeseriesarchSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesarchSlice::sum(self : TimeseriesarchSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesarchSlice::mean(self : TimeseriesarchSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesarchSlice::scale(self : TimeseriesarchSlice, f : Double) -> TimeseriesarchSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchSlice::add(self : TimeseriesarchSlice, other : TimeseriesarchSlice) -> TimeseriesarchSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesarchSlice::copy(self : TimeseriesarchSlice) -> TimeseriesarchSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchSlice::fill(self : TimeseriesarchSlice, v : Double) -> TimeseriesarchSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesarchSlice::min(self : TimeseriesarchSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesarchSlice::max(self : TimeseriesarchSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesarchSlice::to_string(self : TimeseriesarchSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

