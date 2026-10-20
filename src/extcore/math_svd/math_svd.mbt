///===
/// extcore/math_svd

pub(all) struct MathsvdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_svd_make_point(x : Double, y : Double) -> MathsvdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_svd_make_point3(x : Double, y : Double, z : Double) -> MathsvdPoint {
  { x, y, z, label: 0 }
}

pub fn MathsvdPoint::x(self : MathsvdPoint) -> Double { self.x }

pub fn MathsvdPoint::y(self : MathsvdPoint) -> Double { self.y }

pub fn MathsvdPoint::z(self : MathsvdPoint) -> Double { self.z }

pub fn MathsvdPoint::label(self : MathsvdPoint) -> Int { self.label }

pub fn MathsvdPoint::dist(self : MathsvdPoint, other : MathsvdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathsvdPoint::add(self : MathsvdPoint, other : MathsvdPoint) -> MathsvdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathsvdPoint::sub(self : MathsvdPoint, other : MathsvdPoint) -> MathsvdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathsvdPoint::scale(self : MathsvdPoint, s : Double) -> MathsvdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathsvdPoint::dot(self : MathsvdPoint, other : MathsvdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathsvdPoint::cross(self : MathsvdPoint, other : MathsvdPoint) -> MathsvdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathsvdPoint::norm(self : MathsvdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathsvdPoint::normalize(self : MathsvdPoint) -> MathsvdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathsvdPoint::negate(self : MathsvdPoint) -> MathsvdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathsvdPoint::mid(self : MathsvdPoint, other : MathsvdPoint) -> MathsvdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathsvdPoint::lerp(self : MathsvdPoint, other : MathsvdPoint, t : Double) -> MathsvdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathsvdPoint::to_string(self : MathsvdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathsvdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_svd_make_series(vals : Array[Double], name : String) -> MathsvdSeries {
  { vals, name, meta: 0 }
}

pub fn MathsvdSeries::len(self : MathsvdSeries) -> Int { self.vals.length() }

pub fn MathsvdSeries::sum(self : MathsvdSeries) -> Double { @_common.sum(self.vals) }

pub fn MathsvdSeries::mean(self : MathsvdSeries) -> Double { @_common.mean(self.vals) }

pub fn MathsvdSeries::min(self : MathsvdSeries) -> Double { @_common.min(self.vals) }

pub fn MathsvdSeries::max(self : MathsvdSeries) -> Double { @_common.max(self.vals) }

pub fn MathsvdSeries::range(self : MathsvdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathsvdSeries::variance(self : MathsvdSeries) -> Double { @_common.variance(self.vals) }

pub fn MathsvdSeries::std(self : MathsvdSeries) -> Double { @_common.std(self.vals) }

pub fn MathsvdSeries::median(self : MathsvdSeries) -> Double { @_common.median(self.vals) }

pub fn MathsvdSeries::scale(self : MathsvdSeries, f : Double) -> MathsvdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathsvdSeries::add(self : MathsvdSeries, other : MathsvdSeries) -> MathsvdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathsvdSeries::sub(self : MathsvdSeries, other : MathsvdSeries) -> MathsvdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathsvdSeries::normalize(self : MathsvdSeries) -> MathsvdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathsvdSeries::cumsum(self : MathsvdSeries) -> MathsvdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathsvdSeries::to_string(self : MathsvdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathsvdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_svd_make_matrix(rows : Int, cols : Int, val : Double) -> MathsvdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_svd_matrix_identity(n : Int) -> MathsvdMatrix {
  let m = math_svd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathsvdMatrix::get(self : MathsvdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathsvdMatrix::transpose(self : MathsvdMatrix) -> MathsvdMatrix {
  let result = math_svd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathsvdMatrix::add(self : MathsvdMatrix, other : MathsvdMatrix) -> MathsvdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_svd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathsvdMatrix::scale(self : MathsvdMatrix, s : Double) -> MathsvdMatrix {
  let result = math_svd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathsvdMatrix::multiply(self : MathsvdMatrix, other : MathsvdMatrix) -> MathsvdMatrix {
  if self.cols != other.rows { return math_svd_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_svd_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathsvdMatrix::trace(self : MathsvdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathsvdMatrix::det(self : MathsvdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathsvdMatrix::norm(self : MathsvdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathsvdMatrix::to_string(self : MathsvdMatrix) -> String {
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

pub(all) struct MathsvdVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_svd_make_vector(comps : Array[Double]) -> MathsvdVector {
  { comps, dim: comps.length() }
}

pub fn math_svd_vector_zero(dim : Int) -> MathsvdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathsvdVector::add(self : MathsvdVector, other : MathsvdVector) -> MathsvdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathsvdVector::sub(self : MathsvdVector, other : MathsvdVector) -> MathsvdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathsvdVector::scale(self : MathsvdVector, s : Double) -> MathsvdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathsvdVector::dot(self : MathsvdVector, other : MathsvdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathsvdVector::norm(self : MathsvdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathsvdVector::normalize(self : MathsvdVector) -> MathsvdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathsvdVector::dist(self : MathsvdVector, other : MathsvdVector) -> Double {
  self.sub(other).norm()
}

pub fn MathsvdVector::to_string(self : MathsvdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathsvdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_frame_make(size : Int) -> MathsvdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsvdFrame::len(self : MathsvdFrame) -> Int { self.size }

pub fn MathsvdFrame::get(self : MathsvdFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsvdFrame::set(self : MathsvdFrame, i : Int, v : Double) -> MathsvdFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsvdFrame::sum(self : MathsvdFrame) -> Double { @_common.sum(self.data) }

pub fn MathsvdFrame::mean(self : MathsvdFrame) -> Double { @_common.mean(self.data) }

pub fn MathsvdFrame::scale(self : MathsvdFrame, f : Double) -> MathsvdFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsvdFrame::add(self : MathsvdFrame, other : MathsvdFrame) -> MathsvdFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsvdFrame::copy(self : MathsvdFrame) -> MathsvdFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsvdFrame::fill(self : MathsvdFrame, v : Double) -> MathsvdFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsvdFrame::min(self : MathsvdFrame) -> Double { @_common.min(self.data) }

pub fn MathsvdFrame::max(self : MathsvdFrame) -> Double { @_common.max(self.data) }

pub fn MathsvdFrame::to_string(self : MathsvdFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsvdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_table_make(size : Int) -> MathsvdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsvdTable::len(self : MathsvdTable) -> Int { self.size }

pub fn MathsvdTable::get(self : MathsvdTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsvdTable::set(self : MathsvdTable, i : Int, v : Double) -> MathsvdTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsvdTable::sum(self : MathsvdTable) -> Double { @_common.sum(self.data) }

pub fn MathsvdTable::mean(self : MathsvdTable) -> Double { @_common.mean(self.data) }

pub fn MathsvdTable::scale(self : MathsvdTable, f : Double) -> MathsvdTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsvdTable::add(self : MathsvdTable, other : MathsvdTable) -> MathsvdTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsvdTable::copy(self : MathsvdTable) -> MathsvdTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsvdTable::fill(self : MathsvdTable, v : Double) -> MathsvdTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsvdTable::min(self : MathsvdTable) -> Double { @_common.min(self.data) }

pub fn MathsvdTable::max(self : MathsvdTable) -> Double { @_common.max(self.data) }

pub fn MathsvdTable::to_string(self : MathsvdTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsvdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_graphn_make(size : Int) -> MathsvdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsvdGraphN::len(self : MathsvdGraphN) -> Int { self.size }

pub fn MathsvdGraphN::get(self : MathsvdGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsvdGraphN::set(self : MathsvdGraphN, i : Int, v : Double) -> MathsvdGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsvdGraphN::sum(self : MathsvdGraphN) -> Double { @_common.sum(self.data) }

pub fn MathsvdGraphN::mean(self : MathsvdGraphN) -> Double { @_common.mean(self.data) }

pub fn MathsvdGraphN::scale(self : MathsvdGraphN, f : Double) -> MathsvdGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsvdGraphN::add(self : MathsvdGraphN, other : MathsvdGraphN) -> MathsvdGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsvdGraphN::copy(self : MathsvdGraphN) -> MathsvdGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsvdGraphN::fill(self : MathsvdGraphN, v : Double) -> MathsvdGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsvdGraphN::min(self : MathsvdGraphN) -> Double { @_common.min(self.data) }

pub fn MathsvdGraphN::max(self : MathsvdGraphN) -> Double { @_common.max(self.data) }

pub fn MathsvdGraphN::to_string(self : MathsvdGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsvdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_node_make(size : Int) -> MathsvdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsvdNode::len(self : MathsvdNode) -> Int { self.size }

pub fn MathsvdNode::get(self : MathsvdNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsvdNode::set(self : MathsvdNode, i : Int, v : Double) -> MathsvdNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsvdNode::sum(self : MathsvdNode) -> Double { @_common.sum(self.data) }

pub fn MathsvdNode::mean(self : MathsvdNode) -> Double { @_common.mean(self.data) }

pub fn MathsvdNode::scale(self : MathsvdNode, f : Double) -> MathsvdNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsvdNode::add(self : MathsvdNode, other : MathsvdNode) -> MathsvdNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsvdNode::copy(self : MathsvdNode) -> MathsvdNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsvdNode::fill(self : MathsvdNode, v : Double) -> MathsvdNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsvdNode::min(self : MathsvdNode) -> Double { @_common.min(self.data) }

pub fn MathsvdNode::max(self : MathsvdNode) -> Double { @_common.max(self.data) }

pub fn MathsvdNode::to_string(self : MathsvdNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsvdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_edge_make(size : Int) -> MathsvdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsvdEdge::len(self : MathsvdEdge) -> Int { self.size }

pub fn MathsvdEdge::get(self : MathsvdEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsvdEdge::set(self : MathsvdEdge, i : Int, v : Double) -> MathsvdEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsvdEdge::sum(self : MathsvdEdge) -> Double { @_common.sum(self.data) }

pub fn MathsvdEdge::mean(self : MathsvdEdge) -> Double { @_common.mean(self.data) }

pub fn MathsvdEdge::scale(self : MathsvdEdge, f : Double) -> MathsvdEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsvdEdge::add(self : MathsvdEdge, other : MathsvdEdge) -> MathsvdEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsvdEdge::copy(self : MathsvdEdge) -> MathsvdEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsvdEdge::fill(self : MathsvdEdge, v : Double) -> MathsvdEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsvdEdge::min(self : MathsvdEdge) -> Double { @_common.min(self.data) }

pub fn MathsvdEdge::max(self : MathsvdEdge) -> Double { @_common.max(self.data) }

pub fn MathsvdEdge::to_string(self : MathsvdEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsvdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_path_make(size : Int) -> MathsvdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsvdPath::len(self : MathsvdPath) -> Int { self.size }

pub fn MathsvdPath::get(self : MathsvdPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsvdPath::set(self : MathsvdPath, i : Int, v : Double) -> MathsvdPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsvdPath::sum(self : MathsvdPath) -> Double { @_common.sum(self.data) }

pub fn MathsvdPath::mean(self : MathsvdPath) -> Double { @_common.mean(self.data) }

pub fn MathsvdPath::scale(self : MathsvdPath, f : Double) -> MathsvdPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsvdPath::add(self : MathsvdPath, other : MathsvdPath) -> MathsvdPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsvdPath::copy(self : MathsvdPath) -> MathsvdPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsvdPath::fill(self : MathsvdPath, v : Double) -> MathsvdPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsvdPath::min(self : MathsvdPath) -> Double { @_common.min(self.data) }

pub fn MathsvdPath::max(self : MathsvdPath) -> Double { @_common.max(self.data) }

pub fn MathsvdPath::to_string(self : MathsvdPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsvdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_cluster_make(size : Int) -> MathsvdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsvdCluster::len(self : MathsvdCluster) -> Int { self.size }

pub fn MathsvdCluster::get(self : MathsvdCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsvdCluster::set(self : MathsvdCluster, i : Int, v : Double) -> MathsvdCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsvdCluster::sum(self : MathsvdCluster) -> Double { @_common.sum(self.data) }

pub fn MathsvdCluster::mean(self : MathsvdCluster) -> Double { @_common.mean(self.data) }

pub fn MathsvdCluster::scale(self : MathsvdCluster, f : Double) -> MathsvdCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsvdCluster::add(self : MathsvdCluster, other : MathsvdCluster) -> MathsvdCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsvdCluster::copy(self : MathsvdCluster) -> MathsvdCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsvdCluster::fill(self : MathsvdCluster, v : Double) -> MathsvdCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsvdCluster::min(self : MathsvdCluster) -> Double { @_common.min(self.data) }

pub fn MathsvdCluster::max(self : MathsvdCluster) -> Double { @_common.max(self.data) }

pub fn MathsvdCluster::to_string(self : MathsvdCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsvdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_model_make(size : Int) -> MathsvdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsvdModel::len(self : MathsvdModel) -> Int { self.size }

pub fn MathsvdModel::get(self : MathsvdModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsvdModel::set(self : MathsvdModel, i : Int, v : Double) -> MathsvdModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsvdModel::sum(self : MathsvdModel) -> Double { @_common.sum(self.data) }

pub fn MathsvdModel::mean(self : MathsvdModel) -> Double { @_common.mean(self.data) }

pub fn MathsvdModel::scale(self : MathsvdModel, f : Double) -> MathsvdModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsvdModel::add(self : MathsvdModel, other : MathsvdModel) -> MathsvdModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsvdModel::copy(self : MathsvdModel) -> MathsvdModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsvdModel::fill(self : MathsvdModel, v : Double) -> MathsvdModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsvdModel::min(self : MathsvdModel) -> Double { @_common.min(self.data) }

pub fn MathsvdModel::max(self : MathsvdModel) -> Double { @_common.max(self.data) }

pub fn MathsvdModel::to_string(self : MathsvdModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsvdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_layer_make(size : Int) -> MathsvdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsvdLayer::len(self : MathsvdLayer) -> Int { self.size }

pub fn MathsvdLayer::get(self : MathsvdLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsvdLayer::set(self : MathsvdLayer, i : Int, v : Double) -> MathsvdLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsvdLayer::sum(self : MathsvdLayer) -> Double { @_common.sum(self.data) }

pub fn MathsvdLayer::mean(self : MathsvdLayer) -> Double { @_common.mean(self.data) }

pub fn MathsvdLayer::scale(self : MathsvdLayer, f : Double) -> MathsvdLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsvdLayer::add(self : MathsvdLayer, other : MathsvdLayer) -> MathsvdLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsvdLayer::copy(self : MathsvdLayer) -> MathsvdLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsvdLayer::fill(self : MathsvdLayer, v : Double) -> MathsvdLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsvdLayer::min(self : MathsvdLayer) -> Double { @_common.min(self.data) }

pub fn MathsvdLayer::max(self : MathsvdLayer) -> Double { @_common.max(self.data) }

pub fn MathsvdLayer::to_string(self : MathsvdLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsvdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_buffer_make(size : Int) -> MathsvdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsvdBuffer::len(self : MathsvdBuffer) -> Int { self.size }

pub fn MathsvdBuffer::get(self : MathsvdBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsvdBuffer::set(self : MathsvdBuffer, i : Int, v : Double) -> MathsvdBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsvdBuffer::sum(self : MathsvdBuffer) -> Double { @_common.sum(self.data) }

pub fn MathsvdBuffer::mean(self : MathsvdBuffer) -> Double { @_common.mean(self.data) }

pub fn MathsvdBuffer::scale(self : MathsvdBuffer, f : Double) -> MathsvdBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsvdBuffer::add(self : MathsvdBuffer, other : MathsvdBuffer) -> MathsvdBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsvdBuffer::copy(self : MathsvdBuffer) -> MathsvdBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsvdBuffer::fill(self : MathsvdBuffer, v : Double) -> MathsvdBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsvdBuffer::min(self : MathsvdBuffer) -> Double { @_common.min(self.data) }

pub fn MathsvdBuffer::max(self : MathsvdBuffer) -> Double { @_common.max(self.data) }

pub fn MathsvdBuffer::to_string(self : MathsvdBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsvdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_cursor_make(size : Int) -> MathsvdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsvdCursor::len(self : MathsvdCursor) -> Int { self.size }

pub fn MathsvdCursor::get(self : MathsvdCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsvdCursor::set(self : MathsvdCursor, i : Int, v : Double) -> MathsvdCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsvdCursor::sum(self : MathsvdCursor) -> Double { @_common.sum(self.data) }

pub fn MathsvdCursor::mean(self : MathsvdCursor) -> Double { @_common.mean(self.data) }

pub fn MathsvdCursor::scale(self : MathsvdCursor, f : Double) -> MathsvdCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsvdCursor::add(self : MathsvdCursor, other : MathsvdCursor) -> MathsvdCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsvdCursor::copy(self : MathsvdCursor) -> MathsvdCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsvdCursor::fill(self : MathsvdCursor, v : Double) -> MathsvdCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsvdCursor::min(self : MathsvdCursor) -> Double { @_common.min(self.data) }

pub fn MathsvdCursor::max(self : MathsvdCursor) -> Double { @_common.max(self.data) }

pub fn MathsvdCursor::to_string(self : MathsvdCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsvdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_view_make(size : Int) -> MathsvdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsvdView::len(self : MathsvdView) -> Int { self.size }

pub fn MathsvdView::get(self : MathsvdView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsvdView::set(self : MathsvdView, i : Int, v : Double) -> MathsvdView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsvdView::sum(self : MathsvdView) -> Double { @_common.sum(self.data) }

pub fn MathsvdView::mean(self : MathsvdView) -> Double { @_common.mean(self.data) }

pub fn MathsvdView::scale(self : MathsvdView, f : Double) -> MathsvdView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsvdView::add(self : MathsvdView, other : MathsvdView) -> MathsvdView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsvdView::copy(self : MathsvdView) -> MathsvdView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsvdView::fill(self : MathsvdView, v : Double) -> MathsvdView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsvdView::min(self : MathsvdView) -> Double { @_common.min(self.data) }

pub fn MathsvdView::max(self : MathsvdView) -> Double { @_common.max(self.data) }

pub fn MathsvdView::to_string(self : MathsvdView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsvdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_range_make(size : Int) -> MathsvdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsvdRange::len(self : MathsvdRange) -> Int { self.size }

pub fn MathsvdRange::get(self : MathsvdRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsvdRange::set(self : MathsvdRange, i : Int, v : Double) -> MathsvdRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsvdRange::sum(self : MathsvdRange) -> Double { @_common.sum(self.data) }

pub fn MathsvdRange::mean(self : MathsvdRange) -> Double { @_common.mean(self.data) }

pub fn MathsvdRange::scale(self : MathsvdRange, f : Double) -> MathsvdRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsvdRange::add(self : MathsvdRange, other : MathsvdRange) -> MathsvdRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsvdRange::copy(self : MathsvdRange) -> MathsvdRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsvdRange::fill(self : MathsvdRange, v : Double) -> MathsvdRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsvdRange::min(self : MathsvdRange) -> Double { @_common.min(self.data) }

pub fn MathsvdRange::max(self : MathsvdRange) -> Double { @_common.max(self.data) }

pub fn MathsvdRange::to_string(self : MathsvdRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathsvdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_slice_make(size : Int) -> MathsvdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathsvdSlice::len(self : MathsvdSlice) -> Int { self.size }

pub fn MathsvdSlice::get(self : MathsvdSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathsvdSlice::set(self : MathsvdSlice, i : Int, v : Double) -> MathsvdSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathsvdSlice::sum(self : MathsvdSlice) -> Double { @_common.sum(self.data) }

pub fn MathsvdSlice::mean(self : MathsvdSlice) -> Double { @_common.mean(self.data) }

pub fn MathsvdSlice::scale(self : MathsvdSlice, f : Double) -> MathsvdSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathsvdSlice::add(self : MathsvdSlice, other : MathsvdSlice) -> MathsvdSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathsvdSlice::copy(self : MathsvdSlice) -> MathsvdSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathsvdSlice::fill(self : MathsvdSlice, v : Double) -> MathsvdSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathsvdSlice::min(self : MathsvdSlice) -> Double { @_common.min(self.data) }

pub fn MathsvdSlice::max(self : MathsvdSlice) -> Double { @_common.max(self.data) }

pub fn MathsvdSlice::to_string(self : MathsvdSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

