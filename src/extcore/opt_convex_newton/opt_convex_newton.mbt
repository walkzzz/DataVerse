///===
/// extcore/opt_convex_newton

pub(all) struct OptconvexnewtonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_newton_make_point(x : Double, y : Double) -> OptconvexnewtonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_newton_make_point3(x : Double, y : Double, z : Double) -> OptconvexnewtonPoint {
  { x, y, z, label: 0 }
}

pub fn OptconvexnewtonPoint::x(self : OptconvexnewtonPoint) -> Double { self.x }

pub fn OptconvexnewtonPoint::y(self : OptconvexnewtonPoint) -> Double { self.y }

pub fn OptconvexnewtonPoint::z(self : OptconvexnewtonPoint) -> Double { self.z }

pub fn OptconvexnewtonPoint::label(self : OptconvexnewtonPoint) -> Int { self.label }

pub fn OptconvexnewtonPoint::dist(self : OptconvexnewtonPoint, other : OptconvexnewtonPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvexnewtonPoint::add(self : OptconvexnewtonPoint, other : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvexnewtonPoint::sub(self : OptconvexnewtonPoint, other : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvexnewtonPoint::scale(self : OptconvexnewtonPoint, s : Double) -> OptconvexnewtonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvexnewtonPoint::dot(self : OptconvexnewtonPoint, other : OptconvexnewtonPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvexnewtonPoint::cross(self : OptconvexnewtonPoint, other : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvexnewtonPoint::norm(self : OptconvexnewtonPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvexnewtonPoint::normalize(self : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexnewtonPoint::negate(self : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvexnewtonPoint::mid(self : OptconvexnewtonPoint, other : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvexnewtonPoint::lerp(self : OptconvexnewtonPoint, other : OptconvexnewtonPoint, t : Double) -> OptconvexnewtonPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvexnewtonPoint::to_string(self : OptconvexnewtonPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvexnewtonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_newton_make_series(vals : Array[Double], name : String) -> OptconvexnewtonSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvexnewtonSeries::len(self : OptconvexnewtonSeries) -> Int { self.vals.length() }

pub fn OptconvexnewtonSeries::sum(self : OptconvexnewtonSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvexnewtonSeries::mean(self : OptconvexnewtonSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvexnewtonSeries::min(self : OptconvexnewtonSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvexnewtonSeries::max(self : OptconvexnewtonSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvexnewtonSeries::range(self : OptconvexnewtonSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvexnewtonSeries::variance(self : OptconvexnewtonSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvexnewtonSeries::std(self : OptconvexnewtonSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvexnewtonSeries::median(self : OptconvexnewtonSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvexnewtonSeries::scale(self : OptconvexnewtonSeries, f : Double) -> OptconvexnewtonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvexnewtonSeries::add(self : OptconvexnewtonSeries, other : OptconvexnewtonSeries) -> OptconvexnewtonSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvexnewtonSeries::sub(self : OptconvexnewtonSeries, other : OptconvexnewtonSeries) -> OptconvexnewtonSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvexnewtonSeries::normalize(self : OptconvexnewtonSeries) -> OptconvexnewtonSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvexnewtonSeries::cumsum(self : OptconvexnewtonSeries) -> OptconvexnewtonSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvexnewtonSeries::to_string(self : OptconvexnewtonSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexnewtonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_newton_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexnewtonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_newton_matrix_identity(n : Int) -> OptconvexnewtonMatrix {
  let m = opt_convex_newton_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvexnewtonMatrix::get(self : OptconvexnewtonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvexnewtonMatrix::transpose(self : OptconvexnewtonMatrix) -> OptconvexnewtonMatrix {
  let result = opt_convex_newton_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvexnewtonMatrix::add(self : OptconvexnewtonMatrix, other : OptconvexnewtonMatrix) -> OptconvexnewtonMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_newton_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvexnewtonMatrix::scale(self : OptconvexnewtonMatrix, s : Double) -> OptconvexnewtonMatrix {
  let result = opt_convex_newton_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvexnewtonMatrix::multiply(self : OptconvexnewtonMatrix, other : OptconvexnewtonMatrix) -> OptconvexnewtonMatrix {
  if self.cols != other.rows { return opt_convex_newton_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_newton_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptconvexnewtonMatrix::trace(self : OptconvexnewtonMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvexnewtonMatrix::det(self : OptconvexnewtonMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvexnewtonMatrix::norm(self : OptconvexnewtonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvexnewtonMatrix::to_string(self : OptconvexnewtonMatrix) -> String {
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

pub(all) struct OptconvexnewtonVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_newton_make_vector(comps : Array[Double]) -> OptconvexnewtonVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_newton_vector_zero(dim : Int) -> OptconvexnewtonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvexnewtonVector::add(self : OptconvexnewtonVector, other : OptconvexnewtonVector) -> OptconvexnewtonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexnewtonVector::sub(self : OptconvexnewtonVector, other : OptconvexnewtonVector) -> OptconvexnewtonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexnewtonVector::scale(self : OptconvexnewtonVector, s : Double) -> OptconvexnewtonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvexnewtonVector::dot(self : OptconvexnewtonVector, other : OptconvexnewtonVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvexnewtonVector::norm(self : OptconvexnewtonVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvexnewtonVector::normalize(self : OptconvexnewtonVector) -> OptconvexnewtonVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexnewtonVector::dist(self : OptconvexnewtonVector, other : OptconvexnewtonVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvexnewtonVector::to_string(self : OptconvexnewtonVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexnewtonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_frame_make(size : Int) -> OptconvexnewtonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexnewtonFrame::len(self : OptconvexnewtonFrame) -> Int { self.size }

pub fn OptconvexnewtonFrame::get(self : OptconvexnewtonFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexnewtonFrame::set(self : OptconvexnewtonFrame, i : Int, v : Double) -> OptconvexnewtonFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonFrame::sum(self : OptconvexnewtonFrame) -> Double { @_common.sum(self.data) }

pub fn OptconvexnewtonFrame::mean(self : OptconvexnewtonFrame) -> Double { @_common.mean(self.data) }

pub fn OptconvexnewtonFrame::scale(self : OptconvexnewtonFrame, f : Double) -> OptconvexnewtonFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonFrame::add(self : OptconvexnewtonFrame, other : OptconvexnewtonFrame) -> OptconvexnewtonFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexnewtonFrame::copy(self : OptconvexnewtonFrame) -> OptconvexnewtonFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonFrame::fill(self : OptconvexnewtonFrame, v : Double) -> OptconvexnewtonFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonFrame::min(self : OptconvexnewtonFrame) -> Double { @_common.min(self.data) }

pub fn OptconvexnewtonFrame::max(self : OptconvexnewtonFrame) -> Double { @_common.max(self.data) }

pub fn OptconvexnewtonFrame::to_string(self : OptconvexnewtonFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_table_make(size : Int) -> OptconvexnewtonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexnewtonTable::len(self : OptconvexnewtonTable) -> Int { self.size }

pub fn OptconvexnewtonTable::get(self : OptconvexnewtonTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexnewtonTable::set(self : OptconvexnewtonTable, i : Int, v : Double) -> OptconvexnewtonTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonTable::sum(self : OptconvexnewtonTable) -> Double { @_common.sum(self.data) }

pub fn OptconvexnewtonTable::mean(self : OptconvexnewtonTable) -> Double { @_common.mean(self.data) }

pub fn OptconvexnewtonTable::scale(self : OptconvexnewtonTable, f : Double) -> OptconvexnewtonTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonTable::add(self : OptconvexnewtonTable, other : OptconvexnewtonTable) -> OptconvexnewtonTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexnewtonTable::copy(self : OptconvexnewtonTable) -> OptconvexnewtonTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonTable::fill(self : OptconvexnewtonTable, v : Double) -> OptconvexnewtonTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonTable::min(self : OptconvexnewtonTable) -> Double { @_common.min(self.data) }

pub fn OptconvexnewtonTable::max(self : OptconvexnewtonTable) -> Double { @_common.max(self.data) }

pub fn OptconvexnewtonTable::to_string(self : OptconvexnewtonTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_graphn_make(size : Int) -> OptconvexnewtonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexnewtonGraphN::len(self : OptconvexnewtonGraphN) -> Int { self.size }

pub fn OptconvexnewtonGraphN::get(self : OptconvexnewtonGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexnewtonGraphN::set(self : OptconvexnewtonGraphN, i : Int, v : Double) -> OptconvexnewtonGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonGraphN::sum(self : OptconvexnewtonGraphN) -> Double { @_common.sum(self.data) }

pub fn OptconvexnewtonGraphN::mean(self : OptconvexnewtonGraphN) -> Double { @_common.mean(self.data) }

pub fn OptconvexnewtonGraphN::scale(self : OptconvexnewtonGraphN, f : Double) -> OptconvexnewtonGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonGraphN::add(self : OptconvexnewtonGraphN, other : OptconvexnewtonGraphN) -> OptconvexnewtonGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexnewtonGraphN::copy(self : OptconvexnewtonGraphN) -> OptconvexnewtonGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonGraphN::fill(self : OptconvexnewtonGraphN, v : Double) -> OptconvexnewtonGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonGraphN::min(self : OptconvexnewtonGraphN) -> Double { @_common.min(self.data) }

pub fn OptconvexnewtonGraphN::max(self : OptconvexnewtonGraphN) -> Double { @_common.max(self.data) }

pub fn OptconvexnewtonGraphN::to_string(self : OptconvexnewtonGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_node_make(size : Int) -> OptconvexnewtonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexnewtonNode::len(self : OptconvexnewtonNode) -> Int { self.size }

pub fn OptconvexnewtonNode::get(self : OptconvexnewtonNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexnewtonNode::set(self : OptconvexnewtonNode, i : Int, v : Double) -> OptconvexnewtonNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonNode::sum(self : OptconvexnewtonNode) -> Double { @_common.sum(self.data) }

pub fn OptconvexnewtonNode::mean(self : OptconvexnewtonNode) -> Double { @_common.mean(self.data) }

pub fn OptconvexnewtonNode::scale(self : OptconvexnewtonNode, f : Double) -> OptconvexnewtonNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonNode::add(self : OptconvexnewtonNode, other : OptconvexnewtonNode) -> OptconvexnewtonNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexnewtonNode::copy(self : OptconvexnewtonNode) -> OptconvexnewtonNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonNode::fill(self : OptconvexnewtonNode, v : Double) -> OptconvexnewtonNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonNode::min(self : OptconvexnewtonNode) -> Double { @_common.min(self.data) }

pub fn OptconvexnewtonNode::max(self : OptconvexnewtonNode) -> Double { @_common.max(self.data) }

pub fn OptconvexnewtonNode::to_string(self : OptconvexnewtonNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_edge_make(size : Int) -> OptconvexnewtonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexnewtonEdge::len(self : OptconvexnewtonEdge) -> Int { self.size }

pub fn OptconvexnewtonEdge::get(self : OptconvexnewtonEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexnewtonEdge::set(self : OptconvexnewtonEdge, i : Int, v : Double) -> OptconvexnewtonEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonEdge::sum(self : OptconvexnewtonEdge) -> Double { @_common.sum(self.data) }

pub fn OptconvexnewtonEdge::mean(self : OptconvexnewtonEdge) -> Double { @_common.mean(self.data) }

pub fn OptconvexnewtonEdge::scale(self : OptconvexnewtonEdge, f : Double) -> OptconvexnewtonEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonEdge::add(self : OptconvexnewtonEdge, other : OptconvexnewtonEdge) -> OptconvexnewtonEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexnewtonEdge::copy(self : OptconvexnewtonEdge) -> OptconvexnewtonEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonEdge::fill(self : OptconvexnewtonEdge, v : Double) -> OptconvexnewtonEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonEdge::min(self : OptconvexnewtonEdge) -> Double { @_common.min(self.data) }

pub fn OptconvexnewtonEdge::max(self : OptconvexnewtonEdge) -> Double { @_common.max(self.data) }

pub fn OptconvexnewtonEdge::to_string(self : OptconvexnewtonEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_path_make(size : Int) -> OptconvexnewtonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexnewtonPath::len(self : OptconvexnewtonPath) -> Int { self.size }

pub fn OptconvexnewtonPath::get(self : OptconvexnewtonPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexnewtonPath::set(self : OptconvexnewtonPath, i : Int, v : Double) -> OptconvexnewtonPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonPath::sum(self : OptconvexnewtonPath) -> Double { @_common.sum(self.data) }

pub fn OptconvexnewtonPath::mean(self : OptconvexnewtonPath) -> Double { @_common.mean(self.data) }

pub fn OptconvexnewtonPath::scale(self : OptconvexnewtonPath, f : Double) -> OptconvexnewtonPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonPath::add(self : OptconvexnewtonPath, other : OptconvexnewtonPath) -> OptconvexnewtonPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexnewtonPath::copy(self : OptconvexnewtonPath) -> OptconvexnewtonPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonPath::fill(self : OptconvexnewtonPath, v : Double) -> OptconvexnewtonPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonPath::min(self : OptconvexnewtonPath) -> Double { @_common.min(self.data) }

pub fn OptconvexnewtonPath::max(self : OptconvexnewtonPath) -> Double { @_common.max(self.data) }

pub fn OptconvexnewtonPath::to_string(self : OptconvexnewtonPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_cluster_make(size : Int) -> OptconvexnewtonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexnewtonCluster::len(self : OptconvexnewtonCluster) -> Int { self.size }

pub fn OptconvexnewtonCluster::get(self : OptconvexnewtonCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexnewtonCluster::set(self : OptconvexnewtonCluster, i : Int, v : Double) -> OptconvexnewtonCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonCluster::sum(self : OptconvexnewtonCluster) -> Double { @_common.sum(self.data) }

pub fn OptconvexnewtonCluster::mean(self : OptconvexnewtonCluster) -> Double { @_common.mean(self.data) }

pub fn OptconvexnewtonCluster::scale(self : OptconvexnewtonCluster, f : Double) -> OptconvexnewtonCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonCluster::add(self : OptconvexnewtonCluster, other : OptconvexnewtonCluster) -> OptconvexnewtonCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexnewtonCluster::copy(self : OptconvexnewtonCluster) -> OptconvexnewtonCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonCluster::fill(self : OptconvexnewtonCluster, v : Double) -> OptconvexnewtonCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonCluster::min(self : OptconvexnewtonCluster) -> Double { @_common.min(self.data) }

pub fn OptconvexnewtonCluster::max(self : OptconvexnewtonCluster) -> Double { @_common.max(self.data) }

pub fn OptconvexnewtonCluster::to_string(self : OptconvexnewtonCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_model_make(size : Int) -> OptconvexnewtonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexnewtonModel::len(self : OptconvexnewtonModel) -> Int { self.size }

pub fn OptconvexnewtonModel::get(self : OptconvexnewtonModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexnewtonModel::set(self : OptconvexnewtonModel, i : Int, v : Double) -> OptconvexnewtonModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonModel::sum(self : OptconvexnewtonModel) -> Double { @_common.sum(self.data) }

pub fn OptconvexnewtonModel::mean(self : OptconvexnewtonModel) -> Double { @_common.mean(self.data) }

pub fn OptconvexnewtonModel::scale(self : OptconvexnewtonModel, f : Double) -> OptconvexnewtonModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonModel::add(self : OptconvexnewtonModel, other : OptconvexnewtonModel) -> OptconvexnewtonModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexnewtonModel::copy(self : OptconvexnewtonModel) -> OptconvexnewtonModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonModel::fill(self : OptconvexnewtonModel, v : Double) -> OptconvexnewtonModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonModel::min(self : OptconvexnewtonModel) -> Double { @_common.min(self.data) }

pub fn OptconvexnewtonModel::max(self : OptconvexnewtonModel) -> Double { @_common.max(self.data) }

pub fn OptconvexnewtonModel::to_string(self : OptconvexnewtonModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_layer_make(size : Int) -> OptconvexnewtonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexnewtonLayer::len(self : OptconvexnewtonLayer) -> Int { self.size }

pub fn OptconvexnewtonLayer::get(self : OptconvexnewtonLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexnewtonLayer::set(self : OptconvexnewtonLayer, i : Int, v : Double) -> OptconvexnewtonLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonLayer::sum(self : OptconvexnewtonLayer) -> Double { @_common.sum(self.data) }

pub fn OptconvexnewtonLayer::mean(self : OptconvexnewtonLayer) -> Double { @_common.mean(self.data) }

pub fn OptconvexnewtonLayer::scale(self : OptconvexnewtonLayer, f : Double) -> OptconvexnewtonLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonLayer::add(self : OptconvexnewtonLayer, other : OptconvexnewtonLayer) -> OptconvexnewtonLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexnewtonLayer::copy(self : OptconvexnewtonLayer) -> OptconvexnewtonLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonLayer::fill(self : OptconvexnewtonLayer, v : Double) -> OptconvexnewtonLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonLayer::min(self : OptconvexnewtonLayer) -> Double { @_common.min(self.data) }

pub fn OptconvexnewtonLayer::max(self : OptconvexnewtonLayer) -> Double { @_common.max(self.data) }

pub fn OptconvexnewtonLayer::to_string(self : OptconvexnewtonLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_buffer_make(size : Int) -> OptconvexnewtonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexnewtonBuffer::len(self : OptconvexnewtonBuffer) -> Int { self.size }

pub fn OptconvexnewtonBuffer::get(self : OptconvexnewtonBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexnewtonBuffer::set(self : OptconvexnewtonBuffer, i : Int, v : Double) -> OptconvexnewtonBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonBuffer::sum(self : OptconvexnewtonBuffer) -> Double { @_common.sum(self.data) }

pub fn OptconvexnewtonBuffer::mean(self : OptconvexnewtonBuffer) -> Double { @_common.mean(self.data) }

pub fn OptconvexnewtonBuffer::scale(self : OptconvexnewtonBuffer, f : Double) -> OptconvexnewtonBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonBuffer::add(self : OptconvexnewtonBuffer, other : OptconvexnewtonBuffer) -> OptconvexnewtonBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexnewtonBuffer::copy(self : OptconvexnewtonBuffer) -> OptconvexnewtonBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonBuffer::fill(self : OptconvexnewtonBuffer, v : Double) -> OptconvexnewtonBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonBuffer::min(self : OptconvexnewtonBuffer) -> Double { @_common.min(self.data) }

pub fn OptconvexnewtonBuffer::max(self : OptconvexnewtonBuffer) -> Double { @_common.max(self.data) }

pub fn OptconvexnewtonBuffer::to_string(self : OptconvexnewtonBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_cursor_make(size : Int) -> OptconvexnewtonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexnewtonCursor::len(self : OptconvexnewtonCursor) -> Int { self.size }

pub fn OptconvexnewtonCursor::get(self : OptconvexnewtonCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexnewtonCursor::set(self : OptconvexnewtonCursor, i : Int, v : Double) -> OptconvexnewtonCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonCursor::sum(self : OptconvexnewtonCursor) -> Double { @_common.sum(self.data) }

pub fn OptconvexnewtonCursor::mean(self : OptconvexnewtonCursor) -> Double { @_common.mean(self.data) }

pub fn OptconvexnewtonCursor::scale(self : OptconvexnewtonCursor, f : Double) -> OptconvexnewtonCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonCursor::add(self : OptconvexnewtonCursor, other : OptconvexnewtonCursor) -> OptconvexnewtonCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexnewtonCursor::copy(self : OptconvexnewtonCursor) -> OptconvexnewtonCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonCursor::fill(self : OptconvexnewtonCursor, v : Double) -> OptconvexnewtonCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonCursor::min(self : OptconvexnewtonCursor) -> Double { @_common.min(self.data) }

pub fn OptconvexnewtonCursor::max(self : OptconvexnewtonCursor) -> Double { @_common.max(self.data) }

pub fn OptconvexnewtonCursor::to_string(self : OptconvexnewtonCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_view_make(size : Int) -> OptconvexnewtonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexnewtonView::len(self : OptconvexnewtonView) -> Int { self.size }

pub fn OptconvexnewtonView::get(self : OptconvexnewtonView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexnewtonView::set(self : OptconvexnewtonView, i : Int, v : Double) -> OptconvexnewtonView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonView::sum(self : OptconvexnewtonView) -> Double { @_common.sum(self.data) }

pub fn OptconvexnewtonView::mean(self : OptconvexnewtonView) -> Double { @_common.mean(self.data) }

pub fn OptconvexnewtonView::scale(self : OptconvexnewtonView, f : Double) -> OptconvexnewtonView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonView::add(self : OptconvexnewtonView, other : OptconvexnewtonView) -> OptconvexnewtonView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexnewtonView::copy(self : OptconvexnewtonView) -> OptconvexnewtonView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonView::fill(self : OptconvexnewtonView, v : Double) -> OptconvexnewtonView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonView::min(self : OptconvexnewtonView) -> Double { @_common.min(self.data) }

pub fn OptconvexnewtonView::max(self : OptconvexnewtonView) -> Double { @_common.max(self.data) }

pub fn OptconvexnewtonView::to_string(self : OptconvexnewtonView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_range_make(size : Int) -> OptconvexnewtonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexnewtonRange::len(self : OptconvexnewtonRange) -> Int { self.size }

pub fn OptconvexnewtonRange::get(self : OptconvexnewtonRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexnewtonRange::set(self : OptconvexnewtonRange, i : Int, v : Double) -> OptconvexnewtonRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonRange::sum(self : OptconvexnewtonRange) -> Double { @_common.sum(self.data) }

pub fn OptconvexnewtonRange::mean(self : OptconvexnewtonRange) -> Double { @_common.mean(self.data) }

pub fn OptconvexnewtonRange::scale(self : OptconvexnewtonRange, f : Double) -> OptconvexnewtonRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonRange::add(self : OptconvexnewtonRange, other : OptconvexnewtonRange) -> OptconvexnewtonRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexnewtonRange::copy(self : OptconvexnewtonRange) -> OptconvexnewtonRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonRange::fill(self : OptconvexnewtonRange, v : Double) -> OptconvexnewtonRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonRange::min(self : OptconvexnewtonRange) -> Double { @_common.min(self.data) }

pub fn OptconvexnewtonRange::max(self : OptconvexnewtonRange) -> Double { @_common.max(self.data) }

pub fn OptconvexnewtonRange::to_string(self : OptconvexnewtonRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_slice_make(size : Int) -> OptconvexnewtonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexnewtonSlice::len(self : OptconvexnewtonSlice) -> Int { self.size }

pub fn OptconvexnewtonSlice::get(self : OptconvexnewtonSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexnewtonSlice::set(self : OptconvexnewtonSlice, i : Int, v : Double) -> OptconvexnewtonSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonSlice::sum(self : OptconvexnewtonSlice) -> Double { @_common.sum(self.data) }

pub fn OptconvexnewtonSlice::mean(self : OptconvexnewtonSlice) -> Double { @_common.mean(self.data) }

pub fn OptconvexnewtonSlice::scale(self : OptconvexnewtonSlice, f : Double) -> OptconvexnewtonSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonSlice::add(self : OptconvexnewtonSlice, other : OptconvexnewtonSlice) -> OptconvexnewtonSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexnewtonSlice::copy(self : OptconvexnewtonSlice) -> OptconvexnewtonSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonSlice::fill(self : OptconvexnewtonSlice, v : Double) -> OptconvexnewtonSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexnewtonSlice::min(self : OptconvexnewtonSlice) -> Double { @_common.min(self.data) }

pub fn OptconvexnewtonSlice::max(self : OptconvexnewtonSlice) -> Double { @_common.max(self.data) }

pub fn OptconvexnewtonSlice::to_string(self : OptconvexnewtonSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

