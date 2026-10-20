///===
/// extcore/opt_meta_ga

pub(all) struct OptmetagaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_ga_make_point(x : Double, y : Double) -> OptmetagaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_ga_make_point3(x : Double, y : Double, z : Double) -> OptmetagaPoint {
  { x, y, z, label: 0 }
}

pub fn OptmetagaPoint::x(self : OptmetagaPoint) -> Double { self.x }

pub fn OptmetagaPoint::y(self : OptmetagaPoint) -> Double { self.y }

pub fn OptmetagaPoint::z(self : OptmetagaPoint) -> Double { self.z }

pub fn OptmetagaPoint::label(self : OptmetagaPoint) -> Int { self.label }

pub fn OptmetagaPoint::dist(self : OptmetagaPoint, other : OptmetagaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptmetagaPoint::add(self : OptmetagaPoint, other : OptmetagaPoint) -> OptmetagaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptmetagaPoint::sub(self : OptmetagaPoint, other : OptmetagaPoint) -> OptmetagaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptmetagaPoint::scale(self : OptmetagaPoint, s : Double) -> OptmetagaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptmetagaPoint::dot(self : OptmetagaPoint, other : OptmetagaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptmetagaPoint::cross(self : OptmetagaPoint, other : OptmetagaPoint) -> OptmetagaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptmetagaPoint::norm(self : OptmetagaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptmetagaPoint::normalize(self : OptmetagaPoint) -> OptmetagaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetagaPoint::negate(self : OptmetagaPoint) -> OptmetagaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptmetagaPoint::mid(self : OptmetagaPoint, other : OptmetagaPoint) -> OptmetagaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptmetagaPoint::lerp(self : OptmetagaPoint, other : OptmetagaPoint, t : Double) -> OptmetagaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptmetagaPoint::to_string(self : OptmetagaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptmetagaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_ga_make_series(vals : Array[Double], name : String) -> OptmetagaSeries {
  { vals, name, meta: 0 }
}

pub fn OptmetagaSeries::len(self : OptmetagaSeries) -> Int { self.vals.length() }

pub fn OptmetagaSeries::sum(self : OptmetagaSeries) -> Double { @_common.sum(self.vals) }

pub fn OptmetagaSeries::mean(self : OptmetagaSeries) -> Double { @_common.mean(self.vals) }

pub fn OptmetagaSeries::min(self : OptmetagaSeries) -> Double { @_common.min(self.vals) }

pub fn OptmetagaSeries::max(self : OptmetagaSeries) -> Double { @_common.max(self.vals) }

pub fn OptmetagaSeries::range(self : OptmetagaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptmetagaSeries::variance(self : OptmetagaSeries) -> Double { @_common.variance(self.vals) }

pub fn OptmetagaSeries::std(self : OptmetagaSeries) -> Double { @_common.std(self.vals) }

pub fn OptmetagaSeries::median(self : OptmetagaSeries) -> Double { @_common.median(self.vals) }

pub fn OptmetagaSeries::scale(self : OptmetagaSeries, f : Double) -> OptmetagaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptmetagaSeries::add(self : OptmetagaSeries, other : OptmetagaSeries) -> OptmetagaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptmetagaSeries::sub(self : OptmetagaSeries, other : OptmetagaSeries) -> OptmetagaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptmetagaSeries::normalize(self : OptmetagaSeries) -> OptmetagaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptmetagaSeries::cumsum(self : OptmetagaSeries) -> OptmetagaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptmetagaSeries::to_string(self : OptmetagaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetagaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_ga_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetagaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_ga_matrix_identity(n : Int) -> OptmetagaMatrix {
  let m = opt_meta_ga_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptmetagaMatrix::get(self : OptmetagaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptmetagaMatrix::transpose(self : OptmetagaMatrix) -> OptmetagaMatrix {
  let result = opt_meta_ga_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptmetagaMatrix::add(self : OptmetagaMatrix, other : OptmetagaMatrix) -> OptmetagaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_meta_ga_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptmetagaMatrix::scale(self : OptmetagaMatrix, s : Double) -> OptmetagaMatrix {
  let result = opt_meta_ga_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptmetagaMatrix::multiply(self : OptmetagaMatrix, other : OptmetagaMatrix) -> OptmetagaMatrix {
  if self.cols != other.rows { return opt_meta_ga_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_meta_ga_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn OptmetagaMatrix::trace(self : OptmetagaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptmetagaMatrix::det(self : OptmetagaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptmetagaMatrix::norm(self : OptmetagaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptmetagaMatrix::to_string(self : OptmetagaMatrix) -> String {
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

pub(all) struct OptmetagaVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_ga_make_vector(comps : Array[Double]) -> OptmetagaVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_ga_vector_zero(dim : Int) -> OptmetagaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptmetagaVector::add(self : OptmetagaVector, other : OptmetagaVector) -> OptmetagaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetagaVector::sub(self : OptmetagaVector, other : OptmetagaVector) -> OptmetagaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetagaVector::scale(self : OptmetagaVector, s : Double) -> OptmetagaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptmetagaVector::dot(self : OptmetagaVector, other : OptmetagaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptmetagaVector::norm(self : OptmetagaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptmetagaVector::normalize(self : OptmetagaVector) -> OptmetagaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetagaVector::dist(self : OptmetagaVector, other : OptmetagaVector) -> Double {
  self.sub(other).norm()
}

pub fn OptmetagaVector::to_string(self : OptmetagaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetagaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_frame_make(size : Int) -> OptmetagaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetagaFrame::len(self : OptmetagaFrame) -> Int { self.size }

pub fn OptmetagaFrame::get(self : OptmetagaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetagaFrame::set(self : OptmetagaFrame, i : Int, v : Double) -> OptmetagaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetagaFrame::sum(self : OptmetagaFrame) -> Double { @_common.sum(self.data) }

pub fn OptmetagaFrame::mean(self : OptmetagaFrame) -> Double { @_common.mean(self.data) }

pub fn OptmetagaFrame::scale(self : OptmetagaFrame, f : Double) -> OptmetagaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetagaFrame::add(self : OptmetagaFrame, other : OptmetagaFrame) -> OptmetagaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetagaFrame::copy(self : OptmetagaFrame) -> OptmetagaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetagaFrame::fill(self : OptmetagaFrame, v : Double) -> OptmetagaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetagaFrame::min(self : OptmetagaFrame) -> Double { @_common.min(self.data) }

pub fn OptmetagaFrame::max(self : OptmetagaFrame) -> Double { @_common.max(self.data) }

pub fn OptmetagaFrame::to_string(self : OptmetagaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetagaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_table_make(size : Int) -> OptmetagaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetagaTable::len(self : OptmetagaTable) -> Int { self.size }

pub fn OptmetagaTable::get(self : OptmetagaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetagaTable::set(self : OptmetagaTable, i : Int, v : Double) -> OptmetagaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetagaTable::sum(self : OptmetagaTable) -> Double { @_common.sum(self.data) }

pub fn OptmetagaTable::mean(self : OptmetagaTable) -> Double { @_common.mean(self.data) }

pub fn OptmetagaTable::scale(self : OptmetagaTable, f : Double) -> OptmetagaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetagaTable::add(self : OptmetagaTable, other : OptmetagaTable) -> OptmetagaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetagaTable::copy(self : OptmetagaTable) -> OptmetagaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetagaTable::fill(self : OptmetagaTable, v : Double) -> OptmetagaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetagaTable::min(self : OptmetagaTable) -> Double { @_common.min(self.data) }

pub fn OptmetagaTable::max(self : OptmetagaTable) -> Double { @_common.max(self.data) }

pub fn OptmetagaTable::to_string(self : OptmetagaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetagaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_graphn_make(size : Int) -> OptmetagaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetagaGraphN::len(self : OptmetagaGraphN) -> Int { self.size }

pub fn OptmetagaGraphN::get(self : OptmetagaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetagaGraphN::set(self : OptmetagaGraphN, i : Int, v : Double) -> OptmetagaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetagaGraphN::sum(self : OptmetagaGraphN) -> Double { @_common.sum(self.data) }

pub fn OptmetagaGraphN::mean(self : OptmetagaGraphN) -> Double { @_common.mean(self.data) }

pub fn OptmetagaGraphN::scale(self : OptmetagaGraphN, f : Double) -> OptmetagaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetagaGraphN::add(self : OptmetagaGraphN, other : OptmetagaGraphN) -> OptmetagaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetagaGraphN::copy(self : OptmetagaGraphN) -> OptmetagaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetagaGraphN::fill(self : OptmetagaGraphN, v : Double) -> OptmetagaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetagaGraphN::min(self : OptmetagaGraphN) -> Double { @_common.min(self.data) }

pub fn OptmetagaGraphN::max(self : OptmetagaGraphN) -> Double { @_common.max(self.data) }

pub fn OptmetagaGraphN::to_string(self : OptmetagaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetagaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_node_make(size : Int) -> OptmetagaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetagaNode::len(self : OptmetagaNode) -> Int { self.size }

pub fn OptmetagaNode::get(self : OptmetagaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetagaNode::set(self : OptmetagaNode, i : Int, v : Double) -> OptmetagaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetagaNode::sum(self : OptmetagaNode) -> Double { @_common.sum(self.data) }

pub fn OptmetagaNode::mean(self : OptmetagaNode) -> Double { @_common.mean(self.data) }

pub fn OptmetagaNode::scale(self : OptmetagaNode, f : Double) -> OptmetagaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetagaNode::add(self : OptmetagaNode, other : OptmetagaNode) -> OptmetagaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetagaNode::copy(self : OptmetagaNode) -> OptmetagaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetagaNode::fill(self : OptmetagaNode, v : Double) -> OptmetagaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetagaNode::min(self : OptmetagaNode) -> Double { @_common.min(self.data) }

pub fn OptmetagaNode::max(self : OptmetagaNode) -> Double { @_common.max(self.data) }

pub fn OptmetagaNode::to_string(self : OptmetagaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetagaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_edge_make(size : Int) -> OptmetagaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetagaEdge::len(self : OptmetagaEdge) -> Int { self.size }

pub fn OptmetagaEdge::get(self : OptmetagaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetagaEdge::set(self : OptmetagaEdge, i : Int, v : Double) -> OptmetagaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetagaEdge::sum(self : OptmetagaEdge) -> Double { @_common.sum(self.data) }

pub fn OptmetagaEdge::mean(self : OptmetagaEdge) -> Double { @_common.mean(self.data) }

pub fn OptmetagaEdge::scale(self : OptmetagaEdge, f : Double) -> OptmetagaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetagaEdge::add(self : OptmetagaEdge, other : OptmetagaEdge) -> OptmetagaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetagaEdge::copy(self : OptmetagaEdge) -> OptmetagaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetagaEdge::fill(self : OptmetagaEdge, v : Double) -> OptmetagaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetagaEdge::min(self : OptmetagaEdge) -> Double { @_common.min(self.data) }

pub fn OptmetagaEdge::max(self : OptmetagaEdge) -> Double { @_common.max(self.data) }

pub fn OptmetagaEdge::to_string(self : OptmetagaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetagaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_path_make(size : Int) -> OptmetagaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetagaPath::len(self : OptmetagaPath) -> Int { self.size }

pub fn OptmetagaPath::get(self : OptmetagaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetagaPath::set(self : OptmetagaPath, i : Int, v : Double) -> OptmetagaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetagaPath::sum(self : OptmetagaPath) -> Double { @_common.sum(self.data) }

pub fn OptmetagaPath::mean(self : OptmetagaPath) -> Double { @_common.mean(self.data) }

pub fn OptmetagaPath::scale(self : OptmetagaPath, f : Double) -> OptmetagaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetagaPath::add(self : OptmetagaPath, other : OptmetagaPath) -> OptmetagaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetagaPath::copy(self : OptmetagaPath) -> OptmetagaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetagaPath::fill(self : OptmetagaPath, v : Double) -> OptmetagaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetagaPath::min(self : OptmetagaPath) -> Double { @_common.min(self.data) }

pub fn OptmetagaPath::max(self : OptmetagaPath) -> Double { @_common.max(self.data) }

pub fn OptmetagaPath::to_string(self : OptmetagaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetagaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_cluster_make(size : Int) -> OptmetagaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetagaCluster::len(self : OptmetagaCluster) -> Int { self.size }

pub fn OptmetagaCluster::get(self : OptmetagaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetagaCluster::set(self : OptmetagaCluster, i : Int, v : Double) -> OptmetagaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetagaCluster::sum(self : OptmetagaCluster) -> Double { @_common.sum(self.data) }

pub fn OptmetagaCluster::mean(self : OptmetagaCluster) -> Double { @_common.mean(self.data) }

pub fn OptmetagaCluster::scale(self : OptmetagaCluster, f : Double) -> OptmetagaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetagaCluster::add(self : OptmetagaCluster, other : OptmetagaCluster) -> OptmetagaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetagaCluster::copy(self : OptmetagaCluster) -> OptmetagaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetagaCluster::fill(self : OptmetagaCluster, v : Double) -> OptmetagaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetagaCluster::min(self : OptmetagaCluster) -> Double { @_common.min(self.data) }

pub fn OptmetagaCluster::max(self : OptmetagaCluster) -> Double { @_common.max(self.data) }

pub fn OptmetagaCluster::to_string(self : OptmetagaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetagaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_model_make(size : Int) -> OptmetagaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetagaModel::len(self : OptmetagaModel) -> Int { self.size }

pub fn OptmetagaModel::get(self : OptmetagaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetagaModel::set(self : OptmetagaModel, i : Int, v : Double) -> OptmetagaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetagaModel::sum(self : OptmetagaModel) -> Double { @_common.sum(self.data) }

pub fn OptmetagaModel::mean(self : OptmetagaModel) -> Double { @_common.mean(self.data) }

pub fn OptmetagaModel::scale(self : OptmetagaModel, f : Double) -> OptmetagaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetagaModel::add(self : OptmetagaModel, other : OptmetagaModel) -> OptmetagaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetagaModel::copy(self : OptmetagaModel) -> OptmetagaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetagaModel::fill(self : OptmetagaModel, v : Double) -> OptmetagaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetagaModel::min(self : OptmetagaModel) -> Double { @_common.min(self.data) }

pub fn OptmetagaModel::max(self : OptmetagaModel) -> Double { @_common.max(self.data) }

pub fn OptmetagaModel::to_string(self : OptmetagaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetagaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_layer_make(size : Int) -> OptmetagaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetagaLayer::len(self : OptmetagaLayer) -> Int { self.size }

pub fn OptmetagaLayer::get(self : OptmetagaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetagaLayer::set(self : OptmetagaLayer, i : Int, v : Double) -> OptmetagaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetagaLayer::sum(self : OptmetagaLayer) -> Double { @_common.sum(self.data) }

pub fn OptmetagaLayer::mean(self : OptmetagaLayer) -> Double { @_common.mean(self.data) }

pub fn OptmetagaLayer::scale(self : OptmetagaLayer, f : Double) -> OptmetagaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetagaLayer::add(self : OptmetagaLayer, other : OptmetagaLayer) -> OptmetagaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetagaLayer::copy(self : OptmetagaLayer) -> OptmetagaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetagaLayer::fill(self : OptmetagaLayer, v : Double) -> OptmetagaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetagaLayer::min(self : OptmetagaLayer) -> Double { @_common.min(self.data) }

pub fn OptmetagaLayer::max(self : OptmetagaLayer) -> Double { @_common.max(self.data) }

pub fn OptmetagaLayer::to_string(self : OptmetagaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetagaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_buffer_make(size : Int) -> OptmetagaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetagaBuffer::len(self : OptmetagaBuffer) -> Int { self.size }

pub fn OptmetagaBuffer::get(self : OptmetagaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetagaBuffer::set(self : OptmetagaBuffer, i : Int, v : Double) -> OptmetagaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetagaBuffer::sum(self : OptmetagaBuffer) -> Double { @_common.sum(self.data) }

pub fn OptmetagaBuffer::mean(self : OptmetagaBuffer) -> Double { @_common.mean(self.data) }

pub fn OptmetagaBuffer::scale(self : OptmetagaBuffer, f : Double) -> OptmetagaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetagaBuffer::add(self : OptmetagaBuffer, other : OptmetagaBuffer) -> OptmetagaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetagaBuffer::copy(self : OptmetagaBuffer) -> OptmetagaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetagaBuffer::fill(self : OptmetagaBuffer, v : Double) -> OptmetagaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetagaBuffer::min(self : OptmetagaBuffer) -> Double { @_common.min(self.data) }

pub fn OptmetagaBuffer::max(self : OptmetagaBuffer) -> Double { @_common.max(self.data) }

pub fn OptmetagaBuffer::to_string(self : OptmetagaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetagaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_cursor_make(size : Int) -> OptmetagaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetagaCursor::len(self : OptmetagaCursor) -> Int { self.size }

pub fn OptmetagaCursor::get(self : OptmetagaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetagaCursor::set(self : OptmetagaCursor, i : Int, v : Double) -> OptmetagaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetagaCursor::sum(self : OptmetagaCursor) -> Double { @_common.sum(self.data) }

pub fn OptmetagaCursor::mean(self : OptmetagaCursor) -> Double { @_common.mean(self.data) }

pub fn OptmetagaCursor::scale(self : OptmetagaCursor, f : Double) -> OptmetagaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetagaCursor::add(self : OptmetagaCursor, other : OptmetagaCursor) -> OptmetagaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetagaCursor::copy(self : OptmetagaCursor) -> OptmetagaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetagaCursor::fill(self : OptmetagaCursor, v : Double) -> OptmetagaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetagaCursor::min(self : OptmetagaCursor) -> Double { @_common.min(self.data) }

pub fn OptmetagaCursor::max(self : OptmetagaCursor) -> Double { @_common.max(self.data) }

pub fn OptmetagaCursor::to_string(self : OptmetagaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetagaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_view_make(size : Int) -> OptmetagaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetagaView::len(self : OptmetagaView) -> Int { self.size }

pub fn OptmetagaView::get(self : OptmetagaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetagaView::set(self : OptmetagaView, i : Int, v : Double) -> OptmetagaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetagaView::sum(self : OptmetagaView) -> Double { @_common.sum(self.data) }

pub fn OptmetagaView::mean(self : OptmetagaView) -> Double { @_common.mean(self.data) }

pub fn OptmetagaView::scale(self : OptmetagaView, f : Double) -> OptmetagaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetagaView::add(self : OptmetagaView, other : OptmetagaView) -> OptmetagaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetagaView::copy(self : OptmetagaView) -> OptmetagaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetagaView::fill(self : OptmetagaView, v : Double) -> OptmetagaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetagaView::min(self : OptmetagaView) -> Double { @_common.min(self.data) }

pub fn OptmetagaView::max(self : OptmetagaView) -> Double { @_common.max(self.data) }

pub fn OptmetagaView::to_string(self : OptmetagaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetagaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_range_make(size : Int) -> OptmetagaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetagaRange::len(self : OptmetagaRange) -> Int { self.size }

pub fn OptmetagaRange::get(self : OptmetagaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetagaRange::set(self : OptmetagaRange, i : Int, v : Double) -> OptmetagaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetagaRange::sum(self : OptmetagaRange) -> Double { @_common.sum(self.data) }

pub fn OptmetagaRange::mean(self : OptmetagaRange) -> Double { @_common.mean(self.data) }

pub fn OptmetagaRange::scale(self : OptmetagaRange, f : Double) -> OptmetagaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetagaRange::add(self : OptmetagaRange, other : OptmetagaRange) -> OptmetagaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetagaRange::copy(self : OptmetagaRange) -> OptmetagaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetagaRange::fill(self : OptmetagaRange, v : Double) -> OptmetagaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetagaRange::min(self : OptmetagaRange) -> Double { @_common.min(self.data) }

pub fn OptmetagaRange::max(self : OptmetagaRange) -> Double { @_common.max(self.data) }

pub fn OptmetagaRange::to_string(self : OptmetagaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetagaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_slice_make(size : Int) -> OptmetagaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetagaSlice::len(self : OptmetagaSlice) -> Int { self.size }

pub fn OptmetagaSlice::get(self : OptmetagaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetagaSlice::set(self : OptmetagaSlice, i : Int, v : Double) -> OptmetagaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetagaSlice::sum(self : OptmetagaSlice) -> Double { @_common.sum(self.data) }

pub fn OptmetagaSlice::mean(self : OptmetagaSlice) -> Double { @_common.mean(self.data) }

pub fn OptmetagaSlice::scale(self : OptmetagaSlice, f : Double) -> OptmetagaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetagaSlice::add(self : OptmetagaSlice, other : OptmetagaSlice) -> OptmetagaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetagaSlice::copy(self : OptmetagaSlice) -> OptmetagaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetagaSlice::fill(self : OptmetagaSlice, v : Double) -> OptmetagaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetagaSlice::min(self : OptmetagaSlice) -> Double { @_common.min(self.data) }

pub fn OptmetagaSlice::max(self : OptmetagaSlice) -> Double { @_common.max(self.data) }

pub fn OptmetagaSlice::to_string(self : OptmetagaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

