///===
/// extcore/opt_grad_adamax

pub(all) struct OptgradadamaxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_adamax_make_point(x : Double, y : Double) -> OptgradadamaxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_adamax_make_point3(x : Double, y : Double, z : Double) -> OptgradadamaxPoint {
  { x, y, z, label: 0 }
}

pub fn OptgradadamaxPoint::x(self : OptgradadamaxPoint) -> Double { self.x }

pub fn OptgradadamaxPoint::y(self : OptgradadamaxPoint) -> Double { self.y }

pub fn OptgradadamaxPoint::z(self : OptgradadamaxPoint) -> Double { self.z }

pub fn OptgradadamaxPoint::label(self : OptgradadamaxPoint) -> Int { self.label }

pub fn OptgradadamaxPoint::dist(self : OptgradadamaxPoint, other : OptgradadamaxPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptgradadamaxPoint::add(self : OptgradadamaxPoint, other : OptgradadamaxPoint) -> OptgradadamaxPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptgradadamaxPoint::sub(self : OptgradadamaxPoint, other : OptgradadamaxPoint) -> OptgradadamaxPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptgradadamaxPoint::scale(self : OptgradadamaxPoint, s : Double) -> OptgradadamaxPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptgradadamaxPoint::dot(self : OptgradadamaxPoint, other : OptgradadamaxPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptgradadamaxPoint::cross(self : OptgradadamaxPoint, other : OptgradadamaxPoint) -> OptgradadamaxPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptgradadamaxPoint::norm(self : OptgradadamaxPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptgradadamaxPoint::normalize(self : OptgradadamaxPoint) -> OptgradadamaxPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradadamaxPoint::negate(self : OptgradadamaxPoint) -> OptgradadamaxPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptgradadamaxPoint::mid(self : OptgradadamaxPoint, other : OptgradadamaxPoint) -> OptgradadamaxPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptgradadamaxPoint::lerp(self : OptgradadamaxPoint, other : OptgradadamaxPoint, t : Double) -> OptgradadamaxPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptgradadamaxPoint::to_string(self : OptgradadamaxPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptgradadamaxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_adamax_make_series(vals : Array[Double], name : String) -> OptgradadamaxSeries {
  { vals, name, meta: 0 }
}

pub fn OptgradadamaxSeries::len(self : OptgradadamaxSeries) -> Int { self.vals.length() }

pub fn OptgradadamaxSeries::sum(self : OptgradadamaxSeries) -> Double { @_common.sum(self.vals) }

pub fn OptgradadamaxSeries::mean(self : OptgradadamaxSeries) -> Double { @_common.mean(self.vals) }

pub fn OptgradadamaxSeries::min(self : OptgradadamaxSeries) -> Double { @_common.min(self.vals) }

pub fn OptgradadamaxSeries::max(self : OptgradadamaxSeries) -> Double { @_common.max(self.vals) }

pub fn OptgradadamaxSeries::range(self : OptgradadamaxSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptgradadamaxSeries::variance(self : OptgradadamaxSeries) -> Double { @_common.variance(self.vals) }

pub fn OptgradadamaxSeries::std(self : OptgradadamaxSeries) -> Double { @_common.std(self.vals) }

pub fn OptgradadamaxSeries::median(self : OptgradadamaxSeries) -> Double { @_common.median(self.vals) }

pub fn OptgradadamaxSeries::scale(self : OptgradadamaxSeries, f : Double) -> OptgradadamaxSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptgradadamaxSeries::add(self : OptgradadamaxSeries, other : OptgradadamaxSeries) -> OptgradadamaxSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptgradadamaxSeries::sub(self : OptgradadamaxSeries, other : OptgradadamaxSeries) -> OptgradadamaxSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptgradadamaxSeries::normalize(self : OptgradadamaxSeries) -> OptgradadamaxSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptgradadamaxSeries::cumsum(self : OptgradadamaxSeries) -> OptgradadamaxSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptgradadamaxSeries::to_string(self : OptgradadamaxSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradadamaxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_adamax_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradadamaxMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn opt_grad_adamax_matrix_identity(n : Int) -> OptgradadamaxMatrix {
  let m = opt_grad_adamax_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptgradadamaxMatrix::get(self : OptgradadamaxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptgradadamaxMatrix::transpose(self : OptgradadamaxMatrix) -> OptgradadamaxMatrix {
  let result = opt_grad_adamax_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptgradadamaxMatrix::add(self : OptgradadamaxMatrix, other : OptgradadamaxMatrix) -> OptgradadamaxMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_grad_adamax_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptgradadamaxMatrix::scale(self : OptgradadamaxMatrix, s : Double) -> OptgradadamaxMatrix {
  let result = opt_grad_adamax_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptgradadamaxMatrix::multiply(self : OptgradadamaxMatrix, other : OptgradadamaxMatrix) -> OptgradadamaxMatrix {
  if self.cols != other.rows { return opt_grad_adamax_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_grad_adamax_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn OptgradadamaxMatrix::trace(self : OptgradadamaxMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptgradadamaxMatrix::det(self : OptgradadamaxMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptgradadamaxMatrix::norm(self : OptgradadamaxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptgradadamaxMatrix::to_string(self : OptgradadamaxMatrix) -> String {
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

pub(all) struct OptgradadamaxVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_adamax_make_vector(comps : Array[Double]) -> OptgradadamaxVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_adamax_vector_zero(dim : Int) -> OptgradadamaxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptgradadamaxVector::add(self : OptgradadamaxVector, other : OptgradadamaxVector) -> OptgradadamaxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradadamaxVector::sub(self : OptgradadamaxVector, other : OptgradadamaxVector) -> OptgradadamaxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradadamaxVector::scale(self : OptgradadamaxVector, s : Double) -> OptgradadamaxVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptgradadamaxVector::dot(self : OptgradadamaxVector, other : OptgradadamaxVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptgradadamaxVector::norm(self : OptgradadamaxVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptgradadamaxVector::normalize(self : OptgradadamaxVector) -> OptgradadamaxVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradadamaxVector::dist(self : OptgradadamaxVector, other : OptgradadamaxVector) -> Double {
  self.sub(other).norm()
}

pub fn OptgradadamaxVector::to_string(self : OptgradadamaxVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradadamaxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_frame_make(size : Int) -> OptgradadamaxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamaxFrame::len(self : OptgradadamaxFrame) -> Int { self.size }

pub fn OptgradadamaxFrame::get(self : OptgradadamaxFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamaxFrame::set(self : OptgradadamaxFrame, i : Int, v : Double) -> OptgradadamaxFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamaxFrame::sum(self : OptgradadamaxFrame) -> Double { @_common.sum(self.data) }

pub fn OptgradadamaxFrame::mean(self : OptgradadamaxFrame) -> Double { @_common.mean(self.data) }

pub fn OptgradadamaxFrame::scale(self : OptgradadamaxFrame, f : Double) -> OptgradadamaxFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxFrame::add(self : OptgradadamaxFrame, other : OptgradadamaxFrame) -> OptgradadamaxFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamaxFrame::copy(self : OptgradadamaxFrame) -> OptgradadamaxFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxFrame::fill(self : OptgradadamaxFrame, v : Double) -> OptgradadamaxFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxFrame::min(self : OptgradadamaxFrame) -> Double { @_common.min(self.data) }

pub fn OptgradadamaxFrame::max(self : OptgradadamaxFrame) -> Double { @_common.max(self.data) }

pub fn OptgradadamaxFrame::to_string(self : OptgradadamaxFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_table_make(size : Int) -> OptgradadamaxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamaxTable::len(self : OptgradadamaxTable) -> Int { self.size }

pub fn OptgradadamaxTable::get(self : OptgradadamaxTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamaxTable::set(self : OptgradadamaxTable, i : Int, v : Double) -> OptgradadamaxTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamaxTable::sum(self : OptgradadamaxTable) -> Double { @_common.sum(self.data) }

pub fn OptgradadamaxTable::mean(self : OptgradadamaxTable) -> Double { @_common.mean(self.data) }

pub fn OptgradadamaxTable::scale(self : OptgradadamaxTable, f : Double) -> OptgradadamaxTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxTable::add(self : OptgradadamaxTable, other : OptgradadamaxTable) -> OptgradadamaxTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamaxTable::copy(self : OptgradadamaxTable) -> OptgradadamaxTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxTable::fill(self : OptgradadamaxTable, v : Double) -> OptgradadamaxTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxTable::min(self : OptgradadamaxTable) -> Double { @_common.min(self.data) }

pub fn OptgradadamaxTable::max(self : OptgradadamaxTable) -> Double { @_common.max(self.data) }

pub fn OptgradadamaxTable::to_string(self : OptgradadamaxTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_graphn_make(size : Int) -> OptgradadamaxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamaxGraphN::len(self : OptgradadamaxGraphN) -> Int { self.size }

pub fn OptgradadamaxGraphN::get(self : OptgradadamaxGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamaxGraphN::set(self : OptgradadamaxGraphN, i : Int, v : Double) -> OptgradadamaxGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamaxGraphN::sum(self : OptgradadamaxGraphN) -> Double { @_common.sum(self.data) }

pub fn OptgradadamaxGraphN::mean(self : OptgradadamaxGraphN) -> Double { @_common.mean(self.data) }

pub fn OptgradadamaxGraphN::scale(self : OptgradadamaxGraphN, f : Double) -> OptgradadamaxGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxGraphN::add(self : OptgradadamaxGraphN, other : OptgradadamaxGraphN) -> OptgradadamaxGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamaxGraphN::copy(self : OptgradadamaxGraphN) -> OptgradadamaxGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxGraphN::fill(self : OptgradadamaxGraphN, v : Double) -> OptgradadamaxGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxGraphN::min(self : OptgradadamaxGraphN) -> Double { @_common.min(self.data) }

pub fn OptgradadamaxGraphN::max(self : OptgradadamaxGraphN) -> Double { @_common.max(self.data) }

pub fn OptgradadamaxGraphN::to_string(self : OptgradadamaxGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_node_make(size : Int) -> OptgradadamaxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamaxNode::len(self : OptgradadamaxNode) -> Int { self.size }

pub fn OptgradadamaxNode::get(self : OptgradadamaxNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamaxNode::set(self : OptgradadamaxNode, i : Int, v : Double) -> OptgradadamaxNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamaxNode::sum(self : OptgradadamaxNode) -> Double { @_common.sum(self.data) }

pub fn OptgradadamaxNode::mean(self : OptgradadamaxNode) -> Double { @_common.mean(self.data) }

pub fn OptgradadamaxNode::scale(self : OptgradadamaxNode, f : Double) -> OptgradadamaxNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxNode::add(self : OptgradadamaxNode, other : OptgradadamaxNode) -> OptgradadamaxNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamaxNode::copy(self : OptgradadamaxNode) -> OptgradadamaxNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxNode::fill(self : OptgradadamaxNode, v : Double) -> OptgradadamaxNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxNode::min(self : OptgradadamaxNode) -> Double { @_common.min(self.data) }

pub fn OptgradadamaxNode::max(self : OptgradadamaxNode) -> Double { @_common.max(self.data) }

pub fn OptgradadamaxNode::to_string(self : OptgradadamaxNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_edge_make(size : Int) -> OptgradadamaxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamaxEdge::len(self : OptgradadamaxEdge) -> Int { self.size }

pub fn OptgradadamaxEdge::get(self : OptgradadamaxEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamaxEdge::set(self : OptgradadamaxEdge, i : Int, v : Double) -> OptgradadamaxEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamaxEdge::sum(self : OptgradadamaxEdge) -> Double { @_common.sum(self.data) }

pub fn OptgradadamaxEdge::mean(self : OptgradadamaxEdge) -> Double { @_common.mean(self.data) }

pub fn OptgradadamaxEdge::scale(self : OptgradadamaxEdge, f : Double) -> OptgradadamaxEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxEdge::add(self : OptgradadamaxEdge, other : OptgradadamaxEdge) -> OptgradadamaxEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamaxEdge::copy(self : OptgradadamaxEdge) -> OptgradadamaxEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxEdge::fill(self : OptgradadamaxEdge, v : Double) -> OptgradadamaxEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxEdge::min(self : OptgradadamaxEdge) -> Double { @_common.min(self.data) }

pub fn OptgradadamaxEdge::max(self : OptgradadamaxEdge) -> Double { @_common.max(self.data) }

pub fn OptgradadamaxEdge::to_string(self : OptgradadamaxEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_path_make(size : Int) -> OptgradadamaxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamaxPath::len(self : OptgradadamaxPath) -> Int { self.size }

pub fn OptgradadamaxPath::get(self : OptgradadamaxPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamaxPath::set(self : OptgradadamaxPath, i : Int, v : Double) -> OptgradadamaxPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamaxPath::sum(self : OptgradadamaxPath) -> Double { @_common.sum(self.data) }

pub fn OptgradadamaxPath::mean(self : OptgradadamaxPath) -> Double { @_common.mean(self.data) }

pub fn OptgradadamaxPath::scale(self : OptgradadamaxPath, f : Double) -> OptgradadamaxPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxPath::add(self : OptgradadamaxPath, other : OptgradadamaxPath) -> OptgradadamaxPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamaxPath::copy(self : OptgradadamaxPath) -> OptgradadamaxPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxPath::fill(self : OptgradadamaxPath, v : Double) -> OptgradadamaxPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxPath::min(self : OptgradadamaxPath) -> Double { @_common.min(self.data) }

pub fn OptgradadamaxPath::max(self : OptgradadamaxPath) -> Double { @_common.max(self.data) }

pub fn OptgradadamaxPath::to_string(self : OptgradadamaxPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_cluster_make(size : Int) -> OptgradadamaxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamaxCluster::len(self : OptgradadamaxCluster) -> Int { self.size }

pub fn OptgradadamaxCluster::get(self : OptgradadamaxCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamaxCluster::set(self : OptgradadamaxCluster, i : Int, v : Double) -> OptgradadamaxCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamaxCluster::sum(self : OptgradadamaxCluster) -> Double { @_common.sum(self.data) }

pub fn OptgradadamaxCluster::mean(self : OptgradadamaxCluster) -> Double { @_common.mean(self.data) }

pub fn OptgradadamaxCluster::scale(self : OptgradadamaxCluster, f : Double) -> OptgradadamaxCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxCluster::add(self : OptgradadamaxCluster, other : OptgradadamaxCluster) -> OptgradadamaxCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamaxCluster::copy(self : OptgradadamaxCluster) -> OptgradadamaxCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxCluster::fill(self : OptgradadamaxCluster, v : Double) -> OptgradadamaxCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxCluster::min(self : OptgradadamaxCluster) -> Double { @_common.min(self.data) }

pub fn OptgradadamaxCluster::max(self : OptgradadamaxCluster) -> Double { @_common.max(self.data) }

pub fn OptgradadamaxCluster::to_string(self : OptgradadamaxCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_model_make(size : Int) -> OptgradadamaxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamaxModel::len(self : OptgradadamaxModel) -> Int { self.size }

pub fn OptgradadamaxModel::get(self : OptgradadamaxModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamaxModel::set(self : OptgradadamaxModel, i : Int, v : Double) -> OptgradadamaxModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamaxModel::sum(self : OptgradadamaxModel) -> Double { @_common.sum(self.data) }

pub fn OptgradadamaxModel::mean(self : OptgradadamaxModel) -> Double { @_common.mean(self.data) }

pub fn OptgradadamaxModel::scale(self : OptgradadamaxModel, f : Double) -> OptgradadamaxModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxModel::add(self : OptgradadamaxModel, other : OptgradadamaxModel) -> OptgradadamaxModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamaxModel::copy(self : OptgradadamaxModel) -> OptgradadamaxModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxModel::fill(self : OptgradadamaxModel, v : Double) -> OptgradadamaxModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxModel::min(self : OptgradadamaxModel) -> Double { @_common.min(self.data) }

pub fn OptgradadamaxModel::max(self : OptgradadamaxModel) -> Double { @_common.max(self.data) }

pub fn OptgradadamaxModel::to_string(self : OptgradadamaxModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_layer_make(size : Int) -> OptgradadamaxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamaxLayer::len(self : OptgradadamaxLayer) -> Int { self.size }

pub fn OptgradadamaxLayer::get(self : OptgradadamaxLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamaxLayer::set(self : OptgradadamaxLayer, i : Int, v : Double) -> OptgradadamaxLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamaxLayer::sum(self : OptgradadamaxLayer) -> Double { @_common.sum(self.data) }

pub fn OptgradadamaxLayer::mean(self : OptgradadamaxLayer) -> Double { @_common.mean(self.data) }

pub fn OptgradadamaxLayer::scale(self : OptgradadamaxLayer, f : Double) -> OptgradadamaxLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxLayer::add(self : OptgradadamaxLayer, other : OptgradadamaxLayer) -> OptgradadamaxLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamaxLayer::copy(self : OptgradadamaxLayer) -> OptgradadamaxLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxLayer::fill(self : OptgradadamaxLayer, v : Double) -> OptgradadamaxLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxLayer::min(self : OptgradadamaxLayer) -> Double { @_common.min(self.data) }

pub fn OptgradadamaxLayer::max(self : OptgradadamaxLayer) -> Double { @_common.max(self.data) }

pub fn OptgradadamaxLayer::to_string(self : OptgradadamaxLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_buffer_make(size : Int) -> OptgradadamaxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamaxBuffer::len(self : OptgradadamaxBuffer) -> Int { self.size }

pub fn OptgradadamaxBuffer::get(self : OptgradadamaxBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamaxBuffer::set(self : OptgradadamaxBuffer, i : Int, v : Double) -> OptgradadamaxBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamaxBuffer::sum(self : OptgradadamaxBuffer) -> Double { @_common.sum(self.data) }

pub fn OptgradadamaxBuffer::mean(self : OptgradadamaxBuffer) -> Double { @_common.mean(self.data) }

pub fn OptgradadamaxBuffer::scale(self : OptgradadamaxBuffer, f : Double) -> OptgradadamaxBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxBuffer::add(self : OptgradadamaxBuffer, other : OptgradadamaxBuffer) -> OptgradadamaxBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamaxBuffer::copy(self : OptgradadamaxBuffer) -> OptgradadamaxBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxBuffer::fill(self : OptgradadamaxBuffer, v : Double) -> OptgradadamaxBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxBuffer::min(self : OptgradadamaxBuffer) -> Double { @_common.min(self.data) }

pub fn OptgradadamaxBuffer::max(self : OptgradadamaxBuffer) -> Double { @_common.max(self.data) }

pub fn OptgradadamaxBuffer::to_string(self : OptgradadamaxBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_cursor_make(size : Int) -> OptgradadamaxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamaxCursor::len(self : OptgradadamaxCursor) -> Int { self.size }

pub fn OptgradadamaxCursor::get(self : OptgradadamaxCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamaxCursor::set(self : OptgradadamaxCursor, i : Int, v : Double) -> OptgradadamaxCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamaxCursor::sum(self : OptgradadamaxCursor) -> Double { @_common.sum(self.data) }

pub fn OptgradadamaxCursor::mean(self : OptgradadamaxCursor) -> Double { @_common.mean(self.data) }

pub fn OptgradadamaxCursor::scale(self : OptgradadamaxCursor, f : Double) -> OptgradadamaxCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxCursor::add(self : OptgradadamaxCursor, other : OptgradadamaxCursor) -> OptgradadamaxCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamaxCursor::copy(self : OptgradadamaxCursor) -> OptgradadamaxCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxCursor::fill(self : OptgradadamaxCursor, v : Double) -> OptgradadamaxCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxCursor::min(self : OptgradadamaxCursor) -> Double { @_common.min(self.data) }

pub fn OptgradadamaxCursor::max(self : OptgradadamaxCursor) -> Double { @_common.max(self.data) }

pub fn OptgradadamaxCursor::to_string(self : OptgradadamaxCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_view_make(size : Int) -> OptgradadamaxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamaxView::len(self : OptgradadamaxView) -> Int { self.size }

pub fn OptgradadamaxView::get(self : OptgradadamaxView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamaxView::set(self : OptgradadamaxView, i : Int, v : Double) -> OptgradadamaxView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamaxView::sum(self : OptgradadamaxView) -> Double { @_common.sum(self.data) }

pub fn OptgradadamaxView::mean(self : OptgradadamaxView) -> Double { @_common.mean(self.data) }

pub fn OptgradadamaxView::scale(self : OptgradadamaxView, f : Double) -> OptgradadamaxView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxView::add(self : OptgradadamaxView, other : OptgradadamaxView) -> OptgradadamaxView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamaxView::copy(self : OptgradadamaxView) -> OptgradadamaxView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxView::fill(self : OptgradadamaxView, v : Double) -> OptgradadamaxView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxView::min(self : OptgradadamaxView) -> Double { @_common.min(self.data) }

pub fn OptgradadamaxView::max(self : OptgradadamaxView) -> Double { @_common.max(self.data) }

pub fn OptgradadamaxView::to_string(self : OptgradadamaxView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_range_make(size : Int) -> OptgradadamaxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamaxRange::len(self : OptgradadamaxRange) -> Int { self.size }

pub fn OptgradadamaxRange::get(self : OptgradadamaxRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamaxRange::set(self : OptgradadamaxRange, i : Int, v : Double) -> OptgradadamaxRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamaxRange::sum(self : OptgradadamaxRange) -> Double { @_common.sum(self.data) }

pub fn OptgradadamaxRange::mean(self : OptgradadamaxRange) -> Double { @_common.mean(self.data) }

pub fn OptgradadamaxRange::scale(self : OptgradadamaxRange, f : Double) -> OptgradadamaxRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxRange::add(self : OptgradadamaxRange, other : OptgradadamaxRange) -> OptgradadamaxRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamaxRange::copy(self : OptgradadamaxRange) -> OptgradadamaxRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxRange::fill(self : OptgradadamaxRange, v : Double) -> OptgradadamaxRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxRange::min(self : OptgradadamaxRange) -> Double { @_common.min(self.data) }

pub fn OptgradadamaxRange::max(self : OptgradadamaxRange) -> Double { @_common.max(self.data) }

pub fn OptgradadamaxRange::to_string(self : OptgradadamaxRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_slice_make(size : Int) -> OptgradadamaxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamaxSlice::len(self : OptgradadamaxSlice) -> Int { self.size }

pub fn OptgradadamaxSlice::get(self : OptgradadamaxSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamaxSlice::set(self : OptgradadamaxSlice, i : Int, v : Double) -> OptgradadamaxSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamaxSlice::sum(self : OptgradadamaxSlice) -> Double { @_common.sum(self.data) }

pub fn OptgradadamaxSlice::mean(self : OptgradadamaxSlice) -> Double { @_common.mean(self.data) }

pub fn OptgradadamaxSlice::scale(self : OptgradadamaxSlice, f : Double) -> OptgradadamaxSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxSlice::add(self : OptgradadamaxSlice, other : OptgradadamaxSlice) -> OptgradadamaxSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamaxSlice::copy(self : OptgradadamaxSlice) -> OptgradadamaxSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxSlice::fill(self : OptgradadamaxSlice, v : Double) -> OptgradadamaxSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamaxSlice::min(self : OptgradadamaxSlice) -> Double { @_common.min(self.data) }

pub fn OptgradadamaxSlice::max(self : OptgradadamaxSlice) -> Double { @_common.max(self.data) }

pub fn OptgradadamaxSlice::to_string(self : OptgradadamaxSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

