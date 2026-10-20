///===
/// extcore/opt_convex_l_bfgs

pub(all) struct OptconvexlbfgsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_l_bfgs_make_point(x : Double, y : Double) -> OptconvexlbfgsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_l_bfgs_make_point3(x : Double, y : Double, z : Double) -> OptconvexlbfgsPoint {
  { x, y, z, label: 0 }
}

pub fn OptconvexlbfgsPoint::x(self : OptconvexlbfgsPoint) -> Double { self.x }

pub fn OptconvexlbfgsPoint::y(self : OptconvexlbfgsPoint) -> Double { self.y }

pub fn OptconvexlbfgsPoint::z(self : OptconvexlbfgsPoint) -> Double { self.z }

pub fn OptconvexlbfgsPoint::label(self : OptconvexlbfgsPoint) -> Int { self.label }

pub fn OptconvexlbfgsPoint::dist(self : OptconvexlbfgsPoint, other : OptconvexlbfgsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvexlbfgsPoint::add(self : OptconvexlbfgsPoint, other : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvexlbfgsPoint::sub(self : OptconvexlbfgsPoint, other : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvexlbfgsPoint::scale(self : OptconvexlbfgsPoint, s : Double) -> OptconvexlbfgsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvexlbfgsPoint::dot(self : OptconvexlbfgsPoint, other : OptconvexlbfgsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvexlbfgsPoint::cross(self : OptconvexlbfgsPoint, other : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvexlbfgsPoint::norm(self : OptconvexlbfgsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvexlbfgsPoint::normalize(self : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexlbfgsPoint::negate(self : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvexlbfgsPoint::mid(self : OptconvexlbfgsPoint, other : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvexlbfgsPoint::lerp(self : OptconvexlbfgsPoint, other : OptconvexlbfgsPoint, t : Double) -> OptconvexlbfgsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvexlbfgsPoint::to_string(self : OptconvexlbfgsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvexlbfgsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_l_bfgs_make_series(vals : Array[Double], name : String) -> OptconvexlbfgsSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvexlbfgsSeries::len(self : OptconvexlbfgsSeries) -> Int { self.vals.length() }

pub fn OptconvexlbfgsSeries::sum(self : OptconvexlbfgsSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvexlbfgsSeries::mean(self : OptconvexlbfgsSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvexlbfgsSeries::min(self : OptconvexlbfgsSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvexlbfgsSeries::max(self : OptconvexlbfgsSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvexlbfgsSeries::range(self : OptconvexlbfgsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvexlbfgsSeries::variance(self : OptconvexlbfgsSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvexlbfgsSeries::std(self : OptconvexlbfgsSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvexlbfgsSeries::median(self : OptconvexlbfgsSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvexlbfgsSeries::scale(self : OptconvexlbfgsSeries, f : Double) -> OptconvexlbfgsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvexlbfgsSeries::add(self : OptconvexlbfgsSeries, other : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvexlbfgsSeries::sub(self : OptconvexlbfgsSeries, other : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvexlbfgsSeries::normalize(self : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvexlbfgsSeries::cumsum(self : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvexlbfgsSeries::to_string(self : OptconvexlbfgsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexlbfgsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_l_bfgs_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexlbfgsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_l_bfgs_matrix_identity(n : Int) -> OptconvexlbfgsMatrix {
  let m = opt_convex_l_bfgs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvexlbfgsMatrix::get(self : OptconvexlbfgsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvexlbfgsMatrix::transpose(self : OptconvexlbfgsMatrix) -> OptconvexlbfgsMatrix {
  let result = opt_convex_l_bfgs_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvexlbfgsMatrix::add(self : OptconvexlbfgsMatrix, other : OptconvexlbfgsMatrix) -> OptconvexlbfgsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_l_bfgs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvexlbfgsMatrix::scale(self : OptconvexlbfgsMatrix, s : Double) -> OptconvexlbfgsMatrix {
  let result = opt_convex_l_bfgs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvexlbfgsMatrix::multiply(self : OptconvexlbfgsMatrix, other : OptconvexlbfgsMatrix) -> OptconvexlbfgsMatrix {
  if self.cols != other.rows { return opt_convex_l_bfgs_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_l_bfgs_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn OptconvexlbfgsMatrix::trace(self : OptconvexlbfgsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvexlbfgsMatrix::det(self : OptconvexlbfgsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvexlbfgsMatrix::norm(self : OptconvexlbfgsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvexlbfgsMatrix::to_string(self : OptconvexlbfgsMatrix) -> String {
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

pub(all) struct OptconvexlbfgsVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_l_bfgs_make_vector(comps : Array[Double]) -> OptconvexlbfgsVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_l_bfgs_vector_zero(dim : Int) -> OptconvexlbfgsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvexlbfgsVector::add(self : OptconvexlbfgsVector, other : OptconvexlbfgsVector) -> OptconvexlbfgsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexlbfgsVector::sub(self : OptconvexlbfgsVector, other : OptconvexlbfgsVector) -> OptconvexlbfgsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexlbfgsVector::scale(self : OptconvexlbfgsVector, s : Double) -> OptconvexlbfgsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvexlbfgsVector::dot(self : OptconvexlbfgsVector, other : OptconvexlbfgsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvexlbfgsVector::norm(self : OptconvexlbfgsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvexlbfgsVector::normalize(self : OptconvexlbfgsVector) -> OptconvexlbfgsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexlbfgsVector::dist(self : OptconvexlbfgsVector, other : OptconvexlbfgsVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvexlbfgsVector::to_string(self : OptconvexlbfgsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexlbfgsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_frame_make(size : Int) -> OptconvexlbfgsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlbfgsFrame::len(self : OptconvexlbfgsFrame) -> Int { self.size }

pub fn OptconvexlbfgsFrame::get(self : OptconvexlbfgsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlbfgsFrame::set(self : OptconvexlbfgsFrame, i : Int, v : Double) -> OptconvexlbfgsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsFrame::sum(self : OptconvexlbfgsFrame) -> Double { @_common.sum(self.data) }

pub fn OptconvexlbfgsFrame::mean(self : OptconvexlbfgsFrame) -> Double { @_common.mean(self.data) }

pub fn OptconvexlbfgsFrame::scale(self : OptconvexlbfgsFrame, f : Double) -> OptconvexlbfgsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsFrame::add(self : OptconvexlbfgsFrame, other : OptconvexlbfgsFrame) -> OptconvexlbfgsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlbfgsFrame::copy(self : OptconvexlbfgsFrame) -> OptconvexlbfgsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsFrame::fill(self : OptconvexlbfgsFrame, v : Double) -> OptconvexlbfgsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsFrame::min(self : OptconvexlbfgsFrame) -> Double { @_common.min(self.data) }

pub fn OptconvexlbfgsFrame::max(self : OptconvexlbfgsFrame) -> Double { @_common.max(self.data) }

pub fn OptconvexlbfgsFrame::to_string(self : OptconvexlbfgsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_table_make(size : Int) -> OptconvexlbfgsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlbfgsTable::len(self : OptconvexlbfgsTable) -> Int { self.size }

pub fn OptconvexlbfgsTable::get(self : OptconvexlbfgsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlbfgsTable::set(self : OptconvexlbfgsTable, i : Int, v : Double) -> OptconvexlbfgsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsTable::sum(self : OptconvexlbfgsTable) -> Double { @_common.sum(self.data) }

pub fn OptconvexlbfgsTable::mean(self : OptconvexlbfgsTable) -> Double { @_common.mean(self.data) }

pub fn OptconvexlbfgsTable::scale(self : OptconvexlbfgsTable, f : Double) -> OptconvexlbfgsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsTable::add(self : OptconvexlbfgsTable, other : OptconvexlbfgsTable) -> OptconvexlbfgsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlbfgsTable::copy(self : OptconvexlbfgsTable) -> OptconvexlbfgsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsTable::fill(self : OptconvexlbfgsTable, v : Double) -> OptconvexlbfgsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsTable::min(self : OptconvexlbfgsTable) -> Double { @_common.min(self.data) }

pub fn OptconvexlbfgsTable::max(self : OptconvexlbfgsTable) -> Double { @_common.max(self.data) }

pub fn OptconvexlbfgsTable::to_string(self : OptconvexlbfgsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_graphn_make(size : Int) -> OptconvexlbfgsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlbfgsGraphN::len(self : OptconvexlbfgsGraphN) -> Int { self.size }

pub fn OptconvexlbfgsGraphN::get(self : OptconvexlbfgsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlbfgsGraphN::set(self : OptconvexlbfgsGraphN, i : Int, v : Double) -> OptconvexlbfgsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsGraphN::sum(self : OptconvexlbfgsGraphN) -> Double { @_common.sum(self.data) }

pub fn OptconvexlbfgsGraphN::mean(self : OptconvexlbfgsGraphN) -> Double { @_common.mean(self.data) }

pub fn OptconvexlbfgsGraphN::scale(self : OptconvexlbfgsGraphN, f : Double) -> OptconvexlbfgsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsGraphN::add(self : OptconvexlbfgsGraphN, other : OptconvexlbfgsGraphN) -> OptconvexlbfgsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlbfgsGraphN::copy(self : OptconvexlbfgsGraphN) -> OptconvexlbfgsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsGraphN::fill(self : OptconvexlbfgsGraphN, v : Double) -> OptconvexlbfgsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsGraphN::min(self : OptconvexlbfgsGraphN) -> Double { @_common.min(self.data) }

pub fn OptconvexlbfgsGraphN::max(self : OptconvexlbfgsGraphN) -> Double { @_common.max(self.data) }

pub fn OptconvexlbfgsGraphN::to_string(self : OptconvexlbfgsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_node_make(size : Int) -> OptconvexlbfgsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlbfgsNode::len(self : OptconvexlbfgsNode) -> Int { self.size }

pub fn OptconvexlbfgsNode::get(self : OptconvexlbfgsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlbfgsNode::set(self : OptconvexlbfgsNode, i : Int, v : Double) -> OptconvexlbfgsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsNode::sum(self : OptconvexlbfgsNode) -> Double { @_common.sum(self.data) }

pub fn OptconvexlbfgsNode::mean(self : OptconvexlbfgsNode) -> Double { @_common.mean(self.data) }

pub fn OptconvexlbfgsNode::scale(self : OptconvexlbfgsNode, f : Double) -> OptconvexlbfgsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsNode::add(self : OptconvexlbfgsNode, other : OptconvexlbfgsNode) -> OptconvexlbfgsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlbfgsNode::copy(self : OptconvexlbfgsNode) -> OptconvexlbfgsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsNode::fill(self : OptconvexlbfgsNode, v : Double) -> OptconvexlbfgsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsNode::min(self : OptconvexlbfgsNode) -> Double { @_common.min(self.data) }

pub fn OptconvexlbfgsNode::max(self : OptconvexlbfgsNode) -> Double { @_common.max(self.data) }

pub fn OptconvexlbfgsNode::to_string(self : OptconvexlbfgsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_edge_make(size : Int) -> OptconvexlbfgsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlbfgsEdge::len(self : OptconvexlbfgsEdge) -> Int { self.size }

pub fn OptconvexlbfgsEdge::get(self : OptconvexlbfgsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlbfgsEdge::set(self : OptconvexlbfgsEdge, i : Int, v : Double) -> OptconvexlbfgsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsEdge::sum(self : OptconvexlbfgsEdge) -> Double { @_common.sum(self.data) }

pub fn OptconvexlbfgsEdge::mean(self : OptconvexlbfgsEdge) -> Double { @_common.mean(self.data) }

pub fn OptconvexlbfgsEdge::scale(self : OptconvexlbfgsEdge, f : Double) -> OptconvexlbfgsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsEdge::add(self : OptconvexlbfgsEdge, other : OptconvexlbfgsEdge) -> OptconvexlbfgsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlbfgsEdge::copy(self : OptconvexlbfgsEdge) -> OptconvexlbfgsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsEdge::fill(self : OptconvexlbfgsEdge, v : Double) -> OptconvexlbfgsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsEdge::min(self : OptconvexlbfgsEdge) -> Double { @_common.min(self.data) }

pub fn OptconvexlbfgsEdge::max(self : OptconvexlbfgsEdge) -> Double { @_common.max(self.data) }

pub fn OptconvexlbfgsEdge::to_string(self : OptconvexlbfgsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_path_make(size : Int) -> OptconvexlbfgsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlbfgsPath::len(self : OptconvexlbfgsPath) -> Int { self.size }

pub fn OptconvexlbfgsPath::get(self : OptconvexlbfgsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlbfgsPath::set(self : OptconvexlbfgsPath, i : Int, v : Double) -> OptconvexlbfgsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsPath::sum(self : OptconvexlbfgsPath) -> Double { @_common.sum(self.data) }

pub fn OptconvexlbfgsPath::mean(self : OptconvexlbfgsPath) -> Double { @_common.mean(self.data) }

pub fn OptconvexlbfgsPath::scale(self : OptconvexlbfgsPath, f : Double) -> OptconvexlbfgsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsPath::add(self : OptconvexlbfgsPath, other : OptconvexlbfgsPath) -> OptconvexlbfgsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlbfgsPath::copy(self : OptconvexlbfgsPath) -> OptconvexlbfgsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsPath::fill(self : OptconvexlbfgsPath, v : Double) -> OptconvexlbfgsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsPath::min(self : OptconvexlbfgsPath) -> Double { @_common.min(self.data) }

pub fn OptconvexlbfgsPath::max(self : OptconvexlbfgsPath) -> Double { @_common.max(self.data) }

pub fn OptconvexlbfgsPath::to_string(self : OptconvexlbfgsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_cluster_make(size : Int) -> OptconvexlbfgsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlbfgsCluster::len(self : OptconvexlbfgsCluster) -> Int { self.size }

pub fn OptconvexlbfgsCluster::get(self : OptconvexlbfgsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlbfgsCluster::set(self : OptconvexlbfgsCluster, i : Int, v : Double) -> OptconvexlbfgsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsCluster::sum(self : OptconvexlbfgsCluster) -> Double { @_common.sum(self.data) }

pub fn OptconvexlbfgsCluster::mean(self : OptconvexlbfgsCluster) -> Double { @_common.mean(self.data) }

pub fn OptconvexlbfgsCluster::scale(self : OptconvexlbfgsCluster, f : Double) -> OptconvexlbfgsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsCluster::add(self : OptconvexlbfgsCluster, other : OptconvexlbfgsCluster) -> OptconvexlbfgsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlbfgsCluster::copy(self : OptconvexlbfgsCluster) -> OptconvexlbfgsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsCluster::fill(self : OptconvexlbfgsCluster, v : Double) -> OptconvexlbfgsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsCluster::min(self : OptconvexlbfgsCluster) -> Double { @_common.min(self.data) }

pub fn OptconvexlbfgsCluster::max(self : OptconvexlbfgsCluster) -> Double { @_common.max(self.data) }

pub fn OptconvexlbfgsCluster::to_string(self : OptconvexlbfgsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_model_make(size : Int) -> OptconvexlbfgsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlbfgsModel::len(self : OptconvexlbfgsModel) -> Int { self.size }

pub fn OptconvexlbfgsModel::get(self : OptconvexlbfgsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlbfgsModel::set(self : OptconvexlbfgsModel, i : Int, v : Double) -> OptconvexlbfgsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsModel::sum(self : OptconvexlbfgsModel) -> Double { @_common.sum(self.data) }

pub fn OptconvexlbfgsModel::mean(self : OptconvexlbfgsModel) -> Double { @_common.mean(self.data) }

pub fn OptconvexlbfgsModel::scale(self : OptconvexlbfgsModel, f : Double) -> OptconvexlbfgsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsModel::add(self : OptconvexlbfgsModel, other : OptconvexlbfgsModel) -> OptconvexlbfgsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlbfgsModel::copy(self : OptconvexlbfgsModel) -> OptconvexlbfgsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsModel::fill(self : OptconvexlbfgsModel, v : Double) -> OptconvexlbfgsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsModel::min(self : OptconvexlbfgsModel) -> Double { @_common.min(self.data) }

pub fn OptconvexlbfgsModel::max(self : OptconvexlbfgsModel) -> Double { @_common.max(self.data) }

pub fn OptconvexlbfgsModel::to_string(self : OptconvexlbfgsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_layer_make(size : Int) -> OptconvexlbfgsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlbfgsLayer::len(self : OptconvexlbfgsLayer) -> Int { self.size }

pub fn OptconvexlbfgsLayer::get(self : OptconvexlbfgsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlbfgsLayer::set(self : OptconvexlbfgsLayer, i : Int, v : Double) -> OptconvexlbfgsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsLayer::sum(self : OptconvexlbfgsLayer) -> Double { @_common.sum(self.data) }

pub fn OptconvexlbfgsLayer::mean(self : OptconvexlbfgsLayer) -> Double { @_common.mean(self.data) }

pub fn OptconvexlbfgsLayer::scale(self : OptconvexlbfgsLayer, f : Double) -> OptconvexlbfgsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsLayer::add(self : OptconvexlbfgsLayer, other : OptconvexlbfgsLayer) -> OptconvexlbfgsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlbfgsLayer::copy(self : OptconvexlbfgsLayer) -> OptconvexlbfgsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsLayer::fill(self : OptconvexlbfgsLayer, v : Double) -> OptconvexlbfgsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsLayer::min(self : OptconvexlbfgsLayer) -> Double { @_common.min(self.data) }

pub fn OptconvexlbfgsLayer::max(self : OptconvexlbfgsLayer) -> Double { @_common.max(self.data) }

pub fn OptconvexlbfgsLayer::to_string(self : OptconvexlbfgsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_buffer_make(size : Int) -> OptconvexlbfgsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlbfgsBuffer::len(self : OptconvexlbfgsBuffer) -> Int { self.size }

pub fn OptconvexlbfgsBuffer::get(self : OptconvexlbfgsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlbfgsBuffer::set(self : OptconvexlbfgsBuffer, i : Int, v : Double) -> OptconvexlbfgsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsBuffer::sum(self : OptconvexlbfgsBuffer) -> Double { @_common.sum(self.data) }

pub fn OptconvexlbfgsBuffer::mean(self : OptconvexlbfgsBuffer) -> Double { @_common.mean(self.data) }

pub fn OptconvexlbfgsBuffer::scale(self : OptconvexlbfgsBuffer, f : Double) -> OptconvexlbfgsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsBuffer::add(self : OptconvexlbfgsBuffer, other : OptconvexlbfgsBuffer) -> OptconvexlbfgsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlbfgsBuffer::copy(self : OptconvexlbfgsBuffer) -> OptconvexlbfgsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsBuffer::fill(self : OptconvexlbfgsBuffer, v : Double) -> OptconvexlbfgsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsBuffer::min(self : OptconvexlbfgsBuffer) -> Double { @_common.min(self.data) }

pub fn OptconvexlbfgsBuffer::max(self : OptconvexlbfgsBuffer) -> Double { @_common.max(self.data) }

pub fn OptconvexlbfgsBuffer::to_string(self : OptconvexlbfgsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_cursor_make(size : Int) -> OptconvexlbfgsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlbfgsCursor::len(self : OptconvexlbfgsCursor) -> Int { self.size }

pub fn OptconvexlbfgsCursor::get(self : OptconvexlbfgsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlbfgsCursor::set(self : OptconvexlbfgsCursor, i : Int, v : Double) -> OptconvexlbfgsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsCursor::sum(self : OptconvexlbfgsCursor) -> Double { @_common.sum(self.data) }

pub fn OptconvexlbfgsCursor::mean(self : OptconvexlbfgsCursor) -> Double { @_common.mean(self.data) }

pub fn OptconvexlbfgsCursor::scale(self : OptconvexlbfgsCursor, f : Double) -> OptconvexlbfgsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsCursor::add(self : OptconvexlbfgsCursor, other : OptconvexlbfgsCursor) -> OptconvexlbfgsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlbfgsCursor::copy(self : OptconvexlbfgsCursor) -> OptconvexlbfgsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsCursor::fill(self : OptconvexlbfgsCursor, v : Double) -> OptconvexlbfgsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsCursor::min(self : OptconvexlbfgsCursor) -> Double { @_common.min(self.data) }

pub fn OptconvexlbfgsCursor::max(self : OptconvexlbfgsCursor) -> Double { @_common.max(self.data) }

pub fn OptconvexlbfgsCursor::to_string(self : OptconvexlbfgsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_view_make(size : Int) -> OptconvexlbfgsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlbfgsView::len(self : OptconvexlbfgsView) -> Int { self.size }

pub fn OptconvexlbfgsView::get(self : OptconvexlbfgsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlbfgsView::set(self : OptconvexlbfgsView, i : Int, v : Double) -> OptconvexlbfgsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsView::sum(self : OptconvexlbfgsView) -> Double { @_common.sum(self.data) }

pub fn OptconvexlbfgsView::mean(self : OptconvexlbfgsView) -> Double { @_common.mean(self.data) }

pub fn OptconvexlbfgsView::scale(self : OptconvexlbfgsView, f : Double) -> OptconvexlbfgsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsView::add(self : OptconvexlbfgsView, other : OptconvexlbfgsView) -> OptconvexlbfgsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlbfgsView::copy(self : OptconvexlbfgsView) -> OptconvexlbfgsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsView::fill(self : OptconvexlbfgsView, v : Double) -> OptconvexlbfgsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsView::min(self : OptconvexlbfgsView) -> Double { @_common.min(self.data) }

pub fn OptconvexlbfgsView::max(self : OptconvexlbfgsView) -> Double { @_common.max(self.data) }

pub fn OptconvexlbfgsView::to_string(self : OptconvexlbfgsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_range_make(size : Int) -> OptconvexlbfgsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlbfgsRange::len(self : OptconvexlbfgsRange) -> Int { self.size }

pub fn OptconvexlbfgsRange::get(self : OptconvexlbfgsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlbfgsRange::set(self : OptconvexlbfgsRange, i : Int, v : Double) -> OptconvexlbfgsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsRange::sum(self : OptconvexlbfgsRange) -> Double { @_common.sum(self.data) }

pub fn OptconvexlbfgsRange::mean(self : OptconvexlbfgsRange) -> Double { @_common.mean(self.data) }

pub fn OptconvexlbfgsRange::scale(self : OptconvexlbfgsRange, f : Double) -> OptconvexlbfgsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsRange::add(self : OptconvexlbfgsRange, other : OptconvexlbfgsRange) -> OptconvexlbfgsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlbfgsRange::copy(self : OptconvexlbfgsRange) -> OptconvexlbfgsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsRange::fill(self : OptconvexlbfgsRange, v : Double) -> OptconvexlbfgsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsRange::min(self : OptconvexlbfgsRange) -> Double { @_common.min(self.data) }

pub fn OptconvexlbfgsRange::max(self : OptconvexlbfgsRange) -> Double { @_common.max(self.data) }

pub fn OptconvexlbfgsRange::to_string(self : OptconvexlbfgsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_slice_make(size : Int) -> OptconvexlbfgsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexlbfgsSlice::len(self : OptconvexlbfgsSlice) -> Int { self.size }

pub fn OptconvexlbfgsSlice::get(self : OptconvexlbfgsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexlbfgsSlice::set(self : OptconvexlbfgsSlice, i : Int, v : Double) -> OptconvexlbfgsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsSlice::sum(self : OptconvexlbfgsSlice) -> Double { @_common.sum(self.data) }

pub fn OptconvexlbfgsSlice::mean(self : OptconvexlbfgsSlice) -> Double { @_common.mean(self.data) }

pub fn OptconvexlbfgsSlice::scale(self : OptconvexlbfgsSlice, f : Double) -> OptconvexlbfgsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsSlice::add(self : OptconvexlbfgsSlice, other : OptconvexlbfgsSlice) -> OptconvexlbfgsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexlbfgsSlice::copy(self : OptconvexlbfgsSlice) -> OptconvexlbfgsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsSlice::fill(self : OptconvexlbfgsSlice, v : Double) -> OptconvexlbfgsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexlbfgsSlice::min(self : OptconvexlbfgsSlice) -> Double { @_common.min(self.data) }

pub fn OptconvexlbfgsSlice::max(self : OptconvexlbfgsSlice) -> Double { @_common.max(self.data) }

pub fn OptconvexlbfgsSlice::to_string(self : OptconvexlbfgsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

