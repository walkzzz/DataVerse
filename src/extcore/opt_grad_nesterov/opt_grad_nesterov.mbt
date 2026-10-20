///===
/// extcore/opt_grad_nesterov

pub(all) struct OptgradnesterovPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_nesterov_make_point(x : Double, y : Double) -> OptgradnesterovPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_nesterov_make_point3(x : Double, y : Double, z : Double) -> OptgradnesterovPoint {
  { x, y, z, label: 0 }
}

pub fn OptgradnesterovPoint::x(self : OptgradnesterovPoint) -> Double { self.x }

pub fn OptgradnesterovPoint::y(self : OptgradnesterovPoint) -> Double { self.y }

pub fn OptgradnesterovPoint::z(self : OptgradnesterovPoint) -> Double { self.z }

pub fn OptgradnesterovPoint::label(self : OptgradnesterovPoint) -> Int { self.label }

pub fn OptgradnesterovPoint::dist(self : OptgradnesterovPoint, other : OptgradnesterovPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptgradnesterovPoint::add(self : OptgradnesterovPoint, other : OptgradnesterovPoint) -> OptgradnesterovPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptgradnesterovPoint::sub(self : OptgradnesterovPoint, other : OptgradnesterovPoint) -> OptgradnesterovPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptgradnesterovPoint::scale(self : OptgradnesterovPoint, s : Double) -> OptgradnesterovPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptgradnesterovPoint::dot(self : OptgradnesterovPoint, other : OptgradnesterovPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptgradnesterovPoint::cross(self : OptgradnesterovPoint, other : OptgradnesterovPoint) -> OptgradnesterovPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptgradnesterovPoint::norm(self : OptgradnesterovPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptgradnesterovPoint::normalize(self : OptgradnesterovPoint) -> OptgradnesterovPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradnesterovPoint::negate(self : OptgradnesterovPoint) -> OptgradnesterovPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptgradnesterovPoint::mid(self : OptgradnesterovPoint, other : OptgradnesterovPoint) -> OptgradnesterovPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptgradnesterovPoint::lerp(self : OptgradnesterovPoint, other : OptgradnesterovPoint, t : Double) -> OptgradnesterovPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptgradnesterovPoint::to_string(self : OptgradnesterovPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptgradnesterovSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_nesterov_make_series(vals : Array[Double], name : String) -> OptgradnesterovSeries {
  { vals, name, meta: 0 }
}

pub fn OptgradnesterovSeries::len(self : OptgradnesterovSeries) -> Int { self.vals.length() }

pub fn OptgradnesterovSeries::sum(self : OptgradnesterovSeries) -> Double { @_common.sum(self.vals) }

pub fn OptgradnesterovSeries::mean(self : OptgradnesterovSeries) -> Double { @_common.mean(self.vals) }

pub fn OptgradnesterovSeries::min(self : OptgradnesterovSeries) -> Double { @_common.min(self.vals) }

pub fn OptgradnesterovSeries::max(self : OptgradnesterovSeries) -> Double { @_common.max(self.vals) }

pub fn OptgradnesterovSeries::range(self : OptgradnesterovSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptgradnesterovSeries::variance(self : OptgradnesterovSeries) -> Double { @_common.variance(self.vals) }

pub fn OptgradnesterovSeries::std(self : OptgradnesterovSeries) -> Double { @_common.std(self.vals) }

pub fn OptgradnesterovSeries::median(self : OptgradnesterovSeries) -> Double { @_common.median(self.vals) }

pub fn OptgradnesterovSeries::scale(self : OptgradnesterovSeries, f : Double) -> OptgradnesterovSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptgradnesterovSeries::add(self : OptgradnesterovSeries, other : OptgradnesterovSeries) -> OptgradnesterovSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptgradnesterovSeries::sub(self : OptgradnesterovSeries, other : OptgradnesterovSeries) -> OptgradnesterovSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptgradnesterovSeries::normalize(self : OptgradnesterovSeries) -> OptgradnesterovSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptgradnesterovSeries::cumsum(self : OptgradnesterovSeries) -> OptgradnesterovSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptgradnesterovSeries::to_string(self : OptgradnesterovSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradnesterovMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_nesterov_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradnesterovMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_nesterov_matrix_identity(n : Int) -> OptgradnesterovMatrix {
  let m = opt_grad_nesterov_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptgradnesterovMatrix::get(self : OptgradnesterovMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptgradnesterovMatrix::transpose(self : OptgradnesterovMatrix) -> OptgradnesterovMatrix {
  let result = opt_grad_nesterov_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptgradnesterovMatrix::add(self : OptgradnesterovMatrix, other : OptgradnesterovMatrix) -> OptgradnesterovMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_grad_nesterov_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptgradnesterovMatrix::scale(self : OptgradnesterovMatrix, s : Double) -> OptgradnesterovMatrix {
  let result = opt_grad_nesterov_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptgradnesterovMatrix::multiply(self : OptgradnesterovMatrix, other : OptgradnesterovMatrix) -> OptgradnesterovMatrix {
  if self.cols != other.rows { return opt_grad_nesterov_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_grad_nesterov_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn OptgradnesterovMatrix::trace(self : OptgradnesterovMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptgradnesterovMatrix::det(self : OptgradnesterovMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptgradnesterovMatrix::norm(self : OptgradnesterovMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptgradnesterovMatrix::to_string(self : OptgradnesterovMatrix) -> String {
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

pub(all) struct OptgradnesterovVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_nesterov_make_vector(comps : Array[Double]) -> OptgradnesterovVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_nesterov_vector_zero(dim : Int) -> OptgradnesterovVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptgradnesterovVector::add(self : OptgradnesterovVector, other : OptgradnesterovVector) -> OptgradnesterovVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradnesterovVector::sub(self : OptgradnesterovVector, other : OptgradnesterovVector) -> OptgradnesterovVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradnesterovVector::scale(self : OptgradnesterovVector, s : Double) -> OptgradnesterovVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptgradnesterovVector::dot(self : OptgradnesterovVector, other : OptgradnesterovVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptgradnesterovVector::norm(self : OptgradnesterovVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptgradnesterovVector::normalize(self : OptgradnesterovVector) -> OptgradnesterovVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradnesterovVector::dist(self : OptgradnesterovVector, other : OptgradnesterovVector) -> Double {
  self.sub(other).norm()
}

pub fn OptgradnesterovVector::to_string(self : OptgradnesterovVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradnesterovFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_frame_make(size : Int) -> OptgradnesterovFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradnesterovFrame::len(self : OptgradnesterovFrame) -> Int { self.size }

pub fn OptgradnesterovFrame::get(self : OptgradnesterovFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradnesterovFrame::set(self : OptgradnesterovFrame, i : Int, v : Double) -> OptgradnesterovFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradnesterovFrame::sum(self : OptgradnesterovFrame) -> Double { @_common.sum(self.data) }

pub fn OptgradnesterovFrame::mean(self : OptgradnesterovFrame) -> Double { @_common.mean(self.data) }

pub fn OptgradnesterovFrame::scale(self : OptgradnesterovFrame, f : Double) -> OptgradnesterovFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovFrame::add(self : OptgradnesterovFrame, other : OptgradnesterovFrame) -> OptgradnesterovFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradnesterovFrame::copy(self : OptgradnesterovFrame) -> OptgradnesterovFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovFrame::fill(self : OptgradnesterovFrame, v : Double) -> OptgradnesterovFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovFrame::min(self : OptgradnesterovFrame) -> Double { @_common.min(self.data) }

pub fn OptgradnesterovFrame::max(self : OptgradnesterovFrame) -> Double { @_common.max(self.data) }

pub fn OptgradnesterovFrame::to_string(self : OptgradnesterovFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_table_make(size : Int) -> OptgradnesterovTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradnesterovTable::len(self : OptgradnesterovTable) -> Int { self.size }

pub fn OptgradnesterovTable::get(self : OptgradnesterovTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradnesterovTable::set(self : OptgradnesterovTable, i : Int, v : Double) -> OptgradnesterovTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradnesterovTable::sum(self : OptgradnesterovTable) -> Double { @_common.sum(self.data) }

pub fn OptgradnesterovTable::mean(self : OptgradnesterovTable) -> Double { @_common.mean(self.data) }

pub fn OptgradnesterovTable::scale(self : OptgradnesterovTable, f : Double) -> OptgradnesterovTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovTable::add(self : OptgradnesterovTable, other : OptgradnesterovTable) -> OptgradnesterovTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradnesterovTable::copy(self : OptgradnesterovTable) -> OptgradnesterovTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovTable::fill(self : OptgradnesterovTable, v : Double) -> OptgradnesterovTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovTable::min(self : OptgradnesterovTable) -> Double { @_common.min(self.data) }

pub fn OptgradnesterovTable::max(self : OptgradnesterovTable) -> Double { @_common.max(self.data) }

pub fn OptgradnesterovTable::to_string(self : OptgradnesterovTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_graphn_make(size : Int) -> OptgradnesterovGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradnesterovGraphN::len(self : OptgradnesterovGraphN) -> Int { self.size }

pub fn OptgradnesterovGraphN::get(self : OptgradnesterovGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradnesterovGraphN::set(self : OptgradnesterovGraphN, i : Int, v : Double) -> OptgradnesterovGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradnesterovGraphN::sum(self : OptgradnesterovGraphN) -> Double { @_common.sum(self.data) }

pub fn OptgradnesterovGraphN::mean(self : OptgradnesterovGraphN) -> Double { @_common.mean(self.data) }

pub fn OptgradnesterovGraphN::scale(self : OptgradnesterovGraphN, f : Double) -> OptgradnesterovGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovGraphN::add(self : OptgradnesterovGraphN, other : OptgradnesterovGraphN) -> OptgradnesterovGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradnesterovGraphN::copy(self : OptgradnesterovGraphN) -> OptgradnesterovGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovGraphN::fill(self : OptgradnesterovGraphN, v : Double) -> OptgradnesterovGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovGraphN::min(self : OptgradnesterovGraphN) -> Double { @_common.min(self.data) }

pub fn OptgradnesterovGraphN::max(self : OptgradnesterovGraphN) -> Double { @_common.max(self.data) }

pub fn OptgradnesterovGraphN::to_string(self : OptgradnesterovGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_node_make(size : Int) -> OptgradnesterovNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradnesterovNode::len(self : OptgradnesterovNode) -> Int { self.size }

pub fn OptgradnesterovNode::get(self : OptgradnesterovNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradnesterovNode::set(self : OptgradnesterovNode, i : Int, v : Double) -> OptgradnesterovNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradnesterovNode::sum(self : OptgradnesterovNode) -> Double { @_common.sum(self.data) }

pub fn OptgradnesterovNode::mean(self : OptgradnesterovNode) -> Double { @_common.mean(self.data) }

pub fn OptgradnesterovNode::scale(self : OptgradnesterovNode, f : Double) -> OptgradnesterovNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovNode::add(self : OptgradnesterovNode, other : OptgradnesterovNode) -> OptgradnesterovNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradnesterovNode::copy(self : OptgradnesterovNode) -> OptgradnesterovNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovNode::fill(self : OptgradnesterovNode, v : Double) -> OptgradnesterovNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovNode::min(self : OptgradnesterovNode) -> Double { @_common.min(self.data) }

pub fn OptgradnesterovNode::max(self : OptgradnesterovNode) -> Double { @_common.max(self.data) }

pub fn OptgradnesterovNode::to_string(self : OptgradnesterovNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_edge_make(size : Int) -> OptgradnesterovEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradnesterovEdge::len(self : OptgradnesterovEdge) -> Int { self.size }

pub fn OptgradnesterovEdge::get(self : OptgradnesterovEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradnesterovEdge::set(self : OptgradnesterovEdge, i : Int, v : Double) -> OptgradnesterovEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradnesterovEdge::sum(self : OptgradnesterovEdge) -> Double { @_common.sum(self.data) }

pub fn OptgradnesterovEdge::mean(self : OptgradnesterovEdge) -> Double { @_common.mean(self.data) }

pub fn OptgradnesterovEdge::scale(self : OptgradnesterovEdge, f : Double) -> OptgradnesterovEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovEdge::add(self : OptgradnesterovEdge, other : OptgradnesterovEdge) -> OptgradnesterovEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradnesterovEdge::copy(self : OptgradnesterovEdge) -> OptgradnesterovEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovEdge::fill(self : OptgradnesterovEdge, v : Double) -> OptgradnesterovEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovEdge::min(self : OptgradnesterovEdge) -> Double { @_common.min(self.data) }

pub fn OptgradnesterovEdge::max(self : OptgradnesterovEdge) -> Double { @_common.max(self.data) }

pub fn OptgradnesterovEdge::to_string(self : OptgradnesterovEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_path_make(size : Int) -> OptgradnesterovPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradnesterovPath::len(self : OptgradnesterovPath) -> Int { self.size }

pub fn OptgradnesterovPath::get(self : OptgradnesterovPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradnesterovPath::set(self : OptgradnesterovPath, i : Int, v : Double) -> OptgradnesterovPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradnesterovPath::sum(self : OptgradnesterovPath) -> Double { @_common.sum(self.data) }

pub fn OptgradnesterovPath::mean(self : OptgradnesterovPath) -> Double { @_common.mean(self.data) }

pub fn OptgradnesterovPath::scale(self : OptgradnesterovPath, f : Double) -> OptgradnesterovPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovPath::add(self : OptgradnesterovPath, other : OptgradnesterovPath) -> OptgradnesterovPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradnesterovPath::copy(self : OptgradnesterovPath) -> OptgradnesterovPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovPath::fill(self : OptgradnesterovPath, v : Double) -> OptgradnesterovPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovPath::min(self : OptgradnesterovPath) -> Double { @_common.min(self.data) }

pub fn OptgradnesterovPath::max(self : OptgradnesterovPath) -> Double { @_common.max(self.data) }

pub fn OptgradnesterovPath::to_string(self : OptgradnesterovPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_cluster_make(size : Int) -> OptgradnesterovCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradnesterovCluster::len(self : OptgradnesterovCluster) -> Int { self.size }

pub fn OptgradnesterovCluster::get(self : OptgradnesterovCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradnesterovCluster::set(self : OptgradnesterovCluster, i : Int, v : Double) -> OptgradnesterovCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradnesterovCluster::sum(self : OptgradnesterovCluster) -> Double { @_common.sum(self.data) }

pub fn OptgradnesterovCluster::mean(self : OptgradnesterovCluster) -> Double { @_common.mean(self.data) }

pub fn OptgradnesterovCluster::scale(self : OptgradnesterovCluster, f : Double) -> OptgradnesterovCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovCluster::add(self : OptgradnesterovCluster, other : OptgradnesterovCluster) -> OptgradnesterovCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradnesterovCluster::copy(self : OptgradnesterovCluster) -> OptgradnesterovCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovCluster::fill(self : OptgradnesterovCluster, v : Double) -> OptgradnesterovCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovCluster::min(self : OptgradnesterovCluster) -> Double { @_common.min(self.data) }

pub fn OptgradnesterovCluster::max(self : OptgradnesterovCluster) -> Double { @_common.max(self.data) }

pub fn OptgradnesterovCluster::to_string(self : OptgradnesterovCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_model_make(size : Int) -> OptgradnesterovModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradnesterovModel::len(self : OptgradnesterovModel) -> Int { self.size }

pub fn OptgradnesterovModel::get(self : OptgradnesterovModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradnesterovModel::set(self : OptgradnesterovModel, i : Int, v : Double) -> OptgradnesterovModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradnesterovModel::sum(self : OptgradnesterovModel) -> Double { @_common.sum(self.data) }

pub fn OptgradnesterovModel::mean(self : OptgradnesterovModel) -> Double { @_common.mean(self.data) }

pub fn OptgradnesterovModel::scale(self : OptgradnesterovModel, f : Double) -> OptgradnesterovModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovModel::add(self : OptgradnesterovModel, other : OptgradnesterovModel) -> OptgradnesterovModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradnesterovModel::copy(self : OptgradnesterovModel) -> OptgradnesterovModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovModel::fill(self : OptgradnesterovModel, v : Double) -> OptgradnesterovModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovModel::min(self : OptgradnesterovModel) -> Double { @_common.min(self.data) }

pub fn OptgradnesterovModel::max(self : OptgradnesterovModel) -> Double { @_common.max(self.data) }

pub fn OptgradnesterovModel::to_string(self : OptgradnesterovModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_layer_make(size : Int) -> OptgradnesterovLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradnesterovLayer::len(self : OptgradnesterovLayer) -> Int { self.size }

pub fn OptgradnesterovLayer::get(self : OptgradnesterovLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradnesterovLayer::set(self : OptgradnesterovLayer, i : Int, v : Double) -> OptgradnesterovLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradnesterovLayer::sum(self : OptgradnesterovLayer) -> Double { @_common.sum(self.data) }

pub fn OptgradnesterovLayer::mean(self : OptgradnesterovLayer) -> Double { @_common.mean(self.data) }

pub fn OptgradnesterovLayer::scale(self : OptgradnesterovLayer, f : Double) -> OptgradnesterovLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovLayer::add(self : OptgradnesterovLayer, other : OptgradnesterovLayer) -> OptgradnesterovLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradnesterovLayer::copy(self : OptgradnesterovLayer) -> OptgradnesterovLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovLayer::fill(self : OptgradnesterovLayer, v : Double) -> OptgradnesterovLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovLayer::min(self : OptgradnesterovLayer) -> Double { @_common.min(self.data) }

pub fn OptgradnesterovLayer::max(self : OptgradnesterovLayer) -> Double { @_common.max(self.data) }

pub fn OptgradnesterovLayer::to_string(self : OptgradnesterovLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_buffer_make(size : Int) -> OptgradnesterovBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradnesterovBuffer::len(self : OptgradnesterovBuffer) -> Int { self.size }

pub fn OptgradnesterovBuffer::get(self : OptgradnesterovBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradnesterovBuffer::set(self : OptgradnesterovBuffer, i : Int, v : Double) -> OptgradnesterovBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradnesterovBuffer::sum(self : OptgradnesterovBuffer) -> Double { @_common.sum(self.data) }

pub fn OptgradnesterovBuffer::mean(self : OptgradnesterovBuffer) -> Double { @_common.mean(self.data) }

pub fn OptgradnesterovBuffer::scale(self : OptgradnesterovBuffer, f : Double) -> OptgradnesterovBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovBuffer::add(self : OptgradnesterovBuffer, other : OptgradnesterovBuffer) -> OptgradnesterovBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradnesterovBuffer::copy(self : OptgradnesterovBuffer) -> OptgradnesterovBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovBuffer::fill(self : OptgradnesterovBuffer, v : Double) -> OptgradnesterovBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovBuffer::min(self : OptgradnesterovBuffer) -> Double { @_common.min(self.data) }

pub fn OptgradnesterovBuffer::max(self : OptgradnesterovBuffer) -> Double { @_common.max(self.data) }

pub fn OptgradnesterovBuffer::to_string(self : OptgradnesterovBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_cursor_make(size : Int) -> OptgradnesterovCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradnesterovCursor::len(self : OptgradnesterovCursor) -> Int { self.size }

pub fn OptgradnesterovCursor::get(self : OptgradnesterovCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradnesterovCursor::set(self : OptgradnesterovCursor, i : Int, v : Double) -> OptgradnesterovCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradnesterovCursor::sum(self : OptgradnesterovCursor) -> Double { @_common.sum(self.data) }

pub fn OptgradnesterovCursor::mean(self : OptgradnesterovCursor) -> Double { @_common.mean(self.data) }

pub fn OptgradnesterovCursor::scale(self : OptgradnesterovCursor, f : Double) -> OptgradnesterovCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovCursor::add(self : OptgradnesterovCursor, other : OptgradnesterovCursor) -> OptgradnesterovCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradnesterovCursor::copy(self : OptgradnesterovCursor) -> OptgradnesterovCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovCursor::fill(self : OptgradnesterovCursor, v : Double) -> OptgradnesterovCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovCursor::min(self : OptgradnesterovCursor) -> Double { @_common.min(self.data) }

pub fn OptgradnesterovCursor::max(self : OptgradnesterovCursor) -> Double { @_common.max(self.data) }

pub fn OptgradnesterovCursor::to_string(self : OptgradnesterovCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_view_make(size : Int) -> OptgradnesterovView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradnesterovView::len(self : OptgradnesterovView) -> Int { self.size }

pub fn OptgradnesterovView::get(self : OptgradnesterovView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradnesterovView::set(self : OptgradnesterovView, i : Int, v : Double) -> OptgradnesterovView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradnesterovView::sum(self : OptgradnesterovView) -> Double { @_common.sum(self.data) }

pub fn OptgradnesterovView::mean(self : OptgradnesterovView) -> Double { @_common.mean(self.data) }

pub fn OptgradnesterovView::scale(self : OptgradnesterovView, f : Double) -> OptgradnesterovView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovView::add(self : OptgradnesterovView, other : OptgradnesterovView) -> OptgradnesterovView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradnesterovView::copy(self : OptgradnesterovView) -> OptgradnesterovView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovView::fill(self : OptgradnesterovView, v : Double) -> OptgradnesterovView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovView::min(self : OptgradnesterovView) -> Double { @_common.min(self.data) }

pub fn OptgradnesterovView::max(self : OptgradnesterovView) -> Double { @_common.max(self.data) }

pub fn OptgradnesterovView::to_string(self : OptgradnesterovView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_range_make(size : Int) -> OptgradnesterovRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradnesterovRange::len(self : OptgradnesterovRange) -> Int { self.size }

pub fn OptgradnesterovRange::get(self : OptgradnesterovRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradnesterovRange::set(self : OptgradnesterovRange, i : Int, v : Double) -> OptgradnesterovRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradnesterovRange::sum(self : OptgradnesterovRange) -> Double { @_common.sum(self.data) }

pub fn OptgradnesterovRange::mean(self : OptgradnesterovRange) -> Double { @_common.mean(self.data) }

pub fn OptgradnesterovRange::scale(self : OptgradnesterovRange, f : Double) -> OptgradnesterovRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovRange::add(self : OptgradnesterovRange, other : OptgradnesterovRange) -> OptgradnesterovRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradnesterovRange::copy(self : OptgradnesterovRange) -> OptgradnesterovRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovRange::fill(self : OptgradnesterovRange, v : Double) -> OptgradnesterovRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovRange::min(self : OptgradnesterovRange) -> Double { @_common.min(self.data) }

pub fn OptgradnesterovRange::max(self : OptgradnesterovRange) -> Double { @_common.max(self.data) }

pub fn OptgradnesterovRange::to_string(self : OptgradnesterovRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradnesterovSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nesterov_slice_make(size : Int) -> OptgradnesterovSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradnesterovSlice::len(self : OptgradnesterovSlice) -> Int { self.size }

pub fn OptgradnesterovSlice::get(self : OptgradnesterovSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradnesterovSlice::set(self : OptgradnesterovSlice, i : Int, v : Double) -> OptgradnesterovSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradnesterovSlice::sum(self : OptgradnesterovSlice) -> Double { @_common.sum(self.data) }

pub fn OptgradnesterovSlice::mean(self : OptgradnesterovSlice) -> Double { @_common.mean(self.data) }

pub fn OptgradnesterovSlice::scale(self : OptgradnesterovSlice, f : Double) -> OptgradnesterovSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovSlice::add(self : OptgradnesterovSlice, other : OptgradnesterovSlice) -> OptgradnesterovSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradnesterovSlice::copy(self : OptgradnesterovSlice) -> OptgradnesterovSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovSlice::fill(self : OptgradnesterovSlice, v : Double) -> OptgradnesterovSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradnesterovSlice::min(self : OptgradnesterovSlice) -> Double { @_common.min(self.data) }

pub fn OptgradnesterovSlice::max(self : OptgradnesterovSlice) -> Double { @_common.max(self.data) }

pub fn OptgradnesterovSlice::to_string(self : OptgradnesterovSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

