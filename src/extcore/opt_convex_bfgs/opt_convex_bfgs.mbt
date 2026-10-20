///===
/// extcore/opt_convex_bfgs

pub(all) struct OptconvexbfgsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_bfgs_make_point(x : Double, y : Double) -> OptconvexbfgsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_bfgs_make_point3(x : Double, y : Double, z : Double) -> OptconvexbfgsPoint {
  { x, y, z, label: 0 }
}

pub fn OptconvexbfgsPoint::x(self : OptconvexbfgsPoint) -> Double { self.x }

pub fn OptconvexbfgsPoint::y(self : OptconvexbfgsPoint) -> Double { self.y }

pub fn OptconvexbfgsPoint::z(self : OptconvexbfgsPoint) -> Double { self.z }

pub fn OptconvexbfgsPoint::label(self : OptconvexbfgsPoint) -> Int { self.label }

pub fn OptconvexbfgsPoint::dist(self : OptconvexbfgsPoint, other : OptconvexbfgsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvexbfgsPoint::add(self : OptconvexbfgsPoint, other : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvexbfgsPoint::sub(self : OptconvexbfgsPoint, other : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvexbfgsPoint::scale(self : OptconvexbfgsPoint, s : Double) -> OptconvexbfgsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvexbfgsPoint::dot(self : OptconvexbfgsPoint, other : OptconvexbfgsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvexbfgsPoint::cross(self : OptconvexbfgsPoint, other : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvexbfgsPoint::norm(self : OptconvexbfgsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvexbfgsPoint::normalize(self : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexbfgsPoint::negate(self : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvexbfgsPoint::mid(self : OptconvexbfgsPoint, other : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvexbfgsPoint::lerp(self : OptconvexbfgsPoint, other : OptconvexbfgsPoint, t : Double) -> OptconvexbfgsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvexbfgsPoint::to_string(self : OptconvexbfgsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvexbfgsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_bfgs_make_series(vals : Array[Double], name : String) -> OptconvexbfgsSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvexbfgsSeries::len(self : OptconvexbfgsSeries) -> Int { self.vals.length() }

pub fn OptconvexbfgsSeries::sum(self : OptconvexbfgsSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvexbfgsSeries::mean(self : OptconvexbfgsSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvexbfgsSeries::min(self : OptconvexbfgsSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvexbfgsSeries::max(self : OptconvexbfgsSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvexbfgsSeries::range(self : OptconvexbfgsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvexbfgsSeries::variance(self : OptconvexbfgsSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvexbfgsSeries::std(self : OptconvexbfgsSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvexbfgsSeries::median(self : OptconvexbfgsSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvexbfgsSeries::scale(self : OptconvexbfgsSeries, f : Double) -> OptconvexbfgsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvexbfgsSeries::add(self : OptconvexbfgsSeries, other : OptconvexbfgsSeries) -> OptconvexbfgsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvexbfgsSeries::sub(self : OptconvexbfgsSeries, other : OptconvexbfgsSeries) -> OptconvexbfgsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvexbfgsSeries::normalize(self : OptconvexbfgsSeries) -> OptconvexbfgsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvexbfgsSeries::cumsum(self : OptconvexbfgsSeries) -> OptconvexbfgsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvexbfgsSeries::to_string(self : OptconvexbfgsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexbfgsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_bfgs_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexbfgsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_bfgs_matrix_identity(n : Int) -> OptconvexbfgsMatrix {
  let m = opt_convex_bfgs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvexbfgsMatrix::get(self : OptconvexbfgsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvexbfgsMatrix::transpose(self : OptconvexbfgsMatrix) -> OptconvexbfgsMatrix {
  let result = opt_convex_bfgs_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvexbfgsMatrix::add(self : OptconvexbfgsMatrix, other : OptconvexbfgsMatrix) -> OptconvexbfgsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_bfgs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvexbfgsMatrix::scale(self : OptconvexbfgsMatrix, s : Double) -> OptconvexbfgsMatrix {
  let result = opt_convex_bfgs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvexbfgsMatrix::multiply(self : OptconvexbfgsMatrix, other : OptconvexbfgsMatrix) -> OptconvexbfgsMatrix {
  if self.cols != other.rows { return opt_convex_bfgs_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_bfgs_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn OptconvexbfgsMatrix::trace(self : OptconvexbfgsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvexbfgsMatrix::det(self : OptconvexbfgsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvexbfgsMatrix::norm(self : OptconvexbfgsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvexbfgsMatrix::to_string(self : OptconvexbfgsMatrix) -> String {
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

pub(all) struct OptconvexbfgsVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_bfgs_make_vector(comps : Array[Double]) -> OptconvexbfgsVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_bfgs_vector_zero(dim : Int) -> OptconvexbfgsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvexbfgsVector::add(self : OptconvexbfgsVector, other : OptconvexbfgsVector) -> OptconvexbfgsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexbfgsVector::sub(self : OptconvexbfgsVector, other : OptconvexbfgsVector) -> OptconvexbfgsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexbfgsVector::scale(self : OptconvexbfgsVector, s : Double) -> OptconvexbfgsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvexbfgsVector::dot(self : OptconvexbfgsVector, other : OptconvexbfgsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvexbfgsVector::norm(self : OptconvexbfgsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvexbfgsVector::normalize(self : OptconvexbfgsVector) -> OptconvexbfgsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexbfgsVector::dist(self : OptconvexbfgsVector, other : OptconvexbfgsVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvexbfgsVector::to_string(self : OptconvexbfgsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexbfgsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_frame_make(size : Int) -> OptconvexbfgsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexbfgsFrame::len(self : OptconvexbfgsFrame) -> Int { self.size }

pub fn OptconvexbfgsFrame::get(self : OptconvexbfgsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexbfgsFrame::set(self : OptconvexbfgsFrame, i : Int, v : Double) -> OptconvexbfgsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsFrame::sum(self : OptconvexbfgsFrame) -> Double { @_common.sum(self.data) }

pub fn OptconvexbfgsFrame::mean(self : OptconvexbfgsFrame) -> Double { @_common.mean(self.data) }

pub fn OptconvexbfgsFrame::scale(self : OptconvexbfgsFrame, f : Double) -> OptconvexbfgsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsFrame::add(self : OptconvexbfgsFrame, other : OptconvexbfgsFrame) -> OptconvexbfgsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexbfgsFrame::copy(self : OptconvexbfgsFrame) -> OptconvexbfgsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsFrame::fill(self : OptconvexbfgsFrame, v : Double) -> OptconvexbfgsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsFrame::min(self : OptconvexbfgsFrame) -> Double { @_common.min(self.data) }

pub fn OptconvexbfgsFrame::max(self : OptconvexbfgsFrame) -> Double { @_common.max(self.data) }

pub fn OptconvexbfgsFrame::to_string(self : OptconvexbfgsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_table_make(size : Int) -> OptconvexbfgsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexbfgsTable::len(self : OptconvexbfgsTable) -> Int { self.size }

pub fn OptconvexbfgsTable::get(self : OptconvexbfgsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexbfgsTable::set(self : OptconvexbfgsTable, i : Int, v : Double) -> OptconvexbfgsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsTable::sum(self : OptconvexbfgsTable) -> Double { @_common.sum(self.data) }

pub fn OptconvexbfgsTable::mean(self : OptconvexbfgsTable) -> Double { @_common.mean(self.data) }

pub fn OptconvexbfgsTable::scale(self : OptconvexbfgsTable, f : Double) -> OptconvexbfgsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsTable::add(self : OptconvexbfgsTable, other : OptconvexbfgsTable) -> OptconvexbfgsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexbfgsTable::copy(self : OptconvexbfgsTable) -> OptconvexbfgsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsTable::fill(self : OptconvexbfgsTable, v : Double) -> OptconvexbfgsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsTable::min(self : OptconvexbfgsTable) -> Double { @_common.min(self.data) }

pub fn OptconvexbfgsTable::max(self : OptconvexbfgsTable) -> Double { @_common.max(self.data) }

pub fn OptconvexbfgsTable::to_string(self : OptconvexbfgsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_graphn_make(size : Int) -> OptconvexbfgsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexbfgsGraphN::len(self : OptconvexbfgsGraphN) -> Int { self.size }

pub fn OptconvexbfgsGraphN::get(self : OptconvexbfgsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexbfgsGraphN::set(self : OptconvexbfgsGraphN, i : Int, v : Double) -> OptconvexbfgsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsGraphN::sum(self : OptconvexbfgsGraphN) -> Double { @_common.sum(self.data) }

pub fn OptconvexbfgsGraphN::mean(self : OptconvexbfgsGraphN) -> Double { @_common.mean(self.data) }

pub fn OptconvexbfgsGraphN::scale(self : OptconvexbfgsGraphN, f : Double) -> OptconvexbfgsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsGraphN::add(self : OptconvexbfgsGraphN, other : OptconvexbfgsGraphN) -> OptconvexbfgsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexbfgsGraphN::copy(self : OptconvexbfgsGraphN) -> OptconvexbfgsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsGraphN::fill(self : OptconvexbfgsGraphN, v : Double) -> OptconvexbfgsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsGraphN::min(self : OptconvexbfgsGraphN) -> Double { @_common.min(self.data) }

pub fn OptconvexbfgsGraphN::max(self : OptconvexbfgsGraphN) -> Double { @_common.max(self.data) }

pub fn OptconvexbfgsGraphN::to_string(self : OptconvexbfgsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_node_make(size : Int) -> OptconvexbfgsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexbfgsNode::len(self : OptconvexbfgsNode) -> Int { self.size }

pub fn OptconvexbfgsNode::get(self : OptconvexbfgsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexbfgsNode::set(self : OptconvexbfgsNode, i : Int, v : Double) -> OptconvexbfgsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsNode::sum(self : OptconvexbfgsNode) -> Double { @_common.sum(self.data) }

pub fn OptconvexbfgsNode::mean(self : OptconvexbfgsNode) -> Double { @_common.mean(self.data) }

pub fn OptconvexbfgsNode::scale(self : OptconvexbfgsNode, f : Double) -> OptconvexbfgsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsNode::add(self : OptconvexbfgsNode, other : OptconvexbfgsNode) -> OptconvexbfgsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexbfgsNode::copy(self : OptconvexbfgsNode) -> OptconvexbfgsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsNode::fill(self : OptconvexbfgsNode, v : Double) -> OptconvexbfgsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsNode::min(self : OptconvexbfgsNode) -> Double { @_common.min(self.data) }

pub fn OptconvexbfgsNode::max(self : OptconvexbfgsNode) -> Double { @_common.max(self.data) }

pub fn OptconvexbfgsNode::to_string(self : OptconvexbfgsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_edge_make(size : Int) -> OptconvexbfgsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexbfgsEdge::len(self : OptconvexbfgsEdge) -> Int { self.size }

pub fn OptconvexbfgsEdge::get(self : OptconvexbfgsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexbfgsEdge::set(self : OptconvexbfgsEdge, i : Int, v : Double) -> OptconvexbfgsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsEdge::sum(self : OptconvexbfgsEdge) -> Double { @_common.sum(self.data) }

pub fn OptconvexbfgsEdge::mean(self : OptconvexbfgsEdge) -> Double { @_common.mean(self.data) }

pub fn OptconvexbfgsEdge::scale(self : OptconvexbfgsEdge, f : Double) -> OptconvexbfgsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsEdge::add(self : OptconvexbfgsEdge, other : OptconvexbfgsEdge) -> OptconvexbfgsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexbfgsEdge::copy(self : OptconvexbfgsEdge) -> OptconvexbfgsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsEdge::fill(self : OptconvexbfgsEdge, v : Double) -> OptconvexbfgsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsEdge::min(self : OptconvexbfgsEdge) -> Double { @_common.min(self.data) }

pub fn OptconvexbfgsEdge::max(self : OptconvexbfgsEdge) -> Double { @_common.max(self.data) }

pub fn OptconvexbfgsEdge::to_string(self : OptconvexbfgsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_path_make(size : Int) -> OptconvexbfgsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexbfgsPath::len(self : OptconvexbfgsPath) -> Int { self.size }

pub fn OptconvexbfgsPath::get(self : OptconvexbfgsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexbfgsPath::set(self : OptconvexbfgsPath, i : Int, v : Double) -> OptconvexbfgsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsPath::sum(self : OptconvexbfgsPath) -> Double { @_common.sum(self.data) }

pub fn OptconvexbfgsPath::mean(self : OptconvexbfgsPath) -> Double { @_common.mean(self.data) }

pub fn OptconvexbfgsPath::scale(self : OptconvexbfgsPath, f : Double) -> OptconvexbfgsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsPath::add(self : OptconvexbfgsPath, other : OptconvexbfgsPath) -> OptconvexbfgsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexbfgsPath::copy(self : OptconvexbfgsPath) -> OptconvexbfgsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsPath::fill(self : OptconvexbfgsPath, v : Double) -> OptconvexbfgsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsPath::min(self : OptconvexbfgsPath) -> Double { @_common.min(self.data) }

pub fn OptconvexbfgsPath::max(self : OptconvexbfgsPath) -> Double { @_common.max(self.data) }

pub fn OptconvexbfgsPath::to_string(self : OptconvexbfgsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_cluster_make(size : Int) -> OptconvexbfgsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexbfgsCluster::len(self : OptconvexbfgsCluster) -> Int { self.size }

pub fn OptconvexbfgsCluster::get(self : OptconvexbfgsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexbfgsCluster::set(self : OptconvexbfgsCluster, i : Int, v : Double) -> OptconvexbfgsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsCluster::sum(self : OptconvexbfgsCluster) -> Double { @_common.sum(self.data) }

pub fn OptconvexbfgsCluster::mean(self : OptconvexbfgsCluster) -> Double { @_common.mean(self.data) }

pub fn OptconvexbfgsCluster::scale(self : OptconvexbfgsCluster, f : Double) -> OptconvexbfgsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsCluster::add(self : OptconvexbfgsCluster, other : OptconvexbfgsCluster) -> OptconvexbfgsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexbfgsCluster::copy(self : OptconvexbfgsCluster) -> OptconvexbfgsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsCluster::fill(self : OptconvexbfgsCluster, v : Double) -> OptconvexbfgsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsCluster::min(self : OptconvexbfgsCluster) -> Double { @_common.min(self.data) }

pub fn OptconvexbfgsCluster::max(self : OptconvexbfgsCluster) -> Double { @_common.max(self.data) }

pub fn OptconvexbfgsCluster::to_string(self : OptconvexbfgsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_model_make(size : Int) -> OptconvexbfgsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexbfgsModel::len(self : OptconvexbfgsModel) -> Int { self.size }

pub fn OptconvexbfgsModel::get(self : OptconvexbfgsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexbfgsModel::set(self : OptconvexbfgsModel, i : Int, v : Double) -> OptconvexbfgsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsModel::sum(self : OptconvexbfgsModel) -> Double { @_common.sum(self.data) }

pub fn OptconvexbfgsModel::mean(self : OptconvexbfgsModel) -> Double { @_common.mean(self.data) }

pub fn OptconvexbfgsModel::scale(self : OptconvexbfgsModel, f : Double) -> OptconvexbfgsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsModel::add(self : OptconvexbfgsModel, other : OptconvexbfgsModel) -> OptconvexbfgsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexbfgsModel::copy(self : OptconvexbfgsModel) -> OptconvexbfgsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsModel::fill(self : OptconvexbfgsModel, v : Double) -> OptconvexbfgsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsModel::min(self : OptconvexbfgsModel) -> Double { @_common.min(self.data) }

pub fn OptconvexbfgsModel::max(self : OptconvexbfgsModel) -> Double { @_common.max(self.data) }

pub fn OptconvexbfgsModel::to_string(self : OptconvexbfgsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_layer_make(size : Int) -> OptconvexbfgsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexbfgsLayer::len(self : OptconvexbfgsLayer) -> Int { self.size }

pub fn OptconvexbfgsLayer::get(self : OptconvexbfgsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexbfgsLayer::set(self : OptconvexbfgsLayer, i : Int, v : Double) -> OptconvexbfgsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsLayer::sum(self : OptconvexbfgsLayer) -> Double { @_common.sum(self.data) }

pub fn OptconvexbfgsLayer::mean(self : OptconvexbfgsLayer) -> Double { @_common.mean(self.data) }

pub fn OptconvexbfgsLayer::scale(self : OptconvexbfgsLayer, f : Double) -> OptconvexbfgsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsLayer::add(self : OptconvexbfgsLayer, other : OptconvexbfgsLayer) -> OptconvexbfgsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexbfgsLayer::copy(self : OptconvexbfgsLayer) -> OptconvexbfgsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsLayer::fill(self : OptconvexbfgsLayer, v : Double) -> OptconvexbfgsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsLayer::min(self : OptconvexbfgsLayer) -> Double { @_common.min(self.data) }

pub fn OptconvexbfgsLayer::max(self : OptconvexbfgsLayer) -> Double { @_common.max(self.data) }

pub fn OptconvexbfgsLayer::to_string(self : OptconvexbfgsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_buffer_make(size : Int) -> OptconvexbfgsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexbfgsBuffer::len(self : OptconvexbfgsBuffer) -> Int { self.size }

pub fn OptconvexbfgsBuffer::get(self : OptconvexbfgsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexbfgsBuffer::set(self : OptconvexbfgsBuffer, i : Int, v : Double) -> OptconvexbfgsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsBuffer::sum(self : OptconvexbfgsBuffer) -> Double { @_common.sum(self.data) }

pub fn OptconvexbfgsBuffer::mean(self : OptconvexbfgsBuffer) -> Double { @_common.mean(self.data) }

pub fn OptconvexbfgsBuffer::scale(self : OptconvexbfgsBuffer, f : Double) -> OptconvexbfgsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsBuffer::add(self : OptconvexbfgsBuffer, other : OptconvexbfgsBuffer) -> OptconvexbfgsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexbfgsBuffer::copy(self : OptconvexbfgsBuffer) -> OptconvexbfgsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsBuffer::fill(self : OptconvexbfgsBuffer, v : Double) -> OptconvexbfgsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsBuffer::min(self : OptconvexbfgsBuffer) -> Double { @_common.min(self.data) }

pub fn OptconvexbfgsBuffer::max(self : OptconvexbfgsBuffer) -> Double { @_common.max(self.data) }

pub fn OptconvexbfgsBuffer::to_string(self : OptconvexbfgsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_cursor_make(size : Int) -> OptconvexbfgsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexbfgsCursor::len(self : OptconvexbfgsCursor) -> Int { self.size }

pub fn OptconvexbfgsCursor::get(self : OptconvexbfgsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexbfgsCursor::set(self : OptconvexbfgsCursor, i : Int, v : Double) -> OptconvexbfgsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsCursor::sum(self : OptconvexbfgsCursor) -> Double { @_common.sum(self.data) }

pub fn OptconvexbfgsCursor::mean(self : OptconvexbfgsCursor) -> Double { @_common.mean(self.data) }

pub fn OptconvexbfgsCursor::scale(self : OptconvexbfgsCursor, f : Double) -> OptconvexbfgsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsCursor::add(self : OptconvexbfgsCursor, other : OptconvexbfgsCursor) -> OptconvexbfgsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexbfgsCursor::copy(self : OptconvexbfgsCursor) -> OptconvexbfgsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsCursor::fill(self : OptconvexbfgsCursor, v : Double) -> OptconvexbfgsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsCursor::min(self : OptconvexbfgsCursor) -> Double { @_common.min(self.data) }

pub fn OptconvexbfgsCursor::max(self : OptconvexbfgsCursor) -> Double { @_common.max(self.data) }

pub fn OptconvexbfgsCursor::to_string(self : OptconvexbfgsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_view_make(size : Int) -> OptconvexbfgsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexbfgsView::len(self : OptconvexbfgsView) -> Int { self.size }

pub fn OptconvexbfgsView::get(self : OptconvexbfgsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexbfgsView::set(self : OptconvexbfgsView, i : Int, v : Double) -> OptconvexbfgsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsView::sum(self : OptconvexbfgsView) -> Double { @_common.sum(self.data) }

pub fn OptconvexbfgsView::mean(self : OptconvexbfgsView) -> Double { @_common.mean(self.data) }

pub fn OptconvexbfgsView::scale(self : OptconvexbfgsView, f : Double) -> OptconvexbfgsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsView::add(self : OptconvexbfgsView, other : OptconvexbfgsView) -> OptconvexbfgsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexbfgsView::copy(self : OptconvexbfgsView) -> OptconvexbfgsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsView::fill(self : OptconvexbfgsView, v : Double) -> OptconvexbfgsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsView::min(self : OptconvexbfgsView) -> Double { @_common.min(self.data) }

pub fn OptconvexbfgsView::max(self : OptconvexbfgsView) -> Double { @_common.max(self.data) }

pub fn OptconvexbfgsView::to_string(self : OptconvexbfgsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_range_make(size : Int) -> OptconvexbfgsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexbfgsRange::len(self : OptconvexbfgsRange) -> Int { self.size }

pub fn OptconvexbfgsRange::get(self : OptconvexbfgsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexbfgsRange::set(self : OptconvexbfgsRange, i : Int, v : Double) -> OptconvexbfgsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsRange::sum(self : OptconvexbfgsRange) -> Double { @_common.sum(self.data) }

pub fn OptconvexbfgsRange::mean(self : OptconvexbfgsRange) -> Double { @_common.mean(self.data) }

pub fn OptconvexbfgsRange::scale(self : OptconvexbfgsRange, f : Double) -> OptconvexbfgsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsRange::add(self : OptconvexbfgsRange, other : OptconvexbfgsRange) -> OptconvexbfgsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexbfgsRange::copy(self : OptconvexbfgsRange) -> OptconvexbfgsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsRange::fill(self : OptconvexbfgsRange, v : Double) -> OptconvexbfgsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsRange::min(self : OptconvexbfgsRange) -> Double { @_common.min(self.data) }

pub fn OptconvexbfgsRange::max(self : OptconvexbfgsRange) -> Double { @_common.max(self.data) }

pub fn OptconvexbfgsRange::to_string(self : OptconvexbfgsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_slice_make(size : Int) -> OptconvexbfgsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexbfgsSlice::len(self : OptconvexbfgsSlice) -> Int { self.size }

pub fn OptconvexbfgsSlice::get(self : OptconvexbfgsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexbfgsSlice::set(self : OptconvexbfgsSlice, i : Int, v : Double) -> OptconvexbfgsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsSlice::sum(self : OptconvexbfgsSlice) -> Double { @_common.sum(self.data) }

pub fn OptconvexbfgsSlice::mean(self : OptconvexbfgsSlice) -> Double { @_common.mean(self.data) }

pub fn OptconvexbfgsSlice::scale(self : OptconvexbfgsSlice, f : Double) -> OptconvexbfgsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsSlice::add(self : OptconvexbfgsSlice, other : OptconvexbfgsSlice) -> OptconvexbfgsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexbfgsSlice::copy(self : OptconvexbfgsSlice) -> OptconvexbfgsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsSlice::fill(self : OptconvexbfgsSlice, v : Double) -> OptconvexbfgsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexbfgsSlice::min(self : OptconvexbfgsSlice) -> Double { @_common.min(self.data) }

pub fn OptconvexbfgsSlice::max(self : OptconvexbfgsSlice) -> Double { @_common.max(self.data) }

pub fn OptconvexbfgsSlice::to_string(self : OptconvexbfgsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

