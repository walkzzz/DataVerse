///===
/// extcore/opt_meta_de

pub(all) struct OptmetadePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_de_make_point(x : Double, y : Double) -> OptmetadePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_de_make_point3(x : Double, y : Double, z : Double) -> OptmetadePoint {
  { x, y, z, label: 0 }
}

pub fn OptmetadePoint::x(self : OptmetadePoint) -> Double { self.x }

pub fn OptmetadePoint::y(self : OptmetadePoint) -> Double { self.y }

pub fn OptmetadePoint::z(self : OptmetadePoint) -> Double { self.z }

pub fn OptmetadePoint::label(self : OptmetadePoint) -> Int { self.label }

pub fn OptmetadePoint::dist(self : OptmetadePoint, other : OptmetadePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptmetadePoint::add(self : OptmetadePoint, other : OptmetadePoint) -> OptmetadePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptmetadePoint::sub(self : OptmetadePoint, other : OptmetadePoint) -> OptmetadePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptmetadePoint::scale(self : OptmetadePoint, s : Double) -> OptmetadePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptmetadePoint::dot(self : OptmetadePoint, other : OptmetadePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptmetadePoint::cross(self : OptmetadePoint, other : OptmetadePoint) -> OptmetadePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptmetadePoint::norm(self : OptmetadePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptmetadePoint::normalize(self : OptmetadePoint) -> OptmetadePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetadePoint::negate(self : OptmetadePoint) -> OptmetadePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptmetadePoint::mid(self : OptmetadePoint, other : OptmetadePoint) -> OptmetadePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptmetadePoint::lerp(self : OptmetadePoint, other : OptmetadePoint, t : Double) -> OptmetadePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptmetadePoint::to_string(self : OptmetadePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptmetadeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_de_make_series(vals : Array[Double], name : String) -> OptmetadeSeries {
  { vals, name, meta: 0 }
}

pub fn OptmetadeSeries::len(self : OptmetadeSeries) -> Int { self.vals.length() }

pub fn OptmetadeSeries::sum(self : OptmetadeSeries) -> Double { @_common.sum(self.vals) }

pub fn OptmetadeSeries::mean(self : OptmetadeSeries) -> Double { @_common.mean(self.vals) }

pub fn OptmetadeSeries::min(self : OptmetadeSeries) -> Double { @_common.min(self.vals) }

pub fn OptmetadeSeries::max(self : OptmetadeSeries) -> Double { @_common.max(self.vals) }

pub fn OptmetadeSeries::range(self : OptmetadeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptmetadeSeries::variance(self : OptmetadeSeries) -> Double { @_common.variance(self.vals) }

pub fn OptmetadeSeries::std(self : OptmetadeSeries) -> Double { @_common.std(self.vals) }

pub fn OptmetadeSeries::median(self : OptmetadeSeries) -> Double { @_common.median(self.vals) }

pub fn OptmetadeSeries::scale(self : OptmetadeSeries, f : Double) -> OptmetadeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptmetadeSeries::add(self : OptmetadeSeries, other : OptmetadeSeries) -> OptmetadeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptmetadeSeries::sub(self : OptmetadeSeries, other : OptmetadeSeries) -> OptmetadeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptmetadeSeries::normalize(self : OptmetadeSeries) -> OptmetadeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptmetadeSeries::cumsum(self : OptmetadeSeries) -> OptmetadeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptmetadeSeries::to_string(self : OptmetadeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetadeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_de_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetadeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_de_matrix_identity(n : Int) -> OptmetadeMatrix {
  let m = opt_meta_de_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptmetadeMatrix::get(self : OptmetadeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptmetadeMatrix::transpose(self : OptmetadeMatrix) -> OptmetadeMatrix {
  let result = opt_meta_de_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptmetadeMatrix::add(self : OptmetadeMatrix, other : OptmetadeMatrix) -> OptmetadeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_meta_de_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptmetadeMatrix::scale(self : OptmetadeMatrix, s : Double) -> OptmetadeMatrix {
  let result = opt_meta_de_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptmetadeMatrix::multiply(self : OptmetadeMatrix, other : OptmetadeMatrix) -> OptmetadeMatrix {
  if self.cols != other.rows { return opt_meta_de_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_meta_de_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn OptmetadeMatrix::trace(self : OptmetadeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptmetadeMatrix::det(self : OptmetadeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptmetadeMatrix::norm(self : OptmetadeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptmetadeMatrix::to_string(self : OptmetadeMatrix) -> String {
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

pub(all) struct OptmetadeVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_de_make_vector(comps : Array[Double]) -> OptmetadeVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_de_vector_zero(dim : Int) -> OptmetadeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptmetadeVector::add(self : OptmetadeVector, other : OptmetadeVector) -> OptmetadeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetadeVector::sub(self : OptmetadeVector, other : OptmetadeVector) -> OptmetadeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetadeVector::scale(self : OptmetadeVector, s : Double) -> OptmetadeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptmetadeVector::dot(self : OptmetadeVector, other : OptmetadeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptmetadeVector::norm(self : OptmetadeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptmetadeVector::normalize(self : OptmetadeVector) -> OptmetadeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetadeVector::dist(self : OptmetadeVector, other : OptmetadeVector) -> Double {
  self.sub(other).norm()
}

pub fn OptmetadeVector::to_string(self : OptmetadeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetadeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_frame_make(size : Int) -> OptmetadeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadeFrame::len(self : OptmetadeFrame) -> Int { self.size }

pub fn OptmetadeFrame::get(self : OptmetadeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadeFrame::set(self : OptmetadeFrame, i : Int, v : Double) -> OptmetadeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadeFrame::sum(self : OptmetadeFrame) -> Double { @_common.sum(self.data) }

pub fn OptmetadeFrame::mean(self : OptmetadeFrame) -> Double { @_common.mean(self.data) }

pub fn OptmetadeFrame::scale(self : OptmetadeFrame, f : Double) -> OptmetadeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadeFrame::add(self : OptmetadeFrame, other : OptmetadeFrame) -> OptmetadeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadeFrame::copy(self : OptmetadeFrame) -> OptmetadeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadeFrame::fill(self : OptmetadeFrame, v : Double) -> OptmetadeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadeFrame::min(self : OptmetadeFrame) -> Double { @_common.min(self.data) }

pub fn OptmetadeFrame::max(self : OptmetadeFrame) -> Double { @_common.max(self.data) }

pub fn OptmetadeFrame::to_string(self : OptmetadeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_table_make(size : Int) -> OptmetadeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadeTable::len(self : OptmetadeTable) -> Int { self.size }

pub fn OptmetadeTable::get(self : OptmetadeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadeTable::set(self : OptmetadeTable, i : Int, v : Double) -> OptmetadeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadeTable::sum(self : OptmetadeTable) -> Double { @_common.sum(self.data) }

pub fn OptmetadeTable::mean(self : OptmetadeTable) -> Double { @_common.mean(self.data) }

pub fn OptmetadeTable::scale(self : OptmetadeTable, f : Double) -> OptmetadeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadeTable::add(self : OptmetadeTable, other : OptmetadeTable) -> OptmetadeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadeTable::copy(self : OptmetadeTable) -> OptmetadeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadeTable::fill(self : OptmetadeTable, v : Double) -> OptmetadeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadeTable::min(self : OptmetadeTable) -> Double { @_common.min(self.data) }

pub fn OptmetadeTable::max(self : OptmetadeTable) -> Double { @_common.max(self.data) }

pub fn OptmetadeTable::to_string(self : OptmetadeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_graphn_make(size : Int) -> OptmetadeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadeGraphN::len(self : OptmetadeGraphN) -> Int { self.size }

pub fn OptmetadeGraphN::get(self : OptmetadeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadeGraphN::set(self : OptmetadeGraphN, i : Int, v : Double) -> OptmetadeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadeGraphN::sum(self : OptmetadeGraphN) -> Double { @_common.sum(self.data) }

pub fn OptmetadeGraphN::mean(self : OptmetadeGraphN) -> Double { @_common.mean(self.data) }

pub fn OptmetadeGraphN::scale(self : OptmetadeGraphN, f : Double) -> OptmetadeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadeGraphN::add(self : OptmetadeGraphN, other : OptmetadeGraphN) -> OptmetadeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadeGraphN::copy(self : OptmetadeGraphN) -> OptmetadeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadeGraphN::fill(self : OptmetadeGraphN, v : Double) -> OptmetadeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadeGraphN::min(self : OptmetadeGraphN) -> Double { @_common.min(self.data) }

pub fn OptmetadeGraphN::max(self : OptmetadeGraphN) -> Double { @_common.max(self.data) }

pub fn OptmetadeGraphN::to_string(self : OptmetadeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_node_make(size : Int) -> OptmetadeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadeNode::len(self : OptmetadeNode) -> Int { self.size }

pub fn OptmetadeNode::get(self : OptmetadeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadeNode::set(self : OptmetadeNode, i : Int, v : Double) -> OptmetadeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadeNode::sum(self : OptmetadeNode) -> Double { @_common.sum(self.data) }

pub fn OptmetadeNode::mean(self : OptmetadeNode) -> Double { @_common.mean(self.data) }

pub fn OptmetadeNode::scale(self : OptmetadeNode, f : Double) -> OptmetadeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadeNode::add(self : OptmetadeNode, other : OptmetadeNode) -> OptmetadeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadeNode::copy(self : OptmetadeNode) -> OptmetadeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadeNode::fill(self : OptmetadeNode, v : Double) -> OptmetadeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadeNode::min(self : OptmetadeNode) -> Double { @_common.min(self.data) }

pub fn OptmetadeNode::max(self : OptmetadeNode) -> Double { @_common.max(self.data) }

pub fn OptmetadeNode::to_string(self : OptmetadeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_edge_make(size : Int) -> OptmetadeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadeEdge::len(self : OptmetadeEdge) -> Int { self.size }

pub fn OptmetadeEdge::get(self : OptmetadeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadeEdge::set(self : OptmetadeEdge, i : Int, v : Double) -> OptmetadeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadeEdge::sum(self : OptmetadeEdge) -> Double { @_common.sum(self.data) }

pub fn OptmetadeEdge::mean(self : OptmetadeEdge) -> Double { @_common.mean(self.data) }

pub fn OptmetadeEdge::scale(self : OptmetadeEdge, f : Double) -> OptmetadeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadeEdge::add(self : OptmetadeEdge, other : OptmetadeEdge) -> OptmetadeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadeEdge::copy(self : OptmetadeEdge) -> OptmetadeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadeEdge::fill(self : OptmetadeEdge, v : Double) -> OptmetadeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadeEdge::min(self : OptmetadeEdge) -> Double { @_common.min(self.data) }

pub fn OptmetadeEdge::max(self : OptmetadeEdge) -> Double { @_common.max(self.data) }

pub fn OptmetadeEdge::to_string(self : OptmetadeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_path_make(size : Int) -> OptmetadePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadePath::len(self : OptmetadePath) -> Int { self.size }

pub fn OptmetadePath::get(self : OptmetadePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadePath::set(self : OptmetadePath, i : Int, v : Double) -> OptmetadePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadePath::sum(self : OptmetadePath) -> Double { @_common.sum(self.data) }

pub fn OptmetadePath::mean(self : OptmetadePath) -> Double { @_common.mean(self.data) }

pub fn OptmetadePath::scale(self : OptmetadePath, f : Double) -> OptmetadePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadePath::add(self : OptmetadePath, other : OptmetadePath) -> OptmetadePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadePath::copy(self : OptmetadePath) -> OptmetadePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadePath::fill(self : OptmetadePath, v : Double) -> OptmetadePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadePath::min(self : OptmetadePath) -> Double { @_common.min(self.data) }

pub fn OptmetadePath::max(self : OptmetadePath) -> Double { @_common.max(self.data) }

pub fn OptmetadePath::to_string(self : OptmetadePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_cluster_make(size : Int) -> OptmetadeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadeCluster::len(self : OptmetadeCluster) -> Int { self.size }

pub fn OptmetadeCluster::get(self : OptmetadeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadeCluster::set(self : OptmetadeCluster, i : Int, v : Double) -> OptmetadeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadeCluster::sum(self : OptmetadeCluster) -> Double { @_common.sum(self.data) }

pub fn OptmetadeCluster::mean(self : OptmetadeCluster) -> Double { @_common.mean(self.data) }

pub fn OptmetadeCluster::scale(self : OptmetadeCluster, f : Double) -> OptmetadeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadeCluster::add(self : OptmetadeCluster, other : OptmetadeCluster) -> OptmetadeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadeCluster::copy(self : OptmetadeCluster) -> OptmetadeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadeCluster::fill(self : OptmetadeCluster, v : Double) -> OptmetadeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadeCluster::min(self : OptmetadeCluster) -> Double { @_common.min(self.data) }

pub fn OptmetadeCluster::max(self : OptmetadeCluster) -> Double { @_common.max(self.data) }

pub fn OptmetadeCluster::to_string(self : OptmetadeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_model_make(size : Int) -> OptmetadeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadeModel::len(self : OptmetadeModel) -> Int { self.size }

pub fn OptmetadeModel::get(self : OptmetadeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadeModel::set(self : OptmetadeModel, i : Int, v : Double) -> OptmetadeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadeModel::sum(self : OptmetadeModel) -> Double { @_common.sum(self.data) }

pub fn OptmetadeModel::mean(self : OptmetadeModel) -> Double { @_common.mean(self.data) }

pub fn OptmetadeModel::scale(self : OptmetadeModel, f : Double) -> OptmetadeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadeModel::add(self : OptmetadeModel, other : OptmetadeModel) -> OptmetadeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadeModel::copy(self : OptmetadeModel) -> OptmetadeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadeModel::fill(self : OptmetadeModel, v : Double) -> OptmetadeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadeModel::min(self : OptmetadeModel) -> Double { @_common.min(self.data) }

pub fn OptmetadeModel::max(self : OptmetadeModel) -> Double { @_common.max(self.data) }

pub fn OptmetadeModel::to_string(self : OptmetadeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_layer_make(size : Int) -> OptmetadeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadeLayer::len(self : OptmetadeLayer) -> Int { self.size }

pub fn OptmetadeLayer::get(self : OptmetadeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadeLayer::set(self : OptmetadeLayer, i : Int, v : Double) -> OptmetadeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadeLayer::sum(self : OptmetadeLayer) -> Double { @_common.sum(self.data) }

pub fn OptmetadeLayer::mean(self : OptmetadeLayer) -> Double { @_common.mean(self.data) }

pub fn OptmetadeLayer::scale(self : OptmetadeLayer, f : Double) -> OptmetadeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadeLayer::add(self : OptmetadeLayer, other : OptmetadeLayer) -> OptmetadeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadeLayer::copy(self : OptmetadeLayer) -> OptmetadeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadeLayer::fill(self : OptmetadeLayer, v : Double) -> OptmetadeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadeLayer::min(self : OptmetadeLayer) -> Double { @_common.min(self.data) }

pub fn OptmetadeLayer::max(self : OptmetadeLayer) -> Double { @_common.max(self.data) }

pub fn OptmetadeLayer::to_string(self : OptmetadeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_buffer_make(size : Int) -> OptmetadeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadeBuffer::len(self : OptmetadeBuffer) -> Int { self.size }

pub fn OptmetadeBuffer::get(self : OptmetadeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadeBuffer::set(self : OptmetadeBuffer, i : Int, v : Double) -> OptmetadeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadeBuffer::sum(self : OptmetadeBuffer) -> Double { @_common.sum(self.data) }

pub fn OptmetadeBuffer::mean(self : OptmetadeBuffer) -> Double { @_common.mean(self.data) }

pub fn OptmetadeBuffer::scale(self : OptmetadeBuffer, f : Double) -> OptmetadeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadeBuffer::add(self : OptmetadeBuffer, other : OptmetadeBuffer) -> OptmetadeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadeBuffer::copy(self : OptmetadeBuffer) -> OptmetadeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadeBuffer::fill(self : OptmetadeBuffer, v : Double) -> OptmetadeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadeBuffer::min(self : OptmetadeBuffer) -> Double { @_common.min(self.data) }

pub fn OptmetadeBuffer::max(self : OptmetadeBuffer) -> Double { @_common.max(self.data) }

pub fn OptmetadeBuffer::to_string(self : OptmetadeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_cursor_make(size : Int) -> OptmetadeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadeCursor::len(self : OptmetadeCursor) -> Int { self.size }

pub fn OptmetadeCursor::get(self : OptmetadeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadeCursor::set(self : OptmetadeCursor, i : Int, v : Double) -> OptmetadeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadeCursor::sum(self : OptmetadeCursor) -> Double { @_common.sum(self.data) }

pub fn OptmetadeCursor::mean(self : OptmetadeCursor) -> Double { @_common.mean(self.data) }

pub fn OptmetadeCursor::scale(self : OptmetadeCursor, f : Double) -> OptmetadeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadeCursor::add(self : OptmetadeCursor, other : OptmetadeCursor) -> OptmetadeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadeCursor::copy(self : OptmetadeCursor) -> OptmetadeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadeCursor::fill(self : OptmetadeCursor, v : Double) -> OptmetadeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadeCursor::min(self : OptmetadeCursor) -> Double { @_common.min(self.data) }

pub fn OptmetadeCursor::max(self : OptmetadeCursor) -> Double { @_common.max(self.data) }

pub fn OptmetadeCursor::to_string(self : OptmetadeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_view_make(size : Int) -> OptmetadeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadeView::len(self : OptmetadeView) -> Int { self.size }

pub fn OptmetadeView::get(self : OptmetadeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadeView::set(self : OptmetadeView, i : Int, v : Double) -> OptmetadeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadeView::sum(self : OptmetadeView) -> Double { @_common.sum(self.data) }

pub fn OptmetadeView::mean(self : OptmetadeView) -> Double { @_common.mean(self.data) }

pub fn OptmetadeView::scale(self : OptmetadeView, f : Double) -> OptmetadeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadeView::add(self : OptmetadeView, other : OptmetadeView) -> OptmetadeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadeView::copy(self : OptmetadeView) -> OptmetadeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadeView::fill(self : OptmetadeView, v : Double) -> OptmetadeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadeView::min(self : OptmetadeView) -> Double { @_common.min(self.data) }

pub fn OptmetadeView::max(self : OptmetadeView) -> Double { @_common.max(self.data) }

pub fn OptmetadeView::to_string(self : OptmetadeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_range_make(size : Int) -> OptmetadeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadeRange::len(self : OptmetadeRange) -> Int { self.size }

pub fn OptmetadeRange::get(self : OptmetadeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadeRange::set(self : OptmetadeRange, i : Int, v : Double) -> OptmetadeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadeRange::sum(self : OptmetadeRange) -> Double { @_common.sum(self.data) }

pub fn OptmetadeRange::mean(self : OptmetadeRange) -> Double { @_common.mean(self.data) }

pub fn OptmetadeRange::scale(self : OptmetadeRange, f : Double) -> OptmetadeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadeRange::add(self : OptmetadeRange, other : OptmetadeRange) -> OptmetadeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadeRange::copy(self : OptmetadeRange) -> OptmetadeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadeRange::fill(self : OptmetadeRange, v : Double) -> OptmetadeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadeRange::min(self : OptmetadeRange) -> Double { @_common.min(self.data) }

pub fn OptmetadeRange::max(self : OptmetadeRange) -> Double { @_common.max(self.data) }

pub fn OptmetadeRange::to_string(self : OptmetadeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_de_slice_make(size : Int) -> OptmetadeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadeSlice::len(self : OptmetadeSlice) -> Int { self.size }

pub fn OptmetadeSlice::get(self : OptmetadeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadeSlice::set(self : OptmetadeSlice, i : Int, v : Double) -> OptmetadeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadeSlice::sum(self : OptmetadeSlice) -> Double { @_common.sum(self.data) }

pub fn OptmetadeSlice::mean(self : OptmetadeSlice) -> Double { @_common.mean(self.data) }

pub fn OptmetadeSlice::scale(self : OptmetadeSlice, f : Double) -> OptmetadeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadeSlice::add(self : OptmetadeSlice, other : OptmetadeSlice) -> OptmetadeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadeSlice::copy(self : OptmetadeSlice) -> OptmetadeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadeSlice::fill(self : OptmetadeSlice, v : Double) -> OptmetadeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadeSlice::min(self : OptmetadeSlice) -> Double { @_common.min(self.data) }

pub fn OptmetadeSlice::max(self : OptmetadeSlice) -> Double { @_common.max(self.data) }

pub fn OptmetadeSlice::to_string(self : OptmetadeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

