///===
/// extcore/opt_convex_conjugate

pub(all) struct OptconvexconjugatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_conjugate_make_point(x : Double, y : Double) -> OptconvexconjugatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_conjugate_make_point3(x : Double, y : Double, z : Double) -> OptconvexconjugatePoint {
  { x, y, z, label: 0 }
}

pub fn OptconvexconjugatePoint::x(self : OptconvexconjugatePoint) -> Double { self.x }

pub fn OptconvexconjugatePoint::y(self : OptconvexconjugatePoint) -> Double { self.y }

pub fn OptconvexconjugatePoint::z(self : OptconvexconjugatePoint) -> Double { self.z }

pub fn OptconvexconjugatePoint::label(self : OptconvexconjugatePoint) -> Int { self.label }

pub fn OptconvexconjugatePoint::dist(self : OptconvexconjugatePoint, other : OptconvexconjugatePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvexconjugatePoint::add(self : OptconvexconjugatePoint, other : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvexconjugatePoint::sub(self : OptconvexconjugatePoint, other : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvexconjugatePoint::scale(self : OptconvexconjugatePoint, s : Double) -> OptconvexconjugatePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvexconjugatePoint::dot(self : OptconvexconjugatePoint, other : OptconvexconjugatePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvexconjugatePoint::cross(self : OptconvexconjugatePoint, other : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvexconjugatePoint::norm(self : OptconvexconjugatePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvexconjugatePoint::normalize(self : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexconjugatePoint::negate(self : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvexconjugatePoint::mid(self : OptconvexconjugatePoint, other : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvexconjugatePoint::lerp(self : OptconvexconjugatePoint, other : OptconvexconjugatePoint, t : Double) -> OptconvexconjugatePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvexconjugatePoint::to_string(self : OptconvexconjugatePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvexconjugateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_conjugate_make_series(vals : Array[Double], name : String) -> OptconvexconjugateSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvexconjugateSeries::len(self : OptconvexconjugateSeries) -> Int { self.vals.length() }

pub fn OptconvexconjugateSeries::sum(self : OptconvexconjugateSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvexconjugateSeries::mean(self : OptconvexconjugateSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvexconjugateSeries::min(self : OptconvexconjugateSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvexconjugateSeries::max(self : OptconvexconjugateSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvexconjugateSeries::range(self : OptconvexconjugateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvexconjugateSeries::variance(self : OptconvexconjugateSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvexconjugateSeries::std(self : OptconvexconjugateSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvexconjugateSeries::median(self : OptconvexconjugateSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvexconjugateSeries::scale(self : OptconvexconjugateSeries, f : Double) -> OptconvexconjugateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvexconjugateSeries::add(self : OptconvexconjugateSeries, other : OptconvexconjugateSeries) -> OptconvexconjugateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvexconjugateSeries::sub(self : OptconvexconjugateSeries, other : OptconvexconjugateSeries) -> OptconvexconjugateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvexconjugateSeries::normalize(self : OptconvexconjugateSeries) -> OptconvexconjugateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvexconjugateSeries::cumsum(self : OptconvexconjugateSeries) -> OptconvexconjugateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvexconjugateSeries::to_string(self : OptconvexconjugateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexconjugateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_conjugate_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexconjugateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_conjugate_matrix_identity(n : Int) -> OptconvexconjugateMatrix {
  let m = opt_convex_conjugate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvexconjugateMatrix::get(self : OptconvexconjugateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvexconjugateMatrix::transpose(self : OptconvexconjugateMatrix) -> OptconvexconjugateMatrix {
  let result = opt_convex_conjugate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvexconjugateMatrix::add(self : OptconvexconjugateMatrix, other : OptconvexconjugateMatrix) -> OptconvexconjugateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_conjugate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvexconjugateMatrix::scale(self : OptconvexconjugateMatrix, s : Double) -> OptconvexconjugateMatrix {
  let result = opt_convex_conjugate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvexconjugateMatrix::multiply(self : OptconvexconjugateMatrix, other : OptconvexconjugateMatrix) -> OptconvexconjugateMatrix {
  if self.cols != other.rows { return opt_convex_conjugate_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_conjugate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptconvexconjugateMatrix::trace(self : OptconvexconjugateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvexconjugateMatrix::det(self : OptconvexconjugateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvexconjugateMatrix::norm(self : OptconvexconjugateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvexconjugateMatrix::to_string(self : OptconvexconjugateMatrix) -> String {
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

pub(all) struct OptconvexconjugateVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_conjugate_make_vector(comps : Array[Double]) -> OptconvexconjugateVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_conjugate_vector_zero(dim : Int) -> OptconvexconjugateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvexconjugateVector::add(self : OptconvexconjugateVector, other : OptconvexconjugateVector) -> OptconvexconjugateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexconjugateVector::sub(self : OptconvexconjugateVector, other : OptconvexconjugateVector) -> OptconvexconjugateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexconjugateVector::scale(self : OptconvexconjugateVector, s : Double) -> OptconvexconjugateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvexconjugateVector::dot(self : OptconvexconjugateVector, other : OptconvexconjugateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvexconjugateVector::norm(self : OptconvexconjugateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvexconjugateVector::normalize(self : OptconvexconjugateVector) -> OptconvexconjugateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexconjugateVector::dist(self : OptconvexconjugateVector, other : OptconvexconjugateVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvexconjugateVector::to_string(self : OptconvexconjugateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexconjugateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_frame_make(size : Int) -> OptconvexconjugateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexconjugateFrame::len(self : OptconvexconjugateFrame) -> Int { self.size }

pub fn OptconvexconjugateFrame::get(self : OptconvexconjugateFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexconjugateFrame::set(self : OptconvexconjugateFrame, i : Int, v : Double) -> OptconvexconjugateFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateFrame::sum(self : OptconvexconjugateFrame) -> Double { @_common.sum(self.data) }

pub fn OptconvexconjugateFrame::mean(self : OptconvexconjugateFrame) -> Double { @_common.mean(self.data) }

pub fn OptconvexconjugateFrame::scale(self : OptconvexconjugateFrame, f : Double) -> OptconvexconjugateFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateFrame::add(self : OptconvexconjugateFrame, other : OptconvexconjugateFrame) -> OptconvexconjugateFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexconjugateFrame::copy(self : OptconvexconjugateFrame) -> OptconvexconjugateFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateFrame::fill(self : OptconvexconjugateFrame, v : Double) -> OptconvexconjugateFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateFrame::min(self : OptconvexconjugateFrame) -> Double { @_common.min(self.data) }

pub fn OptconvexconjugateFrame::max(self : OptconvexconjugateFrame) -> Double { @_common.max(self.data) }

pub fn OptconvexconjugateFrame::to_string(self : OptconvexconjugateFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_table_make(size : Int) -> OptconvexconjugateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexconjugateTable::len(self : OptconvexconjugateTable) -> Int { self.size }

pub fn OptconvexconjugateTable::get(self : OptconvexconjugateTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexconjugateTable::set(self : OptconvexconjugateTable, i : Int, v : Double) -> OptconvexconjugateTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateTable::sum(self : OptconvexconjugateTable) -> Double { @_common.sum(self.data) }

pub fn OptconvexconjugateTable::mean(self : OptconvexconjugateTable) -> Double { @_common.mean(self.data) }

pub fn OptconvexconjugateTable::scale(self : OptconvexconjugateTable, f : Double) -> OptconvexconjugateTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateTable::add(self : OptconvexconjugateTable, other : OptconvexconjugateTable) -> OptconvexconjugateTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexconjugateTable::copy(self : OptconvexconjugateTable) -> OptconvexconjugateTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateTable::fill(self : OptconvexconjugateTable, v : Double) -> OptconvexconjugateTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateTable::min(self : OptconvexconjugateTable) -> Double { @_common.min(self.data) }

pub fn OptconvexconjugateTable::max(self : OptconvexconjugateTable) -> Double { @_common.max(self.data) }

pub fn OptconvexconjugateTable::to_string(self : OptconvexconjugateTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_graphn_make(size : Int) -> OptconvexconjugateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexconjugateGraphN::len(self : OptconvexconjugateGraphN) -> Int { self.size }

pub fn OptconvexconjugateGraphN::get(self : OptconvexconjugateGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexconjugateGraphN::set(self : OptconvexconjugateGraphN, i : Int, v : Double) -> OptconvexconjugateGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateGraphN::sum(self : OptconvexconjugateGraphN) -> Double { @_common.sum(self.data) }

pub fn OptconvexconjugateGraphN::mean(self : OptconvexconjugateGraphN) -> Double { @_common.mean(self.data) }

pub fn OptconvexconjugateGraphN::scale(self : OptconvexconjugateGraphN, f : Double) -> OptconvexconjugateGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateGraphN::add(self : OptconvexconjugateGraphN, other : OptconvexconjugateGraphN) -> OptconvexconjugateGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexconjugateGraphN::copy(self : OptconvexconjugateGraphN) -> OptconvexconjugateGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateGraphN::fill(self : OptconvexconjugateGraphN, v : Double) -> OptconvexconjugateGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateGraphN::min(self : OptconvexconjugateGraphN) -> Double { @_common.min(self.data) }

pub fn OptconvexconjugateGraphN::max(self : OptconvexconjugateGraphN) -> Double { @_common.max(self.data) }

pub fn OptconvexconjugateGraphN::to_string(self : OptconvexconjugateGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_node_make(size : Int) -> OptconvexconjugateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexconjugateNode::len(self : OptconvexconjugateNode) -> Int { self.size }

pub fn OptconvexconjugateNode::get(self : OptconvexconjugateNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexconjugateNode::set(self : OptconvexconjugateNode, i : Int, v : Double) -> OptconvexconjugateNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateNode::sum(self : OptconvexconjugateNode) -> Double { @_common.sum(self.data) }

pub fn OptconvexconjugateNode::mean(self : OptconvexconjugateNode) -> Double { @_common.mean(self.data) }

pub fn OptconvexconjugateNode::scale(self : OptconvexconjugateNode, f : Double) -> OptconvexconjugateNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateNode::add(self : OptconvexconjugateNode, other : OptconvexconjugateNode) -> OptconvexconjugateNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexconjugateNode::copy(self : OptconvexconjugateNode) -> OptconvexconjugateNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateNode::fill(self : OptconvexconjugateNode, v : Double) -> OptconvexconjugateNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateNode::min(self : OptconvexconjugateNode) -> Double { @_common.min(self.data) }

pub fn OptconvexconjugateNode::max(self : OptconvexconjugateNode) -> Double { @_common.max(self.data) }

pub fn OptconvexconjugateNode::to_string(self : OptconvexconjugateNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_edge_make(size : Int) -> OptconvexconjugateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexconjugateEdge::len(self : OptconvexconjugateEdge) -> Int { self.size }

pub fn OptconvexconjugateEdge::get(self : OptconvexconjugateEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexconjugateEdge::set(self : OptconvexconjugateEdge, i : Int, v : Double) -> OptconvexconjugateEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateEdge::sum(self : OptconvexconjugateEdge) -> Double { @_common.sum(self.data) }

pub fn OptconvexconjugateEdge::mean(self : OptconvexconjugateEdge) -> Double { @_common.mean(self.data) }

pub fn OptconvexconjugateEdge::scale(self : OptconvexconjugateEdge, f : Double) -> OptconvexconjugateEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateEdge::add(self : OptconvexconjugateEdge, other : OptconvexconjugateEdge) -> OptconvexconjugateEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexconjugateEdge::copy(self : OptconvexconjugateEdge) -> OptconvexconjugateEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateEdge::fill(self : OptconvexconjugateEdge, v : Double) -> OptconvexconjugateEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateEdge::min(self : OptconvexconjugateEdge) -> Double { @_common.min(self.data) }

pub fn OptconvexconjugateEdge::max(self : OptconvexconjugateEdge) -> Double { @_common.max(self.data) }

pub fn OptconvexconjugateEdge::to_string(self : OptconvexconjugateEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_path_make(size : Int) -> OptconvexconjugatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexconjugatePath::len(self : OptconvexconjugatePath) -> Int { self.size }

pub fn OptconvexconjugatePath::get(self : OptconvexconjugatePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexconjugatePath::set(self : OptconvexconjugatePath, i : Int, v : Double) -> OptconvexconjugatePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexconjugatePath::sum(self : OptconvexconjugatePath) -> Double { @_common.sum(self.data) }

pub fn OptconvexconjugatePath::mean(self : OptconvexconjugatePath) -> Double { @_common.mean(self.data) }

pub fn OptconvexconjugatePath::scale(self : OptconvexconjugatePath, f : Double) -> OptconvexconjugatePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugatePath::add(self : OptconvexconjugatePath, other : OptconvexconjugatePath) -> OptconvexconjugatePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexconjugatePath::copy(self : OptconvexconjugatePath) -> OptconvexconjugatePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugatePath::fill(self : OptconvexconjugatePath, v : Double) -> OptconvexconjugatePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugatePath::min(self : OptconvexconjugatePath) -> Double { @_common.min(self.data) }

pub fn OptconvexconjugatePath::max(self : OptconvexconjugatePath) -> Double { @_common.max(self.data) }

pub fn OptconvexconjugatePath::to_string(self : OptconvexconjugatePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_cluster_make(size : Int) -> OptconvexconjugateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexconjugateCluster::len(self : OptconvexconjugateCluster) -> Int { self.size }

pub fn OptconvexconjugateCluster::get(self : OptconvexconjugateCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexconjugateCluster::set(self : OptconvexconjugateCluster, i : Int, v : Double) -> OptconvexconjugateCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateCluster::sum(self : OptconvexconjugateCluster) -> Double { @_common.sum(self.data) }

pub fn OptconvexconjugateCluster::mean(self : OptconvexconjugateCluster) -> Double { @_common.mean(self.data) }

pub fn OptconvexconjugateCluster::scale(self : OptconvexconjugateCluster, f : Double) -> OptconvexconjugateCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateCluster::add(self : OptconvexconjugateCluster, other : OptconvexconjugateCluster) -> OptconvexconjugateCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexconjugateCluster::copy(self : OptconvexconjugateCluster) -> OptconvexconjugateCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateCluster::fill(self : OptconvexconjugateCluster, v : Double) -> OptconvexconjugateCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateCluster::min(self : OptconvexconjugateCluster) -> Double { @_common.min(self.data) }

pub fn OptconvexconjugateCluster::max(self : OptconvexconjugateCluster) -> Double { @_common.max(self.data) }

pub fn OptconvexconjugateCluster::to_string(self : OptconvexconjugateCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_model_make(size : Int) -> OptconvexconjugateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexconjugateModel::len(self : OptconvexconjugateModel) -> Int { self.size }

pub fn OptconvexconjugateModel::get(self : OptconvexconjugateModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexconjugateModel::set(self : OptconvexconjugateModel, i : Int, v : Double) -> OptconvexconjugateModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateModel::sum(self : OptconvexconjugateModel) -> Double { @_common.sum(self.data) }

pub fn OptconvexconjugateModel::mean(self : OptconvexconjugateModel) -> Double { @_common.mean(self.data) }

pub fn OptconvexconjugateModel::scale(self : OptconvexconjugateModel, f : Double) -> OptconvexconjugateModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateModel::add(self : OptconvexconjugateModel, other : OptconvexconjugateModel) -> OptconvexconjugateModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexconjugateModel::copy(self : OptconvexconjugateModel) -> OptconvexconjugateModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateModel::fill(self : OptconvexconjugateModel, v : Double) -> OptconvexconjugateModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateModel::min(self : OptconvexconjugateModel) -> Double { @_common.min(self.data) }

pub fn OptconvexconjugateModel::max(self : OptconvexconjugateModel) -> Double { @_common.max(self.data) }

pub fn OptconvexconjugateModel::to_string(self : OptconvexconjugateModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_layer_make(size : Int) -> OptconvexconjugateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexconjugateLayer::len(self : OptconvexconjugateLayer) -> Int { self.size }

pub fn OptconvexconjugateLayer::get(self : OptconvexconjugateLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexconjugateLayer::set(self : OptconvexconjugateLayer, i : Int, v : Double) -> OptconvexconjugateLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateLayer::sum(self : OptconvexconjugateLayer) -> Double { @_common.sum(self.data) }

pub fn OptconvexconjugateLayer::mean(self : OptconvexconjugateLayer) -> Double { @_common.mean(self.data) }

pub fn OptconvexconjugateLayer::scale(self : OptconvexconjugateLayer, f : Double) -> OptconvexconjugateLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateLayer::add(self : OptconvexconjugateLayer, other : OptconvexconjugateLayer) -> OptconvexconjugateLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexconjugateLayer::copy(self : OptconvexconjugateLayer) -> OptconvexconjugateLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateLayer::fill(self : OptconvexconjugateLayer, v : Double) -> OptconvexconjugateLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateLayer::min(self : OptconvexconjugateLayer) -> Double { @_common.min(self.data) }

pub fn OptconvexconjugateLayer::max(self : OptconvexconjugateLayer) -> Double { @_common.max(self.data) }

pub fn OptconvexconjugateLayer::to_string(self : OptconvexconjugateLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_buffer_make(size : Int) -> OptconvexconjugateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexconjugateBuffer::len(self : OptconvexconjugateBuffer) -> Int { self.size }

pub fn OptconvexconjugateBuffer::get(self : OptconvexconjugateBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexconjugateBuffer::set(self : OptconvexconjugateBuffer, i : Int, v : Double) -> OptconvexconjugateBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateBuffer::sum(self : OptconvexconjugateBuffer) -> Double { @_common.sum(self.data) }

pub fn OptconvexconjugateBuffer::mean(self : OptconvexconjugateBuffer) -> Double { @_common.mean(self.data) }

pub fn OptconvexconjugateBuffer::scale(self : OptconvexconjugateBuffer, f : Double) -> OptconvexconjugateBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateBuffer::add(self : OptconvexconjugateBuffer, other : OptconvexconjugateBuffer) -> OptconvexconjugateBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexconjugateBuffer::copy(self : OptconvexconjugateBuffer) -> OptconvexconjugateBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateBuffer::fill(self : OptconvexconjugateBuffer, v : Double) -> OptconvexconjugateBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateBuffer::min(self : OptconvexconjugateBuffer) -> Double { @_common.min(self.data) }

pub fn OptconvexconjugateBuffer::max(self : OptconvexconjugateBuffer) -> Double { @_common.max(self.data) }

pub fn OptconvexconjugateBuffer::to_string(self : OptconvexconjugateBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_cursor_make(size : Int) -> OptconvexconjugateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexconjugateCursor::len(self : OptconvexconjugateCursor) -> Int { self.size }

pub fn OptconvexconjugateCursor::get(self : OptconvexconjugateCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexconjugateCursor::set(self : OptconvexconjugateCursor, i : Int, v : Double) -> OptconvexconjugateCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateCursor::sum(self : OptconvexconjugateCursor) -> Double { @_common.sum(self.data) }

pub fn OptconvexconjugateCursor::mean(self : OptconvexconjugateCursor) -> Double { @_common.mean(self.data) }

pub fn OptconvexconjugateCursor::scale(self : OptconvexconjugateCursor, f : Double) -> OptconvexconjugateCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateCursor::add(self : OptconvexconjugateCursor, other : OptconvexconjugateCursor) -> OptconvexconjugateCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexconjugateCursor::copy(self : OptconvexconjugateCursor) -> OptconvexconjugateCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateCursor::fill(self : OptconvexconjugateCursor, v : Double) -> OptconvexconjugateCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateCursor::min(self : OptconvexconjugateCursor) -> Double { @_common.min(self.data) }

pub fn OptconvexconjugateCursor::max(self : OptconvexconjugateCursor) -> Double { @_common.max(self.data) }

pub fn OptconvexconjugateCursor::to_string(self : OptconvexconjugateCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_view_make(size : Int) -> OptconvexconjugateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexconjugateView::len(self : OptconvexconjugateView) -> Int { self.size }

pub fn OptconvexconjugateView::get(self : OptconvexconjugateView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexconjugateView::set(self : OptconvexconjugateView, i : Int, v : Double) -> OptconvexconjugateView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateView::sum(self : OptconvexconjugateView) -> Double { @_common.sum(self.data) }

pub fn OptconvexconjugateView::mean(self : OptconvexconjugateView) -> Double { @_common.mean(self.data) }

pub fn OptconvexconjugateView::scale(self : OptconvexconjugateView, f : Double) -> OptconvexconjugateView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateView::add(self : OptconvexconjugateView, other : OptconvexconjugateView) -> OptconvexconjugateView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexconjugateView::copy(self : OptconvexconjugateView) -> OptconvexconjugateView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateView::fill(self : OptconvexconjugateView, v : Double) -> OptconvexconjugateView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateView::min(self : OptconvexconjugateView) -> Double { @_common.min(self.data) }

pub fn OptconvexconjugateView::max(self : OptconvexconjugateView) -> Double { @_common.max(self.data) }

pub fn OptconvexconjugateView::to_string(self : OptconvexconjugateView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_range_make(size : Int) -> OptconvexconjugateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexconjugateRange::len(self : OptconvexconjugateRange) -> Int { self.size }

pub fn OptconvexconjugateRange::get(self : OptconvexconjugateRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexconjugateRange::set(self : OptconvexconjugateRange, i : Int, v : Double) -> OptconvexconjugateRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateRange::sum(self : OptconvexconjugateRange) -> Double { @_common.sum(self.data) }

pub fn OptconvexconjugateRange::mean(self : OptconvexconjugateRange) -> Double { @_common.mean(self.data) }

pub fn OptconvexconjugateRange::scale(self : OptconvexconjugateRange, f : Double) -> OptconvexconjugateRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateRange::add(self : OptconvexconjugateRange, other : OptconvexconjugateRange) -> OptconvexconjugateRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexconjugateRange::copy(self : OptconvexconjugateRange) -> OptconvexconjugateRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateRange::fill(self : OptconvexconjugateRange, v : Double) -> OptconvexconjugateRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateRange::min(self : OptconvexconjugateRange) -> Double { @_common.min(self.data) }

pub fn OptconvexconjugateRange::max(self : OptconvexconjugateRange) -> Double { @_common.max(self.data) }

pub fn OptconvexconjugateRange::to_string(self : OptconvexconjugateRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_slice_make(size : Int) -> OptconvexconjugateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexconjugateSlice::len(self : OptconvexconjugateSlice) -> Int { self.size }

pub fn OptconvexconjugateSlice::get(self : OptconvexconjugateSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexconjugateSlice::set(self : OptconvexconjugateSlice, i : Int, v : Double) -> OptconvexconjugateSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateSlice::sum(self : OptconvexconjugateSlice) -> Double { @_common.sum(self.data) }

pub fn OptconvexconjugateSlice::mean(self : OptconvexconjugateSlice) -> Double { @_common.mean(self.data) }

pub fn OptconvexconjugateSlice::scale(self : OptconvexconjugateSlice, f : Double) -> OptconvexconjugateSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateSlice::add(self : OptconvexconjugateSlice, other : OptconvexconjugateSlice) -> OptconvexconjugateSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexconjugateSlice::copy(self : OptconvexconjugateSlice) -> OptconvexconjugateSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateSlice::fill(self : OptconvexconjugateSlice, v : Double) -> OptconvexconjugateSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexconjugateSlice::min(self : OptconvexconjugateSlice) -> Double { @_common.min(self.data) }

pub fn OptconvexconjugateSlice::max(self : OptconvexconjugateSlice) -> Double { @_common.max(self.data) }

pub fn OptconvexconjugateSlice::to_string(self : OptconvexconjugateSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

