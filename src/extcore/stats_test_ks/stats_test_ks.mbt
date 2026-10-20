///===
/// extcore/stats_test_ks

pub(all) struct StatstestksPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_ks_make_point(x : Double, y : Double) -> StatstestksPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_ks_make_point3(x : Double, y : Double, z : Double) -> StatstestksPoint {
  { x, y, z, label: 0 }
}

pub fn StatstestksPoint::x(self : StatstestksPoint) -> Double { self.x }

pub fn StatstestksPoint::y(self : StatstestksPoint) -> Double { self.y }

pub fn StatstestksPoint::z(self : StatstestksPoint) -> Double { self.z }

pub fn StatstestksPoint::label(self : StatstestksPoint) -> Int { self.label }

pub fn StatstestksPoint::dist(self : StatstestksPoint, other : StatstestksPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatstestksPoint::add(self : StatstestksPoint, other : StatstestksPoint) -> StatstestksPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatstestksPoint::sub(self : StatstestksPoint, other : StatstestksPoint) -> StatstestksPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatstestksPoint::scale(self : StatstestksPoint, s : Double) -> StatstestksPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatstestksPoint::dot(self : StatstestksPoint, other : StatstestksPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatstestksPoint::cross(self : StatstestksPoint, other : StatstestksPoint) -> StatstestksPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatstestksPoint::norm(self : StatstestksPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatstestksPoint::normalize(self : StatstestksPoint) -> StatstestksPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestksPoint::negate(self : StatstestksPoint) -> StatstestksPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatstestksPoint::mid(self : StatstestksPoint, other : StatstestksPoint) -> StatstestksPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatstestksPoint::lerp(self : StatstestksPoint, other : StatstestksPoint, t : Double) -> StatstestksPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatstestksPoint::to_string(self : StatstestksPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatstestksSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_ks_make_series(vals : Array[Double], name : String) -> StatstestksSeries {
  { vals, name, meta: 0 }
}

pub fn StatstestksSeries::len(self : StatstestksSeries) -> Int { self.vals.length() }

pub fn StatstestksSeries::sum(self : StatstestksSeries) -> Double { @_common.sum(self.vals) }

pub fn StatstestksSeries::mean(self : StatstestksSeries) -> Double { @_common.mean(self.vals) }

pub fn StatstestksSeries::min(self : StatstestksSeries) -> Double { @_common.min(self.vals) }

pub fn StatstestksSeries::max(self : StatstestksSeries) -> Double { @_common.max(self.vals) }

pub fn StatstestksSeries::range(self : StatstestksSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatstestksSeries::variance(self : StatstestksSeries) -> Double { @_common.variance(self.vals) }

pub fn StatstestksSeries::std(self : StatstestksSeries) -> Double { @_common.std(self.vals) }

pub fn StatstestksSeries::median(self : StatstestksSeries) -> Double { @_common.median(self.vals) }

pub fn StatstestksSeries::scale(self : StatstestksSeries, f : Double) -> StatstestksSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatstestksSeries::add(self : StatstestksSeries, other : StatstestksSeries) -> StatstestksSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatstestksSeries::sub(self : StatstestksSeries, other : StatstestksSeries) -> StatstestksSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatstestksSeries::normalize(self : StatstestksSeries) -> StatstestksSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatstestksSeries::cumsum(self : StatstestksSeries) -> StatstestksSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatstestksSeries::to_string(self : StatstestksSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestksMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_ks_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestksMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_ks_matrix_identity(n : Int) -> StatstestksMatrix {
  let m = stats_test_ks_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatstestksMatrix::get(self : StatstestksMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatstestksMatrix::transpose(self : StatstestksMatrix) -> StatstestksMatrix {
  let result = stats_test_ks_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatstestksMatrix::add(self : StatstestksMatrix, other : StatstestksMatrix) -> StatstestksMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_test_ks_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatstestksMatrix::scale(self : StatstestksMatrix, s : Double) -> StatstestksMatrix {
  let result = stats_test_ks_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatstestksMatrix::multiply(self : StatstestksMatrix, other : StatstestksMatrix) -> StatstestksMatrix {
  if self.cols != other.rows { return stats_test_ks_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_test_ks_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn StatstestksMatrix::trace(self : StatstestksMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatstestksMatrix::det(self : StatstestksMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatstestksMatrix::norm(self : StatstestksMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatstestksMatrix::to_string(self : StatstestksMatrix) -> String {
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

pub(all) struct StatstestksVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_ks_make_vector(comps : Array[Double]) -> StatstestksVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_ks_vector_zero(dim : Int) -> StatstestksVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatstestksVector::add(self : StatstestksVector, other : StatstestksVector) -> StatstestksVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestksVector::sub(self : StatstestksVector, other : StatstestksVector) -> StatstestksVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestksVector::scale(self : StatstestksVector, s : Double) -> StatstestksVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatstestksVector::dot(self : StatstestksVector, other : StatstestksVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatstestksVector::norm(self : StatstestksVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatstestksVector::normalize(self : StatstestksVector) -> StatstestksVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestksVector::dist(self : StatstestksVector, other : StatstestksVector) -> Double {
  self.sub(other).norm()
}

pub fn StatstestksVector::to_string(self : StatstestksVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestksFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_frame_make(size : Int) -> StatstestksFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestksFrame::len(self : StatstestksFrame) -> Int { self.size }

pub fn StatstestksFrame::get(self : StatstestksFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestksFrame::set(self : StatstestksFrame, i : Int, v : Double) -> StatstestksFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestksFrame::sum(self : StatstestksFrame) -> Double { @_common.sum(self.data) }

pub fn StatstestksFrame::mean(self : StatstestksFrame) -> Double { @_common.mean(self.data) }

pub fn StatstestksFrame::scale(self : StatstestksFrame, f : Double) -> StatstestksFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestksFrame::add(self : StatstestksFrame, other : StatstestksFrame) -> StatstestksFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestksFrame::copy(self : StatstestksFrame) -> StatstestksFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestksFrame::fill(self : StatstestksFrame, v : Double) -> StatstestksFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestksFrame::min(self : StatstestksFrame) -> Double { @_common.min(self.data) }

pub fn StatstestksFrame::max(self : StatstestksFrame) -> Double { @_common.max(self.data) }

pub fn StatstestksFrame::to_string(self : StatstestksFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestksTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_table_make(size : Int) -> StatstestksTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestksTable::len(self : StatstestksTable) -> Int { self.size }

pub fn StatstestksTable::get(self : StatstestksTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestksTable::set(self : StatstestksTable, i : Int, v : Double) -> StatstestksTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestksTable::sum(self : StatstestksTable) -> Double { @_common.sum(self.data) }

pub fn StatstestksTable::mean(self : StatstestksTable) -> Double { @_common.mean(self.data) }

pub fn StatstestksTable::scale(self : StatstestksTable, f : Double) -> StatstestksTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestksTable::add(self : StatstestksTable, other : StatstestksTable) -> StatstestksTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestksTable::copy(self : StatstestksTable) -> StatstestksTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestksTable::fill(self : StatstestksTable, v : Double) -> StatstestksTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestksTable::min(self : StatstestksTable) -> Double { @_common.min(self.data) }

pub fn StatstestksTable::max(self : StatstestksTable) -> Double { @_common.max(self.data) }

pub fn StatstestksTable::to_string(self : StatstestksTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestksGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_graphn_make(size : Int) -> StatstestksGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestksGraphN::len(self : StatstestksGraphN) -> Int { self.size }

pub fn StatstestksGraphN::get(self : StatstestksGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestksGraphN::set(self : StatstestksGraphN, i : Int, v : Double) -> StatstestksGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestksGraphN::sum(self : StatstestksGraphN) -> Double { @_common.sum(self.data) }

pub fn StatstestksGraphN::mean(self : StatstestksGraphN) -> Double { @_common.mean(self.data) }

pub fn StatstestksGraphN::scale(self : StatstestksGraphN, f : Double) -> StatstestksGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestksGraphN::add(self : StatstestksGraphN, other : StatstestksGraphN) -> StatstestksGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestksGraphN::copy(self : StatstestksGraphN) -> StatstestksGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestksGraphN::fill(self : StatstestksGraphN, v : Double) -> StatstestksGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestksGraphN::min(self : StatstestksGraphN) -> Double { @_common.min(self.data) }

pub fn StatstestksGraphN::max(self : StatstestksGraphN) -> Double { @_common.max(self.data) }

pub fn StatstestksGraphN::to_string(self : StatstestksGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestksNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_node_make(size : Int) -> StatstestksNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestksNode::len(self : StatstestksNode) -> Int { self.size }

pub fn StatstestksNode::get(self : StatstestksNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestksNode::set(self : StatstestksNode, i : Int, v : Double) -> StatstestksNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestksNode::sum(self : StatstestksNode) -> Double { @_common.sum(self.data) }

pub fn StatstestksNode::mean(self : StatstestksNode) -> Double { @_common.mean(self.data) }

pub fn StatstestksNode::scale(self : StatstestksNode, f : Double) -> StatstestksNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestksNode::add(self : StatstestksNode, other : StatstestksNode) -> StatstestksNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestksNode::copy(self : StatstestksNode) -> StatstestksNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestksNode::fill(self : StatstestksNode, v : Double) -> StatstestksNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestksNode::min(self : StatstestksNode) -> Double { @_common.min(self.data) }

pub fn StatstestksNode::max(self : StatstestksNode) -> Double { @_common.max(self.data) }

pub fn StatstestksNode::to_string(self : StatstestksNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestksEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_edge_make(size : Int) -> StatstestksEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestksEdge::len(self : StatstestksEdge) -> Int { self.size }

pub fn StatstestksEdge::get(self : StatstestksEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestksEdge::set(self : StatstestksEdge, i : Int, v : Double) -> StatstestksEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestksEdge::sum(self : StatstestksEdge) -> Double { @_common.sum(self.data) }

pub fn StatstestksEdge::mean(self : StatstestksEdge) -> Double { @_common.mean(self.data) }

pub fn StatstestksEdge::scale(self : StatstestksEdge, f : Double) -> StatstestksEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestksEdge::add(self : StatstestksEdge, other : StatstestksEdge) -> StatstestksEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestksEdge::copy(self : StatstestksEdge) -> StatstestksEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestksEdge::fill(self : StatstestksEdge, v : Double) -> StatstestksEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestksEdge::min(self : StatstestksEdge) -> Double { @_common.min(self.data) }

pub fn StatstestksEdge::max(self : StatstestksEdge) -> Double { @_common.max(self.data) }

pub fn StatstestksEdge::to_string(self : StatstestksEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestksPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_path_make(size : Int) -> StatstestksPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestksPath::len(self : StatstestksPath) -> Int { self.size }

pub fn StatstestksPath::get(self : StatstestksPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestksPath::set(self : StatstestksPath, i : Int, v : Double) -> StatstestksPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestksPath::sum(self : StatstestksPath) -> Double { @_common.sum(self.data) }

pub fn StatstestksPath::mean(self : StatstestksPath) -> Double { @_common.mean(self.data) }

pub fn StatstestksPath::scale(self : StatstestksPath, f : Double) -> StatstestksPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestksPath::add(self : StatstestksPath, other : StatstestksPath) -> StatstestksPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestksPath::copy(self : StatstestksPath) -> StatstestksPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestksPath::fill(self : StatstestksPath, v : Double) -> StatstestksPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestksPath::min(self : StatstestksPath) -> Double { @_common.min(self.data) }

pub fn StatstestksPath::max(self : StatstestksPath) -> Double { @_common.max(self.data) }

pub fn StatstestksPath::to_string(self : StatstestksPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestksCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_cluster_make(size : Int) -> StatstestksCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestksCluster::len(self : StatstestksCluster) -> Int { self.size }

pub fn StatstestksCluster::get(self : StatstestksCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestksCluster::set(self : StatstestksCluster, i : Int, v : Double) -> StatstestksCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestksCluster::sum(self : StatstestksCluster) -> Double { @_common.sum(self.data) }

pub fn StatstestksCluster::mean(self : StatstestksCluster) -> Double { @_common.mean(self.data) }

pub fn StatstestksCluster::scale(self : StatstestksCluster, f : Double) -> StatstestksCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestksCluster::add(self : StatstestksCluster, other : StatstestksCluster) -> StatstestksCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestksCluster::copy(self : StatstestksCluster) -> StatstestksCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestksCluster::fill(self : StatstestksCluster, v : Double) -> StatstestksCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestksCluster::min(self : StatstestksCluster) -> Double { @_common.min(self.data) }

pub fn StatstestksCluster::max(self : StatstestksCluster) -> Double { @_common.max(self.data) }

pub fn StatstestksCluster::to_string(self : StatstestksCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestksModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_model_make(size : Int) -> StatstestksModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestksModel::len(self : StatstestksModel) -> Int { self.size }

pub fn StatstestksModel::get(self : StatstestksModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestksModel::set(self : StatstestksModel, i : Int, v : Double) -> StatstestksModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestksModel::sum(self : StatstestksModel) -> Double { @_common.sum(self.data) }

pub fn StatstestksModel::mean(self : StatstestksModel) -> Double { @_common.mean(self.data) }

pub fn StatstestksModel::scale(self : StatstestksModel, f : Double) -> StatstestksModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestksModel::add(self : StatstestksModel, other : StatstestksModel) -> StatstestksModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestksModel::copy(self : StatstestksModel) -> StatstestksModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestksModel::fill(self : StatstestksModel, v : Double) -> StatstestksModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestksModel::min(self : StatstestksModel) -> Double { @_common.min(self.data) }

pub fn StatstestksModel::max(self : StatstestksModel) -> Double { @_common.max(self.data) }

pub fn StatstestksModel::to_string(self : StatstestksModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestksLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_layer_make(size : Int) -> StatstestksLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestksLayer::len(self : StatstestksLayer) -> Int { self.size }

pub fn StatstestksLayer::get(self : StatstestksLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestksLayer::set(self : StatstestksLayer, i : Int, v : Double) -> StatstestksLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestksLayer::sum(self : StatstestksLayer) -> Double { @_common.sum(self.data) }

pub fn StatstestksLayer::mean(self : StatstestksLayer) -> Double { @_common.mean(self.data) }

pub fn StatstestksLayer::scale(self : StatstestksLayer, f : Double) -> StatstestksLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestksLayer::add(self : StatstestksLayer, other : StatstestksLayer) -> StatstestksLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestksLayer::copy(self : StatstestksLayer) -> StatstestksLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestksLayer::fill(self : StatstestksLayer, v : Double) -> StatstestksLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestksLayer::min(self : StatstestksLayer) -> Double { @_common.min(self.data) }

pub fn StatstestksLayer::max(self : StatstestksLayer) -> Double { @_common.max(self.data) }

pub fn StatstestksLayer::to_string(self : StatstestksLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestksBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_buffer_make(size : Int) -> StatstestksBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestksBuffer::len(self : StatstestksBuffer) -> Int { self.size }

pub fn StatstestksBuffer::get(self : StatstestksBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestksBuffer::set(self : StatstestksBuffer, i : Int, v : Double) -> StatstestksBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestksBuffer::sum(self : StatstestksBuffer) -> Double { @_common.sum(self.data) }

pub fn StatstestksBuffer::mean(self : StatstestksBuffer) -> Double { @_common.mean(self.data) }

pub fn StatstestksBuffer::scale(self : StatstestksBuffer, f : Double) -> StatstestksBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestksBuffer::add(self : StatstestksBuffer, other : StatstestksBuffer) -> StatstestksBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestksBuffer::copy(self : StatstestksBuffer) -> StatstestksBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestksBuffer::fill(self : StatstestksBuffer, v : Double) -> StatstestksBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestksBuffer::min(self : StatstestksBuffer) -> Double { @_common.min(self.data) }

pub fn StatstestksBuffer::max(self : StatstestksBuffer) -> Double { @_common.max(self.data) }

pub fn StatstestksBuffer::to_string(self : StatstestksBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestksCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_cursor_make(size : Int) -> StatstestksCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestksCursor::len(self : StatstestksCursor) -> Int { self.size }

pub fn StatstestksCursor::get(self : StatstestksCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestksCursor::set(self : StatstestksCursor, i : Int, v : Double) -> StatstestksCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestksCursor::sum(self : StatstestksCursor) -> Double { @_common.sum(self.data) }

pub fn StatstestksCursor::mean(self : StatstestksCursor) -> Double { @_common.mean(self.data) }

pub fn StatstestksCursor::scale(self : StatstestksCursor, f : Double) -> StatstestksCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestksCursor::add(self : StatstestksCursor, other : StatstestksCursor) -> StatstestksCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestksCursor::copy(self : StatstestksCursor) -> StatstestksCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestksCursor::fill(self : StatstestksCursor, v : Double) -> StatstestksCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestksCursor::min(self : StatstestksCursor) -> Double { @_common.min(self.data) }

pub fn StatstestksCursor::max(self : StatstestksCursor) -> Double { @_common.max(self.data) }

pub fn StatstestksCursor::to_string(self : StatstestksCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestksView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_view_make(size : Int) -> StatstestksView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestksView::len(self : StatstestksView) -> Int { self.size }

pub fn StatstestksView::get(self : StatstestksView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestksView::set(self : StatstestksView, i : Int, v : Double) -> StatstestksView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestksView::sum(self : StatstestksView) -> Double { @_common.sum(self.data) }

pub fn StatstestksView::mean(self : StatstestksView) -> Double { @_common.mean(self.data) }

pub fn StatstestksView::scale(self : StatstestksView, f : Double) -> StatstestksView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestksView::add(self : StatstestksView, other : StatstestksView) -> StatstestksView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestksView::copy(self : StatstestksView) -> StatstestksView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestksView::fill(self : StatstestksView, v : Double) -> StatstestksView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestksView::min(self : StatstestksView) -> Double { @_common.min(self.data) }

pub fn StatstestksView::max(self : StatstestksView) -> Double { @_common.max(self.data) }

pub fn StatstestksView::to_string(self : StatstestksView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestksRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_range_make(size : Int) -> StatstestksRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestksRange::len(self : StatstestksRange) -> Int { self.size }

pub fn StatstestksRange::get(self : StatstestksRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestksRange::set(self : StatstestksRange, i : Int, v : Double) -> StatstestksRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestksRange::sum(self : StatstestksRange) -> Double { @_common.sum(self.data) }

pub fn StatstestksRange::mean(self : StatstestksRange) -> Double { @_common.mean(self.data) }

pub fn StatstestksRange::scale(self : StatstestksRange, f : Double) -> StatstestksRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestksRange::add(self : StatstestksRange, other : StatstestksRange) -> StatstestksRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestksRange::copy(self : StatstestksRange) -> StatstestksRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestksRange::fill(self : StatstestksRange, v : Double) -> StatstestksRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestksRange::min(self : StatstestksRange) -> Double { @_common.min(self.data) }

pub fn StatstestksRange::max(self : StatstestksRange) -> Double { @_common.max(self.data) }

pub fn StatstestksRange::to_string(self : StatstestksRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatstestksSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_slice_make(size : Int) -> StatstestksSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatstestksSlice::len(self : StatstestksSlice) -> Int { self.size }

pub fn StatstestksSlice::get(self : StatstestksSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatstestksSlice::set(self : StatstestksSlice, i : Int, v : Double) -> StatstestksSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatstestksSlice::sum(self : StatstestksSlice) -> Double { @_common.sum(self.data) }

pub fn StatstestksSlice::mean(self : StatstestksSlice) -> Double { @_common.mean(self.data) }

pub fn StatstestksSlice::scale(self : StatstestksSlice, f : Double) -> StatstestksSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatstestksSlice::add(self : StatstestksSlice, other : StatstestksSlice) -> StatstestksSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatstestksSlice::copy(self : StatstestksSlice) -> StatstestksSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatstestksSlice::fill(self : StatstestksSlice, v : Double) -> StatstestksSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatstestksSlice::min(self : StatstestksSlice) -> Double { @_common.min(self.data) }

pub fn StatstestksSlice::max(self : StatstestksSlice) -> Double { @_common.max(self.data) }

pub fn StatstestksSlice::to_string(self : StatstestksSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

