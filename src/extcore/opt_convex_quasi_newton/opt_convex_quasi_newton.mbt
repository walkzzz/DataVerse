///===
/// extcore/opt_convex_quasi_newton

pub(all) struct OptconvexquasinewtonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_quasi_newton_make_point(x : Double, y : Double) -> OptconvexquasinewtonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_quasi_newton_make_point3(x : Double, y : Double, z : Double) -> OptconvexquasinewtonPoint {
  { x, y, z, label: 0 }
}

pub fn OptconvexquasinewtonPoint::x(self : OptconvexquasinewtonPoint) -> Double { self.x }

pub fn OptconvexquasinewtonPoint::y(self : OptconvexquasinewtonPoint) -> Double { self.y }

pub fn OptconvexquasinewtonPoint::z(self : OptconvexquasinewtonPoint) -> Double { self.z }

pub fn OptconvexquasinewtonPoint::label(self : OptconvexquasinewtonPoint) -> Int { self.label }

pub fn OptconvexquasinewtonPoint::dist(self : OptconvexquasinewtonPoint, other : OptconvexquasinewtonPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvexquasinewtonPoint::add(self : OptconvexquasinewtonPoint, other : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvexquasinewtonPoint::sub(self : OptconvexquasinewtonPoint, other : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvexquasinewtonPoint::scale(self : OptconvexquasinewtonPoint, s : Double) -> OptconvexquasinewtonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvexquasinewtonPoint::dot(self : OptconvexquasinewtonPoint, other : OptconvexquasinewtonPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvexquasinewtonPoint::cross(self : OptconvexquasinewtonPoint, other : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvexquasinewtonPoint::norm(self : OptconvexquasinewtonPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvexquasinewtonPoint::normalize(self : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexquasinewtonPoint::negate(self : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvexquasinewtonPoint::mid(self : OptconvexquasinewtonPoint, other : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvexquasinewtonPoint::lerp(self : OptconvexquasinewtonPoint, other : OptconvexquasinewtonPoint, t : Double) -> OptconvexquasinewtonPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvexquasinewtonPoint::to_string(self : OptconvexquasinewtonPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_quasi_newton_make_series(vals : Array[Double], name : String) -> OptconvexquasinewtonSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvexquasinewtonSeries::len(self : OptconvexquasinewtonSeries) -> Int { self.vals.length() }

pub fn OptconvexquasinewtonSeries::sum(self : OptconvexquasinewtonSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvexquasinewtonSeries::mean(self : OptconvexquasinewtonSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvexquasinewtonSeries::min(self : OptconvexquasinewtonSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvexquasinewtonSeries::max(self : OptconvexquasinewtonSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvexquasinewtonSeries::range(self : OptconvexquasinewtonSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvexquasinewtonSeries::variance(self : OptconvexquasinewtonSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvexquasinewtonSeries::std(self : OptconvexquasinewtonSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvexquasinewtonSeries::median(self : OptconvexquasinewtonSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvexquasinewtonSeries::scale(self : OptconvexquasinewtonSeries, f : Double) -> OptconvexquasinewtonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvexquasinewtonSeries::add(self : OptconvexquasinewtonSeries, other : OptconvexquasinewtonSeries) -> OptconvexquasinewtonSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvexquasinewtonSeries::sub(self : OptconvexquasinewtonSeries, other : OptconvexquasinewtonSeries) -> OptconvexquasinewtonSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvexquasinewtonSeries::normalize(self : OptconvexquasinewtonSeries) -> OptconvexquasinewtonSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvexquasinewtonSeries::cumsum(self : OptconvexquasinewtonSeries) -> OptconvexquasinewtonSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvexquasinewtonSeries::to_string(self : OptconvexquasinewtonSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexquasinewtonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_quasi_newton_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexquasinewtonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_quasi_newton_matrix_identity(n : Int) -> OptconvexquasinewtonMatrix {
  let m = opt_convex_quasi_newton_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvexquasinewtonMatrix::get(self : OptconvexquasinewtonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvexquasinewtonMatrix::transpose(self : OptconvexquasinewtonMatrix) -> OptconvexquasinewtonMatrix {
  let result = opt_convex_quasi_newton_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvexquasinewtonMatrix::add(self : OptconvexquasinewtonMatrix, other : OptconvexquasinewtonMatrix) -> OptconvexquasinewtonMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_quasi_newton_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvexquasinewtonMatrix::scale(self : OptconvexquasinewtonMatrix, s : Double) -> OptconvexquasinewtonMatrix {
  let result = opt_convex_quasi_newton_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvexquasinewtonMatrix::multiply(self : OptconvexquasinewtonMatrix, other : OptconvexquasinewtonMatrix) -> OptconvexquasinewtonMatrix {
  if self.cols != other.rows { return opt_convex_quasi_newton_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_quasi_newton_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn OptconvexquasinewtonMatrix::trace(self : OptconvexquasinewtonMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvexquasinewtonMatrix::det(self : OptconvexquasinewtonMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvexquasinewtonMatrix::norm(self : OptconvexquasinewtonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvexquasinewtonMatrix::to_string(self : OptconvexquasinewtonMatrix) -> String {
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

pub(all) struct OptconvexquasinewtonVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_quasi_newton_make_vector(comps : Array[Double]) -> OptconvexquasinewtonVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_quasi_newton_vector_zero(dim : Int) -> OptconvexquasinewtonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvexquasinewtonVector::add(self : OptconvexquasinewtonVector, other : OptconvexquasinewtonVector) -> OptconvexquasinewtonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexquasinewtonVector::sub(self : OptconvexquasinewtonVector, other : OptconvexquasinewtonVector) -> OptconvexquasinewtonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvexquasinewtonVector::scale(self : OptconvexquasinewtonVector, s : Double) -> OptconvexquasinewtonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvexquasinewtonVector::dot(self : OptconvexquasinewtonVector, other : OptconvexquasinewtonVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvexquasinewtonVector::norm(self : OptconvexquasinewtonVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvexquasinewtonVector::normalize(self : OptconvexquasinewtonVector) -> OptconvexquasinewtonVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvexquasinewtonVector::dist(self : OptconvexquasinewtonVector, other : OptconvexquasinewtonVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvexquasinewtonVector::to_string(self : OptconvexquasinewtonVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexquasinewtonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_frame_make(size : Int) -> OptconvexquasinewtonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexquasinewtonFrame::len(self : OptconvexquasinewtonFrame) -> Int { self.size }

pub fn OptconvexquasinewtonFrame::get(self : OptconvexquasinewtonFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexquasinewtonFrame::set(self : OptconvexquasinewtonFrame, i : Int, v : Double) -> OptconvexquasinewtonFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonFrame::sum(self : OptconvexquasinewtonFrame) -> Double { @_common.sum(self.data) }

pub fn OptconvexquasinewtonFrame::mean(self : OptconvexquasinewtonFrame) -> Double { @_common.mean(self.data) }

pub fn OptconvexquasinewtonFrame::scale(self : OptconvexquasinewtonFrame, f : Double) -> OptconvexquasinewtonFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonFrame::add(self : OptconvexquasinewtonFrame, other : OptconvexquasinewtonFrame) -> OptconvexquasinewtonFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexquasinewtonFrame::copy(self : OptconvexquasinewtonFrame) -> OptconvexquasinewtonFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonFrame::fill(self : OptconvexquasinewtonFrame, v : Double) -> OptconvexquasinewtonFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonFrame::min(self : OptconvexquasinewtonFrame) -> Double { @_common.min(self.data) }

pub fn OptconvexquasinewtonFrame::max(self : OptconvexquasinewtonFrame) -> Double { @_common.max(self.data) }

pub fn OptconvexquasinewtonFrame::to_string(self : OptconvexquasinewtonFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_table_make(size : Int) -> OptconvexquasinewtonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexquasinewtonTable::len(self : OptconvexquasinewtonTable) -> Int { self.size }

pub fn OptconvexquasinewtonTable::get(self : OptconvexquasinewtonTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexquasinewtonTable::set(self : OptconvexquasinewtonTable, i : Int, v : Double) -> OptconvexquasinewtonTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonTable::sum(self : OptconvexquasinewtonTable) -> Double { @_common.sum(self.data) }

pub fn OptconvexquasinewtonTable::mean(self : OptconvexquasinewtonTable) -> Double { @_common.mean(self.data) }

pub fn OptconvexquasinewtonTable::scale(self : OptconvexquasinewtonTable, f : Double) -> OptconvexquasinewtonTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonTable::add(self : OptconvexquasinewtonTable, other : OptconvexquasinewtonTable) -> OptconvexquasinewtonTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexquasinewtonTable::copy(self : OptconvexquasinewtonTable) -> OptconvexquasinewtonTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonTable::fill(self : OptconvexquasinewtonTable, v : Double) -> OptconvexquasinewtonTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonTable::min(self : OptconvexquasinewtonTable) -> Double { @_common.min(self.data) }

pub fn OptconvexquasinewtonTable::max(self : OptconvexquasinewtonTable) -> Double { @_common.max(self.data) }

pub fn OptconvexquasinewtonTable::to_string(self : OptconvexquasinewtonTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_graphn_make(size : Int) -> OptconvexquasinewtonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexquasinewtonGraphN::len(self : OptconvexquasinewtonGraphN) -> Int { self.size }

pub fn OptconvexquasinewtonGraphN::get(self : OptconvexquasinewtonGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexquasinewtonGraphN::set(self : OptconvexquasinewtonGraphN, i : Int, v : Double) -> OptconvexquasinewtonGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonGraphN::sum(self : OptconvexquasinewtonGraphN) -> Double { @_common.sum(self.data) }

pub fn OptconvexquasinewtonGraphN::mean(self : OptconvexquasinewtonGraphN) -> Double { @_common.mean(self.data) }

pub fn OptconvexquasinewtonGraphN::scale(self : OptconvexquasinewtonGraphN, f : Double) -> OptconvexquasinewtonGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonGraphN::add(self : OptconvexquasinewtonGraphN, other : OptconvexquasinewtonGraphN) -> OptconvexquasinewtonGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexquasinewtonGraphN::copy(self : OptconvexquasinewtonGraphN) -> OptconvexquasinewtonGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonGraphN::fill(self : OptconvexquasinewtonGraphN, v : Double) -> OptconvexquasinewtonGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonGraphN::min(self : OptconvexquasinewtonGraphN) -> Double { @_common.min(self.data) }

pub fn OptconvexquasinewtonGraphN::max(self : OptconvexquasinewtonGraphN) -> Double { @_common.max(self.data) }

pub fn OptconvexquasinewtonGraphN::to_string(self : OptconvexquasinewtonGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_node_make(size : Int) -> OptconvexquasinewtonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexquasinewtonNode::len(self : OptconvexquasinewtonNode) -> Int { self.size }

pub fn OptconvexquasinewtonNode::get(self : OptconvexquasinewtonNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexquasinewtonNode::set(self : OptconvexquasinewtonNode, i : Int, v : Double) -> OptconvexquasinewtonNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonNode::sum(self : OptconvexquasinewtonNode) -> Double { @_common.sum(self.data) }

pub fn OptconvexquasinewtonNode::mean(self : OptconvexquasinewtonNode) -> Double { @_common.mean(self.data) }

pub fn OptconvexquasinewtonNode::scale(self : OptconvexquasinewtonNode, f : Double) -> OptconvexquasinewtonNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonNode::add(self : OptconvexquasinewtonNode, other : OptconvexquasinewtonNode) -> OptconvexquasinewtonNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexquasinewtonNode::copy(self : OptconvexquasinewtonNode) -> OptconvexquasinewtonNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonNode::fill(self : OptconvexquasinewtonNode, v : Double) -> OptconvexquasinewtonNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonNode::min(self : OptconvexquasinewtonNode) -> Double { @_common.min(self.data) }

pub fn OptconvexquasinewtonNode::max(self : OptconvexquasinewtonNode) -> Double { @_common.max(self.data) }

pub fn OptconvexquasinewtonNode::to_string(self : OptconvexquasinewtonNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_edge_make(size : Int) -> OptconvexquasinewtonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexquasinewtonEdge::len(self : OptconvexquasinewtonEdge) -> Int { self.size }

pub fn OptconvexquasinewtonEdge::get(self : OptconvexquasinewtonEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexquasinewtonEdge::set(self : OptconvexquasinewtonEdge, i : Int, v : Double) -> OptconvexquasinewtonEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonEdge::sum(self : OptconvexquasinewtonEdge) -> Double { @_common.sum(self.data) }

pub fn OptconvexquasinewtonEdge::mean(self : OptconvexquasinewtonEdge) -> Double { @_common.mean(self.data) }

pub fn OptconvexquasinewtonEdge::scale(self : OptconvexquasinewtonEdge, f : Double) -> OptconvexquasinewtonEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonEdge::add(self : OptconvexquasinewtonEdge, other : OptconvexquasinewtonEdge) -> OptconvexquasinewtonEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexquasinewtonEdge::copy(self : OptconvexquasinewtonEdge) -> OptconvexquasinewtonEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonEdge::fill(self : OptconvexquasinewtonEdge, v : Double) -> OptconvexquasinewtonEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonEdge::min(self : OptconvexquasinewtonEdge) -> Double { @_common.min(self.data) }

pub fn OptconvexquasinewtonEdge::max(self : OptconvexquasinewtonEdge) -> Double { @_common.max(self.data) }

pub fn OptconvexquasinewtonEdge::to_string(self : OptconvexquasinewtonEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_path_make(size : Int) -> OptconvexquasinewtonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexquasinewtonPath::len(self : OptconvexquasinewtonPath) -> Int { self.size }

pub fn OptconvexquasinewtonPath::get(self : OptconvexquasinewtonPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexquasinewtonPath::set(self : OptconvexquasinewtonPath, i : Int, v : Double) -> OptconvexquasinewtonPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonPath::sum(self : OptconvexquasinewtonPath) -> Double { @_common.sum(self.data) }

pub fn OptconvexquasinewtonPath::mean(self : OptconvexquasinewtonPath) -> Double { @_common.mean(self.data) }

pub fn OptconvexquasinewtonPath::scale(self : OptconvexquasinewtonPath, f : Double) -> OptconvexquasinewtonPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonPath::add(self : OptconvexquasinewtonPath, other : OptconvexquasinewtonPath) -> OptconvexquasinewtonPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexquasinewtonPath::copy(self : OptconvexquasinewtonPath) -> OptconvexquasinewtonPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonPath::fill(self : OptconvexquasinewtonPath, v : Double) -> OptconvexquasinewtonPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonPath::min(self : OptconvexquasinewtonPath) -> Double { @_common.min(self.data) }

pub fn OptconvexquasinewtonPath::max(self : OptconvexquasinewtonPath) -> Double { @_common.max(self.data) }

pub fn OptconvexquasinewtonPath::to_string(self : OptconvexquasinewtonPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_cluster_make(size : Int) -> OptconvexquasinewtonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexquasinewtonCluster::len(self : OptconvexquasinewtonCluster) -> Int { self.size }

pub fn OptconvexquasinewtonCluster::get(self : OptconvexquasinewtonCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexquasinewtonCluster::set(self : OptconvexquasinewtonCluster, i : Int, v : Double) -> OptconvexquasinewtonCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonCluster::sum(self : OptconvexquasinewtonCluster) -> Double { @_common.sum(self.data) }

pub fn OptconvexquasinewtonCluster::mean(self : OptconvexquasinewtonCluster) -> Double { @_common.mean(self.data) }

pub fn OptconvexquasinewtonCluster::scale(self : OptconvexquasinewtonCluster, f : Double) -> OptconvexquasinewtonCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonCluster::add(self : OptconvexquasinewtonCluster, other : OptconvexquasinewtonCluster) -> OptconvexquasinewtonCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexquasinewtonCluster::copy(self : OptconvexquasinewtonCluster) -> OptconvexquasinewtonCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonCluster::fill(self : OptconvexquasinewtonCluster, v : Double) -> OptconvexquasinewtonCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonCluster::min(self : OptconvexquasinewtonCluster) -> Double { @_common.min(self.data) }

pub fn OptconvexquasinewtonCluster::max(self : OptconvexquasinewtonCluster) -> Double { @_common.max(self.data) }

pub fn OptconvexquasinewtonCluster::to_string(self : OptconvexquasinewtonCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_model_make(size : Int) -> OptconvexquasinewtonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexquasinewtonModel::len(self : OptconvexquasinewtonModel) -> Int { self.size }

pub fn OptconvexquasinewtonModel::get(self : OptconvexquasinewtonModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexquasinewtonModel::set(self : OptconvexquasinewtonModel, i : Int, v : Double) -> OptconvexquasinewtonModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonModel::sum(self : OptconvexquasinewtonModel) -> Double { @_common.sum(self.data) }

pub fn OptconvexquasinewtonModel::mean(self : OptconvexquasinewtonModel) -> Double { @_common.mean(self.data) }

pub fn OptconvexquasinewtonModel::scale(self : OptconvexquasinewtonModel, f : Double) -> OptconvexquasinewtonModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonModel::add(self : OptconvexquasinewtonModel, other : OptconvexquasinewtonModel) -> OptconvexquasinewtonModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexquasinewtonModel::copy(self : OptconvexquasinewtonModel) -> OptconvexquasinewtonModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonModel::fill(self : OptconvexquasinewtonModel, v : Double) -> OptconvexquasinewtonModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonModel::min(self : OptconvexquasinewtonModel) -> Double { @_common.min(self.data) }

pub fn OptconvexquasinewtonModel::max(self : OptconvexquasinewtonModel) -> Double { @_common.max(self.data) }

pub fn OptconvexquasinewtonModel::to_string(self : OptconvexquasinewtonModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_layer_make(size : Int) -> OptconvexquasinewtonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexquasinewtonLayer::len(self : OptconvexquasinewtonLayer) -> Int { self.size }

pub fn OptconvexquasinewtonLayer::get(self : OptconvexquasinewtonLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexquasinewtonLayer::set(self : OptconvexquasinewtonLayer, i : Int, v : Double) -> OptconvexquasinewtonLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonLayer::sum(self : OptconvexquasinewtonLayer) -> Double { @_common.sum(self.data) }

pub fn OptconvexquasinewtonLayer::mean(self : OptconvexquasinewtonLayer) -> Double { @_common.mean(self.data) }

pub fn OptconvexquasinewtonLayer::scale(self : OptconvexquasinewtonLayer, f : Double) -> OptconvexquasinewtonLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonLayer::add(self : OptconvexquasinewtonLayer, other : OptconvexquasinewtonLayer) -> OptconvexquasinewtonLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexquasinewtonLayer::copy(self : OptconvexquasinewtonLayer) -> OptconvexquasinewtonLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonLayer::fill(self : OptconvexquasinewtonLayer, v : Double) -> OptconvexquasinewtonLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonLayer::min(self : OptconvexquasinewtonLayer) -> Double { @_common.min(self.data) }

pub fn OptconvexquasinewtonLayer::max(self : OptconvexquasinewtonLayer) -> Double { @_common.max(self.data) }

pub fn OptconvexquasinewtonLayer::to_string(self : OptconvexquasinewtonLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_buffer_make(size : Int) -> OptconvexquasinewtonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexquasinewtonBuffer::len(self : OptconvexquasinewtonBuffer) -> Int { self.size }

pub fn OptconvexquasinewtonBuffer::get(self : OptconvexquasinewtonBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexquasinewtonBuffer::set(self : OptconvexquasinewtonBuffer, i : Int, v : Double) -> OptconvexquasinewtonBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonBuffer::sum(self : OptconvexquasinewtonBuffer) -> Double { @_common.sum(self.data) }

pub fn OptconvexquasinewtonBuffer::mean(self : OptconvexquasinewtonBuffer) -> Double { @_common.mean(self.data) }

pub fn OptconvexquasinewtonBuffer::scale(self : OptconvexquasinewtonBuffer, f : Double) -> OptconvexquasinewtonBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonBuffer::add(self : OptconvexquasinewtonBuffer, other : OptconvexquasinewtonBuffer) -> OptconvexquasinewtonBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexquasinewtonBuffer::copy(self : OptconvexquasinewtonBuffer) -> OptconvexquasinewtonBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonBuffer::fill(self : OptconvexquasinewtonBuffer, v : Double) -> OptconvexquasinewtonBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonBuffer::min(self : OptconvexquasinewtonBuffer) -> Double { @_common.min(self.data) }

pub fn OptconvexquasinewtonBuffer::max(self : OptconvexquasinewtonBuffer) -> Double { @_common.max(self.data) }

pub fn OptconvexquasinewtonBuffer::to_string(self : OptconvexquasinewtonBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_cursor_make(size : Int) -> OptconvexquasinewtonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexquasinewtonCursor::len(self : OptconvexquasinewtonCursor) -> Int { self.size }

pub fn OptconvexquasinewtonCursor::get(self : OptconvexquasinewtonCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexquasinewtonCursor::set(self : OptconvexquasinewtonCursor, i : Int, v : Double) -> OptconvexquasinewtonCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonCursor::sum(self : OptconvexquasinewtonCursor) -> Double { @_common.sum(self.data) }

pub fn OptconvexquasinewtonCursor::mean(self : OptconvexquasinewtonCursor) -> Double { @_common.mean(self.data) }

pub fn OptconvexquasinewtonCursor::scale(self : OptconvexquasinewtonCursor, f : Double) -> OptconvexquasinewtonCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonCursor::add(self : OptconvexquasinewtonCursor, other : OptconvexquasinewtonCursor) -> OptconvexquasinewtonCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexquasinewtonCursor::copy(self : OptconvexquasinewtonCursor) -> OptconvexquasinewtonCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonCursor::fill(self : OptconvexquasinewtonCursor, v : Double) -> OptconvexquasinewtonCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonCursor::min(self : OptconvexquasinewtonCursor) -> Double { @_common.min(self.data) }

pub fn OptconvexquasinewtonCursor::max(self : OptconvexquasinewtonCursor) -> Double { @_common.max(self.data) }

pub fn OptconvexquasinewtonCursor::to_string(self : OptconvexquasinewtonCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_view_make(size : Int) -> OptconvexquasinewtonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexquasinewtonView::len(self : OptconvexquasinewtonView) -> Int { self.size }

pub fn OptconvexquasinewtonView::get(self : OptconvexquasinewtonView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexquasinewtonView::set(self : OptconvexquasinewtonView, i : Int, v : Double) -> OptconvexquasinewtonView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonView::sum(self : OptconvexquasinewtonView) -> Double { @_common.sum(self.data) }

pub fn OptconvexquasinewtonView::mean(self : OptconvexquasinewtonView) -> Double { @_common.mean(self.data) }

pub fn OptconvexquasinewtonView::scale(self : OptconvexquasinewtonView, f : Double) -> OptconvexquasinewtonView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonView::add(self : OptconvexquasinewtonView, other : OptconvexquasinewtonView) -> OptconvexquasinewtonView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexquasinewtonView::copy(self : OptconvexquasinewtonView) -> OptconvexquasinewtonView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonView::fill(self : OptconvexquasinewtonView, v : Double) -> OptconvexquasinewtonView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonView::min(self : OptconvexquasinewtonView) -> Double { @_common.min(self.data) }

pub fn OptconvexquasinewtonView::max(self : OptconvexquasinewtonView) -> Double { @_common.max(self.data) }

pub fn OptconvexquasinewtonView::to_string(self : OptconvexquasinewtonView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_range_make(size : Int) -> OptconvexquasinewtonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexquasinewtonRange::len(self : OptconvexquasinewtonRange) -> Int { self.size }

pub fn OptconvexquasinewtonRange::get(self : OptconvexquasinewtonRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexquasinewtonRange::set(self : OptconvexquasinewtonRange, i : Int, v : Double) -> OptconvexquasinewtonRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonRange::sum(self : OptconvexquasinewtonRange) -> Double { @_common.sum(self.data) }

pub fn OptconvexquasinewtonRange::mean(self : OptconvexquasinewtonRange) -> Double { @_common.mean(self.data) }

pub fn OptconvexquasinewtonRange::scale(self : OptconvexquasinewtonRange, f : Double) -> OptconvexquasinewtonRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonRange::add(self : OptconvexquasinewtonRange, other : OptconvexquasinewtonRange) -> OptconvexquasinewtonRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexquasinewtonRange::copy(self : OptconvexquasinewtonRange) -> OptconvexquasinewtonRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonRange::fill(self : OptconvexquasinewtonRange, v : Double) -> OptconvexquasinewtonRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonRange::min(self : OptconvexquasinewtonRange) -> Double { @_common.min(self.data) }

pub fn OptconvexquasinewtonRange::max(self : OptconvexquasinewtonRange) -> Double { @_common.max(self.data) }

pub fn OptconvexquasinewtonRange::to_string(self : OptconvexquasinewtonRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_slice_make(size : Int) -> OptconvexquasinewtonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvexquasinewtonSlice::len(self : OptconvexquasinewtonSlice) -> Int { self.size }

pub fn OptconvexquasinewtonSlice::get(self : OptconvexquasinewtonSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvexquasinewtonSlice::set(self : OptconvexquasinewtonSlice, i : Int, v : Double) -> OptconvexquasinewtonSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonSlice::sum(self : OptconvexquasinewtonSlice) -> Double { @_common.sum(self.data) }

pub fn OptconvexquasinewtonSlice::mean(self : OptconvexquasinewtonSlice) -> Double { @_common.mean(self.data) }

pub fn OptconvexquasinewtonSlice::scale(self : OptconvexquasinewtonSlice, f : Double) -> OptconvexquasinewtonSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonSlice::add(self : OptconvexquasinewtonSlice, other : OptconvexquasinewtonSlice) -> OptconvexquasinewtonSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvexquasinewtonSlice::copy(self : OptconvexquasinewtonSlice) -> OptconvexquasinewtonSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonSlice::fill(self : OptconvexquasinewtonSlice, v : Double) -> OptconvexquasinewtonSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvexquasinewtonSlice::min(self : OptconvexquasinewtonSlice) -> Double { @_common.min(self.data) }

pub fn OptconvexquasinewtonSlice::max(self : OptconvexquasinewtonSlice) -> Double { @_common.max(self.data) }

pub fn OptconvexquasinewtonSlice::to_string(self : OptconvexquasinewtonSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

