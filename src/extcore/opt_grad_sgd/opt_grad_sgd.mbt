///===
/// extcore/opt_grad_sgd

pub(all) struct OptgradsgdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_sgd_make_point(x : Double, y : Double) -> OptgradsgdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_sgd_make_point3(x : Double, y : Double, z : Double) -> OptgradsgdPoint {
  { x, y, z, label: 0 }
}

pub fn OptgradsgdPoint::x(self : OptgradsgdPoint) -> Double { self.x }

pub fn OptgradsgdPoint::y(self : OptgradsgdPoint) -> Double { self.y }

pub fn OptgradsgdPoint::z(self : OptgradsgdPoint) -> Double { self.z }

pub fn OptgradsgdPoint::label(self : OptgradsgdPoint) -> Int { self.label }

pub fn OptgradsgdPoint::dist(self : OptgradsgdPoint, other : OptgradsgdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptgradsgdPoint::add(self : OptgradsgdPoint, other : OptgradsgdPoint) -> OptgradsgdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptgradsgdPoint::sub(self : OptgradsgdPoint, other : OptgradsgdPoint) -> OptgradsgdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptgradsgdPoint::scale(self : OptgradsgdPoint, s : Double) -> OptgradsgdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptgradsgdPoint::dot(self : OptgradsgdPoint, other : OptgradsgdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptgradsgdPoint::cross(self : OptgradsgdPoint, other : OptgradsgdPoint) -> OptgradsgdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptgradsgdPoint::norm(self : OptgradsgdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptgradsgdPoint::normalize(self : OptgradsgdPoint) -> OptgradsgdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradsgdPoint::negate(self : OptgradsgdPoint) -> OptgradsgdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptgradsgdPoint::mid(self : OptgradsgdPoint, other : OptgradsgdPoint) -> OptgradsgdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptgradsgdPoint::lerp(self : OptgradsgdPoint, other : OptgradsgdPoint, t : Double) -> OptgradsgdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptgradsgdPoint::to_string(self : OptgradsgdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptgradsgdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_sgd_make_series(vals : Array[Double], name : String) -> OptgradsgdSeries {
  { vals, name, meta: 0 }
}

pub fn OptgradsgdSeries::len(self : OptgradsgdSeries) -> Int { self.vals.length() }

pub fn OptgradsgdSeries::sum(self : OptgradsgdSeries) -> Double { @_common.sum(self.vals) }

pub fn OptgradsgdSeries::mean(self : OptgradsgdSeries) -> Double { @_common.mean(self.vals) }

pub fn OptgradsgdSeries::min(self : OptgradsgdSeries) -> Double { @_common.min(self.vals) }

pub fn OptgradsgdSeries::max(self : OptgradsgdSeries) -> Double { @_common.max(self.vals) }

pub fn OptgradsgdSeries::range(self : OptgradsgdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptgradsgdSeries::variance(self : OptgradsgdSeries) -> Double { @_common.variance(self.vals) }

pub fn OptgradsgdSeries::std(self : OptgradsgdSeries) -> Double { @_common.std(self.vals) }

pub fn OptgradsgdSeries::median(self : OptgradsgdSeries) -> Double { @_common.median(self.vals) }

pub fn OptgradsgdSeries::scale(self : OptgradsgdSeries, f : Double) -> OptgradsgdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptgradsgdSeries::add(self : OptgradsgdSeries, other : OptgradsgdSeries) -> OptgradsgdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptgradsgdSeries::sub(self : OptgradsgdSeries, other : OptgradsgdSeries) -> OptgradsgdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptgradsgdSeries::normalize(self : OptgradsgdSeries) -> OptgradsgdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptgradsgdSeries::cumsum(self : OptgradsgdSeries) -> OptgradsgdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptgradsgdSeries::to_string(self : OptgradsgdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradsgdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_sgd_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradsgdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_sgd_matrix_identity(n : Int) -> OptgradsgdMatrix {
  let m = opt_grad_sgd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptgradsgdMatrix::get(self : OptgradsgdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptgradsgdMatrix::transpose(self : OptgradsgdMatrix) -> OptgradsgdMatrix {
  let result = opt_grad_sgd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptgradsgdMatrix::add(self : OptgradsgdMatrix, other : OptgradsgdMatrix) -> OptgradsgdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_grad_sgd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptgradsgdMatrix::scale(self : OptgradsgdMatrix, s : Double) -> OptgradsgdMatrix {
  let result = opt_grad_sgd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptgradsgdMatrix::multiply(self : OptgradsgdMatrix, other : OptgradsgdMatrix) -> OptgradsgdMatrix {
  if self.cols != other.rows { return opt_grad_sgd_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_grad_sgd_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn OptgradsgdMatrix::trace(self : OptgradsgdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptgradsgdMatrix::det(self : OptgradsgdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptgradsgdMatrix::norm(self : OptgradsgdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptgradsgdMatrix::to_string(self : OptgradsgdMatrix) -> String {
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

pub(all) struct OptgradsgdVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_sgd_make_vector(comps : Array[Double]) -> OptgradsgdVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_sgd_vector_zero(dim : Int) -> OptgradsgdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptgradsgdVector::add(self : OptgradsgdVector, other : OptgradsgdVector) -> OptgradsgdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradsgdVector::sub(self : OptgradsgdVector, other : OptgradsgdVector) -> OptgradsgdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradsgdVector::scale(self : OptgradsgdVector, s : Double) -> OptgradsgdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptgradsgdVector::dot(self : OptgradsgdVector, other : OptgradsgdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptgradsgdVector::norm(self : OptgradsgdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptgradsgdVector::normalize(self : OptgradsgdVector) -> OptgradsgdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradsgdVector::dist(self : OptgradsgdVector, other : OptgradsgdVector) -> Double {
  self.sub(other).norm()
}

pub fn OptgradsgdVector::to_string(self : OptgradsgdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradsgdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_frame_make(size : Int) -> OptgradsgdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradsgdFrame::len(self : OptgradsgdFrame) -> Int { self.size }

pub fn OptgradsgdFrame::get(self : OptgradsgdFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradsgdFrame::set(self : OptgradsgdFrame, i : Int, v : Double) -> OptgradsgdFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradsgdFrame::sum(self : OptgradsgdFrame) -> Double { @_common.sum(self.data) }

pub fn OptgradsgdFrame::mean(self : OptgradsgdFrame) -> Double { @_common.mean(self.data) }

pub fn OptgradsgdFrame::scale(self : OptgradsgdFrame, f : Double) -> OptgradsgdFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradsgdFrame::add(self : OptgradsgdFrame, other : OptgradsgdFrame) -> OptgradsgdFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradsgdFrame::copy(self : OptgradsgdFrame) -> OptgradsgdFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradsgdFrame::fill(self : OptgradsgdFrame, v : Double) -> OptgradsgdFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradsgdFrame::min(self : OptgradsgdFrame) -> Double { @_common.min(self.data) }

pub fn OptgradsgdFrame::max(self : OptgradsgdFrame) -> Double { @_common.max(self.data) }

pub fn OptgradsgdFrame::to_string(self : OptgradsgdFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradsgdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_table_make(size : Int) -> OptgradsgdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradsgdTable::len(self : OptgradsgdTable) -> Int { self.size }

pub fn OptgradsgdTable::get(self : OptgradsgdTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradsgdTable::set(self : OptgradsgdTable, i : Int, v : Double) -> OptgradsgdTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradsgdTable::sum(self : OptgradsgdTable) -> Double { @_common.sum(self.data) }

pub fn OptgradsgdTable::mean(self : OptgradsgdTable) -> Double { @_common.mean(self.data) }

pub fn OptgradsgdTable::scale(self : OptgradsgdTable, f : Double) -> OptgradsgdTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradsgdTable::add(self : OptgradsgdTable, other : OptgradsgdTable) -> OptgradsgdTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradsgdTable::copy(self : OptgradsgdTable) -> OptgradsgdTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradsgdTable::fill(self : OptgradsgdTable, v : Double) -> OptgradsgdTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradsgdTable::min(self : OptgradsgdTable) -> Double { @_common.min(self.data) }

pub fn OptgradsgdTable::max(self : OptgradsgdTable) -> Double { @_common.max(self.data) }

pub fn OptgradsgdTable::to_string(self : OptgradsgdTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradsgdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_graphn_make(size : Int) -> OptgradsgdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradsgdGraphN::len(self : OptgradsgdGraphN) -> Int { self.size }

pub fn OptgradsgdGraphN::get(self : OptgradsgdGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradsgdGraphN::set(self : OptgradsgdGraphN, i : Int, v : Double) -> OptgradsgdGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradsgdGraphN::sum(self : OptgradsgdGraphN) -> Double { @_common.sum(self.data) }

pub fn OptgradsgdGraphN::mean(self : OptgradsgdGraphN) -> Double { @_common.mean(self.data) }

pub fn OptgradsgdGraphN::scale(self : OptgradsgdGraphN, f : Double) -> OptgradsgdGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradsgdGraphN::add(self : OptgradsgdGraphN, other : OptgradsgdGraphN) -> OptgradsgdGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradsgdGraphN::copy(self : OptgradsgdGraphN) -> OptgradsgdGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradsgdGraphN::fill(self : OptgradsgdGraphN, v : Double) -> OptgradsgdGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradsgdGraphN::min(self : OptgradsgdGraphN) -> Double { @_common.min(self.data) }

pub fn OptgradsgdGraphN::max(self : OptgradsgdGraphN) -> Double { @_common.max(self.data) }

pub fn OptgradsgdGraphN::to_string(self : OptgradsgdGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradsgdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_node_make(size : Int) -> OptgradsgdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradsgdNode::len(self : OptgradsgdNode) -> Int { self.size }

pub fn OptgradsgdNode::get(self : OptgradsgdNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradsgdNode::set(self : OptgradsgdNode, i : Int, v : Double) -> OptgradsgdNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradsgdNode::sum(self : OptgradsgdNode) -> Double { @_common.sum(self.data) }

pub fn OptgradsgdNode::mean(self : OptgradsgdNode) -> Double { @_common.mean(self.data) }

pub fn OptgradsgdNode::scale(self : OptgradsgdNode, f : Double) -> OptgradsgdNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradsgdNode::add(self : OptgradsgdNode, other : OptgradsgdNode) -> OptgradsgdNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradsgdNode::copy(self : OptgradsgdNode) -> OptgradsgdNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradsgdNode::fill(self : OptgradsgdNode, v : Double) -> OptgradsgdNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradsgdNode::min(self : OptgradsgdNode) -> Double { @_common.min(self.data) }

pub fn OptgradsgdNode::max(self : OptgradsgdNode) -> Double { @_common.max(self.data) }

pub fn OptgradsgdNode::to_string(self : OptgradsgdNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradsgdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_edge_make(size : Int) -> OptgradsgdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradsgdEdge::len(self : OptgradsgdEdge) -> Int { self.size }

pub fn OptgradsgdEdge::get(self : OptgradsgdEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradsgdEdge::set(self : OptgradsgdEdge, i : Int, v : Double) -> OptgradsgdEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradsgdEdge::sum(self : OptgradsgdEdge) -> Double { @_common.sum(self.data) }

pub fn OptgradsgdEdge::mean(self : OptgradsgdEdge) -> Double { @_common.mean(self.data) }

pub fn OptgradsgdEdge::scale(self : OptgradsgdEdge, f : Double) -> OptgradsgdEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradsgdEdge::add(self : OptgradsgdEdge, other : OptgradsgdEdge) -> OptgradsgdEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradsgdEdge::copy(self : OptgradsgdEdge) -> OptgradsgdEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradsgdEdge::fill(self : OptgradsgdEdge, v : Double) -> OptgradsgdEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradsgdEdge::min(self : OptgradsgdEdge) -> Double { @_common.min(self.data) }

pub fn OptgradsgdEdge::max(self : OptgradsgdEdge) -> Double { @_common.max(self.data) }

pub fn OptgradsgdEdge::to_string(self : OptgradsgdEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradsgdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_path_make(size : Int) -> OptgradsgdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradsgdPath::len(self : OptgradsgdPath) -> Int { self.size }

pub fn OptgradsgdPath::get(self : OptgradsgdPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradsgdPath::set(self : OptgradsgdPath, i : Int, v : Double) -> OptgradsgdPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradsgdPath::sum(self : OptgradsgdPath) -> Double { @_common.sum(self.data) }

pub fn OptgradsgdPath::mean(self : OptgradsgdPath) -> Double { @_common.mean(self.data) }

pub fn OptgradsgdPath::scale(self : OptgradsgdPath, f : Double) -> OptgradsgdPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradsgdPath::add(self : OptgradsgdPath, other : OptgradsgdPath) -> OptgradsgdPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradsgdPath::copy(self : OptgradsgdPath) -> OptgradsgdPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradsgdPath::fill(self : OptgradsgdPath, v : Double) -> OptgradsgdPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradsgdPath::min(self : OptgradsgdPath) -> Double { @_common.min(self.data) }

pub fn OptgradsgdPath::max(self : OptgradsgdPath) -> Double { @_common.max(self.data) }

pub fn OptgradsgdPath::to_string(self : OptgradsgdPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradsgdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_cluster_make(size : Int) -> OptgradsgdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradsgdCluster::len(self : OptgradsgdCluster) -> Int { self.size }

pub fn OptgradsgdCluster::get(self : OptgradsgdCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradsgdCluster::set(self : OptgradsgdCluster, i : Int, v : Double) -> OptgradsgdCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradsgdCluster::sum(self : OptgradsgdCluster) -> Double { @_common.sum(self.data) }

pub fn OptgradsgdCluster::mean(self : OptgradsgdCluster) -> Double { @_common.mean(self.data) }

pub fn OptgradsgdCluster::scale(self : OptgradsgdCluster, f : Double) -> OptgradsgdCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradsgdCluster::add(self : OptgradsgdCluster, other : OptgradsgdCluster) -> OptgradsgdCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradsgdCluster::copy(self : OptgradsgdCluster) -> OptgradsgdCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradsgdCluster::fill(self : OptgradsgdCluster, v : Double) -> OptgradsgdCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradsgdCluster::min(self : OptgradsgdCluster) -> Double { @_common.min(self.data) }

pub fn OptgradsgdCluster::max(self : OptgradsgdCluster) -> Double { @_common.max(self.data) }

pub fn OptgradsgdCluster::to_string(self : OptgradsgdCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradsgdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_model_make(size : Int) -> OptgradsgdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradsgdModel::len(self : OptgradsgdModel) -> Int { self.size }

pub fn OptgradsgdModel::get(self : OptgradsgdModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradsgdModel::set(self : OptgradsgdModel, i : Int, v : Double) -> OptgradsgdModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradsgdModel::sum(self : OptgradsgdModel) -> Double { @_common.sum(self.data) }

pub fn OptgradsgdModel::mean(self : OptgradsgdModel) -> Double { @_common.mean(self.data) }

pub fn OptgradsgdModel::scale(self : OptgradsgdModel, f : Double) -> OptgradsgdModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradsgdModel::add(self : OptgradsgdModel, other : OptgradsgdModel) -> OptgradsgdModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradsgdModel::copy(self : OptgradsgdModel) -> OptgradsgdModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradsgdModel::fill(self : OptgradsgdModel, v : Double) -> OptgradsgdModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradsgdModel::min(self : OptgradsgdModel) -> Double { @_common.min(self.data) }

pub fn OptgradsgdModel::max(self : OptgradsgdModel) -> Double { @_common.max(self.data) }

pub fn OptgradsgdModel::to_string(self : OptgradsgdModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradsgdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_layer_make(size : Int) -> OptgradsgdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradsgdLayer::len(self : OptgradsgdLayer) -> Int { self.size }

pub fn OptgradsgdLayer::get(self : OptgradsgdLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradsgdLayer::set(self : OptgradsgdLayer, i : Int, v : Double) -> OptgradsgdLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradsgdLayer::sum(self : OptgradsgdLayer) -> Double { @_common.sum(self.data) }

pub fn OptgradsgdLayer::mean(self : OptgradsgdLayer) -> Double { @_common.mean(self.data) }

pub fn OptgradsgdLayer::scale(self : OptgradsgdLayer, f : Double) -> OptgradsgdLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradsgdLayer::add(self : OptgradsgdLayer, other : OptgradsgdLayer) -> OptgradsgdLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradsgdLayer::copy(self : OptgradsgdLayer) -> OptgradsgdLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradsgdLayer::fill(self : OptgradsgdLayer, v : Double) -> OptgradsgdLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradsgdLayer::min(self : OptgradsgdLayer) -> Double { @_common.min(self.data) }

pub fn OptgradsgdLayer::max(self : OptgradsgdLayer) -> Double { @_common.max(self.data) }

pub fn OptgradsgdLayer::to_string(self : OptgradsgdLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradsgdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_buffer_make(size : Int) -> OptgradsgdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradsgdBuffer::len(self : OptgradsgdBuffer) -> Int { self.size }

pub fn OptgradsgdBuffer::get(self : OptgradsgdBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradsgdBuffer::set(self : OptgradsgdBuffer, i : Int, v : Double) -> OptgradsgdBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradsgdBuffer::sum(self : OptgradsgdBuffer) -> Double { @_common.sum(self.data) }

pub fn OptgradsgdBuffer::mean(self : OptgradsgdBuffer) -> Double { @_common.mean(self.data) }

pub fn OptgradsgdBuffer::scale(self : OptgradsgdBuffer, f : Double) -> OptgradsgdBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradsgdBuffer::add(self : OptgradsgdBuffer, other : OptgradsgdBuffer) -> OptgradsgdBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradsgdBuffer::copy(self : OptgradsgdBuffer) -> OptgradsgdBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradsgdBuffer::fill(self : OptgradsgdBuffer, v : Double) -> OptgradsgdBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradsgdBuffer::min(self : OptgradsgdBuffer) -> Double { @_common.min(self.data) }

pub fn OptgradsgdBuffer::max(self : OptgradsgdBuffer) -> Double { @_common.max(self.data) }

pub fn OptgradsgdBuffer::to_string(self : OptgradsgdBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradsgdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_cursor_make(size : Int) -> OptgradsgdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradsgdCursor::len(self : OptgradsgdCursor) -> Int { self.size }

pub fn OptgradsgdCursor::get(self : OptgradsgdCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradsgdCursor::set(self : OptgradsgdCursor, i : Int, v : Double) -> OptgradsgdCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradsgdCursor::sum(self : OptgradsgdCursor) -> Double { @_common.sum(self.data) }

pub fn OptgradsgdCursor::mean(self : OptgradsgdCursor) -> Double { @_common.mean(self.data) }

pub fn OptgradsgdCursor::scale(self : OptgradsgdCursor, f : Double) -> OptgradsgdCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradsgdCursor::add(self : OptgradsgdCursor, other : OptgradsgdCursor) -> OptgradsgdCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradsgdCursor::copy(self : OptgradsgdCursor) -> OptgradsgdCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradsgdCursor::fill(self : OptgradsgdCursor, v : Double) -> OptgradsgdCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradsgdCursor::min(self : OptgradsgdCursor) -> Double { @_common.min(self.data) }

pub fn OptgradsgdCursor::max(self : OptgradsgdCursor) -> Double { @_common.max(self.data) }

pub fn OptgradsgdCursor::to_string(self : OptgradsgdCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradsgdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_view_make(size : Int) -> OptgradsgdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradsgdView::len(self : OptgradsgdView) -> Int { self.size }

pub fn OptgradsgdView::get(self : OptgradsgdView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradsgdView::set(self : OptgradsgdView, i : Int, v : Double) -> OptgradsgdView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradsgdView::sum(self : OptgradsgdView) -> Double { @_common.sum(self.data) }

pub fn OptgradsgdView::mean(self : OptgradsgdView) -> Double { @_common.mean(self.data) }

pub fn OptgradsgdView::scale(self : OptgradsgdView, f : Double) -> OptgradsgdView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradsgdView::add(self : OptgradsgdView, other : OptgradsgdView) -> OptgradsgdView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradsgdView::copy(self : OptgradsgdView) -> OptgradsgdView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradsgdView::fill(self : OptgradsgdView, v : Double) -> OptgradsgdView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradsgdView::min(self : OptgradsgdView) -> Double { @_common.min(self.data) }

pub fn OptgradsgdView::max(self : OptgradsgdView) -> Double { @_common.max(self.data) }

pub fn OptgradsgdView::to_string(self : OptgradsgdView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradsgdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_range_make(size : Int) -> OptgradsgdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradsgdRange::len(self : OptgradsgdRange) -> Int { self.size }

pub fn OptgradsgdRange::get(self : OptgradsgdRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradsgdRange::set(self : OptgradsgdRange, i : Int, v : Double) -> OptgradsgdRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradsgdRange::sum(self : OptgradsgdRange) -> Double { @_common.sum(self.data) }

pub fn OptgradsgdRange::mean(self : OptgradsgdRange) -> Double { @_common.mean(self.data) }

pub fn OptgradsgdRange::scale(self : OptgradsgdRange, f : Double) -> OptgradsgdRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradsgdRange::add(self : OptgradsgdRange, other : OptgradsgdRange) -> OptgradsgdRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradsgdRange::copy(self : OptgradsgdRange) -> OptgradsgdRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradsgdRange::fill(self : OptgradsgdRange, v : Double) -> OptgradsgdRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradsgdRange::min(self : OptgradsgdRange) -> Double { @_common.min(self.data) }

pub fn OptgradsgdRange::max(self : OptgradsgdRange) -> Double { @_common.max(self.data) }

pub fn OptgradsgdRange::to_string(self : OptgradsgdRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradsgdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_slice_make(size : Int) -> OptgradsgdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradsgdSlice::len(self : OptgradsgdSlice) -> Int { self.size }

pub fn OptgradsgdSlice::get(self : OptgradsgdSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradsgdSlice::set(self : OptgradsgdSlice, i : Int, v : Double) -> OptgradsgdSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradsgdSlice::sum(self : OptgradsgdSlice) -> Double { @_common.sum(self.data) }

pub fn OptgradsgdSlice::mean(self : OptgradsgdSlice) -> Double { @_common.mean(self.data) }

pub fn OptgradsgdSlice::scale(self : OptgradsgdSlice, f : Double) -> OptgradsgdSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradsgdSlice::add(self : OptgradsgdSlice, other : OptgradsgdSlice) -> OptgradsgdSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradsgdSlice::copy(self : OptgradsgdSlice) -> OptgradsgdSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradsgdSlice::fill(self : OptgradsgdSlice, v : Double) -> OptgradsgdSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradsgdSlice::min(self : OptgradsgdSlice) -> Double { @_common.min(self.data) }

pub fn OptgradsgdSlice::max(self : OptgradsgdSlice) -> Double { @_common.max(self.data) }

pub fn OptgradsgdSlice::to_string(self : OptgradsgdSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

