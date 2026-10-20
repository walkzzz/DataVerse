///===
/// extcore/opt_convex_trust_region

pub(all) struct OptconvextrustregionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_trust_region_make_point(x : Double, y : Double) -> OptconvextrustregionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_trust_region_make_point3(x : Double, y : Double, z : Double) -> OptconvextrustregionPoint {
  { x, y, z, label: 0 }
}

pub fn OptconvextrustregionPoint::x(self : OptconvextrustregionPoint) -> Double { self.x }

pub fn OptconvextrustregionPoint::y(self : OptconvextrustregionPoint) -> Double { self.y }

pub fn OptconvextrustregionPoint::z(self : OptconvextrustregionPoint) -> Double { self.z }

pub fn OptconvextrustregionPoint::label(self : OptconvextrustregionPoint) -> Int { self.label }

pub fn OptconvextrustregionPoint::dist(self : OptconvextrustregionPoint, other : OptconvextrustregionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvextrustregionPoint::add(self : OptconvextrustregionPoint, other : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvextrustregionPoint::sub(self : OptconvextrustregionPoint, other : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvextrustregionPoint::scale(self : OptconvextrustregionPoint, s : Double) -> OptconvextrustregionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvextrustregionPoint::dot(self : OptconvextrustregionPoint, other : OptconvextrustregionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvextrustregionPoint::cross(self : OptconvextrustregionPoint, other : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvextrustregionPoint::norm(self : OptconvextrustregionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvextrustregionPoint::normalize(self : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvextrustregionPoint::negate(self : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvextrustregionPoint::mid(self : OptconvextrustregionPoint, other : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvextrustregionPoint::lerp(self : OptconvextrustregionPoint, other : OptconvextrustregionPoint, t : Double) -> OptconvextrustregionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvextrustregionPoint::to_string(self : OptconvextrustregionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvextrustregionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_trust_region_make_series(vals : Array[Double], name : String) -> OptconvextrustregionSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvextrustregionSeries::len(self : OptconvextrustregionSeries) -> Int { self.vals.length() }

pub fn OptconvextrustregionSeries::sum(self : OptconvextrustregionSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvextrustregionSeries::mean(self : OptconvextrustregionSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvextrustregionSeries::min(self : OptconvextrustregionSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvextrustregionSeries::max(self : OptconvextrustregionSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvextrustregionSeries::range(self : OptconvextrustregionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvextrustregionSeries::variance(self : OptconvextrustregionSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvextrustregionSeries::std(self : OptconvextrustregionSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvextrustregionSeries::median(self : OptconvextrustregionSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvextrustregionSeries::scale(self : OptconvextrustregionSeries, f : Double) -> OptconvextrustregionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvextrustregionSeries::add(self : OptconvextrustregionSeries, other : OptconvextrustregionSeries) -> OptconvextrustregionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvextrustregionSeries::sub(self : OptconvextrustregionSeries, other : OptconvextrustregionSeries) -> OptconvextrustregionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvextrustregionSeries::normalize(self : OptconvextrustregionSeries) -> OptconvextrustregionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvextrustregionSeries::cumsum(self : OptconvextrustregionSeries) -> OptconvextrustregionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvextrustregionSeries::to_string(self : OptconvextrustregionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvextrustregionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_trust_region_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvextrustregionMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn opt_convex_trust_region_matrix_identity(n : Int) -> OptconvextrustregionMatrix {
  let m = opt_convex_trust_region_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvextrustregionMatrix::get(self : OptconvextrustregionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvextrustregionMatrix::transpose(self : OptconvextrustregionMatrix) -> OptconvextrustregionMatrix {
  let result = opt_convex_trust_region_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvextrustregionMatrix::add(self : OptconvextrustregionMatrix, other : OptconvextrustregionMatrix) -> OptconvextrustregionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_trust_region_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvextrustregionMatrix::scale(self : OptconvextrustregionMatrix, s : Double) -> OptconvextrustregionMatrix {
  let result = opt_convex_trust_region_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvextrustregionMatrix::multiply(self : OptconvextrustregionMatrix, other : OptconvextrustregionMatrix) -> OptconvextrustregionMatrix {
  if self.cols != other.rows { return opt_convex_trust_region_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_trust_region_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn OptconvextrustregionMatrix::trace(self : OptconvextrustregionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvextrustregionMatrix::det(self : OptconvextrustregionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvextrustregionMatrix::norm(self : OptconvextrustregionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvextrustregionMatrix::to_string(self : OptconvextrustregionMatrix) -> String {
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

pub(all) struct OptconvextrustregionVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_trust_region_make_vector(comps : Array[Double]) -> OptconvextrustregionVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_trust_region_vector_zero(dim : Int) -> OptconvextrustregionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvextrustregionVector::add(self : OptconvextrustregionVector, other : OptconvextrustregionVector) -> OptconvextrustregionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvextrustregionVector::sub(self : OptconvextrustregionVector, other : OptconvextrustregionVector) -> OptconvextrustregionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvextrustregionVector::scale(self : OptconvextrustregionVector, s : Double) -> OptconvextrustregionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvextrustregionVector::dot(self : OptconvextrustregionVector, other : OptconvextrustregionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvextrustregionVector::norm(self : OptconvextrustregionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvextrustregionVector::normalize(self : OptconvextrustregionVector) -> OptconvextrustregionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvextrustregionVector::dist(self : OptconvextrustregionVector, other : OptconvextrustregionVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvextrustregionVector::to_string(self : OptconvextrustregionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvextrustregionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_frame_make(size : Int) -> OptconvextrustregionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvextrustregionFrame::len(self : OptconvextrustregionFrame) -> Int { self.size }

pub fn OptconvextrustregionFrame::get(self : OptconvextrustregionFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvextrustregionFrame::set(self : OptconvextrustregionFrame, i : Int, v : Double) -> OptconvextrustregionFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionFrame::sum(self : OptconvextrustregionFrame) -> Double { @_common.sum(self.data) }

pub fn OptconvextrustregionFrame::mean(self : OptconvextrustregionFrame) -> Double { @_common.mean(self.data) }

pub fn OptconvextrustregionFrame::scale(self : OptconvextrustregionFrame, f : Double) -> OptconvextrustregionFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionFrame::add(self : OptconvextrustregionFrame, other : OptconvextrustregionFrame) -> OptconvextrustregionFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvextrustregionFrame::copy(self : OptconvextrustregionFrame) -> OptconvextrustregionFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionFrame::fill(self : OptconvextrustregionFrame, v : Double) -> OptconvextrustregionFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionFrame::min(self : OptconvextrustregionFrame) -> Double { @_common.min(self.data) }

pub fn OptconvextrustregionFrame::max(self : OptconvextrustregionFrame) -> Double { @_common.max(self.data) }

pub fn OptconvextrustregionFrame::to_string(self : OptconvextrustregionFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_table_make(size : Int) -> OptconvextrustregionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvextrustregionTable::len(self : OptconvextrustregionTable) -> Int { self.size }

pub fn OptconvextrustregionTable::get(self : OptconvextrustregionTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvextrustregionTable::set(self : OptconvextrustregionTable, i : Int, v : Double) -> OptconvextrustregionTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionTable::sum(self : OptconvextrustregionTable) -> Double { @_common.sum(self.data) }

pub fn OptconvextrustregionTable::mean(self : OptconvextrustregionTable) -> Double { @_common.mean(self.data) }

pub fn OptconvextrustregionTable::scale(self : OptconvextrustregionTable, f : Double) -> OptconvextrustregionTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionTable::add(self : OptconvextrustregionTable, other : OptconvextrustregionTable) -> OptconvextrustregionTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvextrustregionTable::copy(self : OptconvextrustregionTable) -> OptconvextrustregionTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionTable::fill(self : OptconvextrustregionTable, v : Double) -> OptconvextrustregionTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionTable::min(self : OptconvextrustregionTable) -> Double { @_common.min(self.data) }

pub fn OptconvextrustregionTable::max(self : OptconvextrustregionTable) -> Double { @_common.max(self.data) }

pub fn OptconvextrustregionTable::to_string(self : OptconvextrustregionTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_graphn_make(size : Int) -> OptconvextrustregionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvextrustregionGraphN::len(self : OptconvextrustregionGraphN) -> Int { self.size }

pub fn OptconvextrustregionGraphN::get(self : OptconvextrustregionGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvextrustregionGraphN::set(self : OptconvextrustregionGraphN, i : Int, v : Double) -> OptconvextrustregionGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionGraphN::sum(self : OptconvextrustregionGraphN) -> Double { @_common.sum(self.data) }

pub fn OptconvextrustregionGraphN::mean(self : OptconvextrustregionGraphN) -> Double { @_common.mean(self.data) }

pub fn OptconvextrustregionGraphN::scale(self : OptconvextrustregionGraphN, f : Double) -> OptconvextrustregionGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionGraphN::add(self : OptconvextrustregionGraphN, other : OptconvextrustregionGraphN) -> OptconvextrustregionGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvextrustregionGraphN::copy(self : OptconvextrustregionGraphN) -> OptconvextrustregionGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionGraphN::fill(self : OptconvextrustregionGraphN, v : Double) -> OptconvextrustregionGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionGraphN::min(self : OptconvextrustregionGraphN) -> Double { @_common.min(self.data) }

pub fn OptconvextrustregionGraphN::max(self : OptconvextrustregionGraphN) -> Double { @_common.max(self.data) }

pub fn OptconvextrustregionGraphN::to_string(self : OptconvextrustregionGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_node_make(size : Int) -> OptconvextrustregionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvextrustregionNode::len(self : OptconvextrustregionNode) -> Int { self.size }

pub fn OptconvextrustregionNode::get(self : OptconvextrustregionNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvextrustregionNode::set(self : OptconvextrustregionNode, i : Int, v : Double) -> OptconvextrustregionNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionNode::sum(self : OptconvextrustregionNode) -> Double { @_common.sum(self.data) }

pub fn OptconvextrustregionNode::mean(self : OptconvextrustregionNode) -> Double { @_common.mean(self.data) }

pub fn OptconvextrustregionNode::scale(self : OptconvextrustregionNode, f : Double) -> OptconvextrustregionNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionNode::add(self : OptconvextrustregionNode, other : OptconvextrustregionNode) -> OptconvextrustregionNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvextrustregionNode::copy(self : OptconvextrustregionNode) -> OptconvextrustregionNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionNode::fill(self : OptconvextrustregionNode, v : Double) -> OptconvextrustregionNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionNode::min(self : OptconvextrustregionNode) -> Double { @_common.min(self.data) }

pub fn OptconvextrustregionNode::max(self : OptconvextrustregionNode) -> Double { @_common.max(self.data) }

pub fn OptconvextrustregionNode::to_string(self : OptconvextrustregionNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_edge_make(size : Int) -> OptconvextrustregionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvextrustregionEdge::len(self : OptconvextrustregionEdge) -> Int { self.size }

pub fn OptconvextrustregionEdge::get(self : OptconvextrustregionEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvextrustregionEdge::set(self : OptconvextrustregionEdge, i : Int, v : Double) -> OptconvextrustregionEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionEdge::sum(self : OptconvextrustregionEdge) -> Double { @_common.sum(self.data) }

pub fn OptconvextrustregionEdge::mean(self : OptconvextrustregionEdge) -> Double { @_common.mean(self.data) }

pub fn OptconvextrustregionEdge::scale(self : OptconvextrustregionEdge, f : Double) -> OptconvextrustregionEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionEdge::add(self : OptconvextrustregionEdge, other : OptconvextrustregionEdge) -> OptconvextrustregionEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvextrustregionEdge::copy(self : OptconvextrustregionEdge) -> OptconvextrustregionEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionEdge::fill(self : OptconvextrustregionEdge, v : Double) -> OptconvextrustregionEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionEdge::min(self : OptconvextrustregionEdge) -> Double { @_common.min(self.data) }

pub fn OptconvextrustregionEdge::max(self : OptconvextrustregionEdge) -> Double { @_common.max(self.data) }

pub fn OptconvextrustregionEdge::to_string(self : OptconvextrustregionEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_path_make(size : Int) -> OptconvextrustregionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvextrustregionPath::len(self : OptconvextrustregionPath) -> Int { self.size }

pub fn OptconvextrustregionPath::get(self : OptconvextrustregionPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvextrustregionPath::set(self : OptconvextrustregionPath, i : Int, v : Double) -> OptconvextrustregionPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionPath::sum(self : OptconvextrustregionPath) -> Double { @_common.sum(self.data) }

pub fn OptconvextrustregionPath::mean(self : OptconvextrustregionPath) -> Double { @_common.mean(self.data) }

pub fn OptconvextrustregionPath::scale(self : OptconvextrustregionPath, f : Double) -> OptconvextrustregionPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionPath::add(self : OptconvextrustregionPath, other : OptconvextrustregionPath) -> OptconvextrustregionPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvextrustregionPath::copy(self : OptconvextrustregionPath) -> OptconvextrustregionPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionPath::fill(self : OptconvextrustregionPath, v : Double) -> OptconvextrustregionPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionPath::min(self : OptconvextrustregionPath) -> Double { @_common.min(self.data) }

pub fn OptconvextrustregionPath::max(self : OptconvextrustregionPath) -> Double { @_common.max(self.data) }

pub fn OptconvextrustregionPath::to_string(self : OptconvextrustregionPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_cluster_make(size : Int) -> OptconvextrustregionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvextrustregionCluster::len(self : OptconvextrustregionCluster) -> Int { self.size }

pub fn OptconvextrustregionCluster::get(self : OptconvextrustregionCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvextrustregionCluster::set(self : OptconvextrustregionCluster, i : Int, v : Double) -> OptconvextrustregionCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionCluster::sum(self : OptconvextrustregionCluster) -> Double { @_common.sum(self.data) }

pub fn OptconvextrustregionCluster::mean(self : OptconvextrustregionCluster) -> Double { @_common.mean(self.data) }

pub fn OptconvextrustregionCluster::scale(self : OptconvextrustregionCluster, f : Double) -> OptconvextrustregionCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionCluster::add(self : OptconvextrustregionCluster, other : OptconvextrustregionCluster) -> OptconvextrustregionCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvextrustregionCluster::copy(self : OptconvextrustregionCluster) -> OptconvextrustregionCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionCluster::fill(self : OptconvextrustregionCluster, v : Double) -> OptconvextrustregionCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionCluster::min(self : OptconvextrustregionCluster) -> Double { @_common.min(self.data) }

pub fn OptconvextrustregionCluster::max(self : OptconvextrustregionCluster) -> Double { @_common.max(self.data) }

pub fn OptconvextrustregionCluster::to_string(self : OptconvextrustregionCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_model_make(size : Int) -> OptconvextrustregionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvextrustregionModel::len(self : OptconvextrustregionModel) -> Int { self.size }

pub fn OptconvextrustregionModel::get(self : OptconvextrustregionModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvextrustregionModel::set(self : OptconvextrustregionModel, i : Int, v : Double) -> OptconvextrustregionModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionModel::sum(self : OptconvextrustregionModel) -> Double { @_common.sum(self.data) }

pub fn OptconvextrustregionModel::mean(self : OptconvextrustregionModel) -> Double { @_common.mean(self.data) }

pub fn OptconvextrustregionModel::scale(self : OptconvextrustregionModel, f : Double) -> OptconvextrustregionModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionModel::add(self : OptconvextrustregionModel, other : OptconvextrustregionModel) -> OptconvextrustregionModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvextrustregionModel::copy(self : OptconvextrustregionModel) -> OptconvextrustregionModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionModel::fill(self : OptconvextrustregionModel, v : Double) -> OptconvextrustregionModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionModel::min(self : OptconvextrustregionModel) -> Double { @_common.min(self.data) }

pub fn OptconvextrustregionModel::max(self : OptconvextrustregionModel) -> Double { @_common.max(self.data) }

pub fn OptconvextrustregionModel::to_string(self : OptconvextrustregionModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_layer_make(size : Int) -> OptconvextrustregionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvextrustregionLayer::len(self : OptconvextrustregionLayer) -> Int { self.size }

pub fn OptconvextrustregionLayer::get(self : OptconvextrustregionLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvextrustregionLayer::set(self : OptconvextrustregionLayer, i : Int, v : Double) -> OptconvextrustregionLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionLayer::sum(self : OptconvextrustregionLayer) -> Double { @_common.sum(self.data) }

pub fn OptconvextrustregionLayer::mean(self : OptconvextrustregionLayer) -> Double { @_common.mean(self.data) }

pub fn OptconvextrustregionLayer::scale(self : OptconvextrustregionLayer, f : Double) -> OptconvextrustregionLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionLayer::add(self : OptconvextrustregionLayer, other : OptconvextrustregionLayer) -> OptconvextrustregionLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvextrustregionLayer::copy(self : OptconvextrustregionLayer) -> OptconvextrustregionLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionLayer::fill(self : OptconvextrustregionLayer, v : Double) -> OptconvextrustregionLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionLayer::min(self : OptconvextrustregionLayer) -> Double { @_common.min(self.data) }

pub fn OptconvextrustregionLayer::max(self : OptconvextrustregionLayer) -> Double { @_common.max(self.data) }

pub fn OptconvextrustregionLayer::to_string(self : OptconvextrustregionLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_buffer_make(size : Int) -> OptconvextrustregionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvextrustregionBuffer::len(self : OptconvextrustregionBuffer) -> Int { self.size }

pub fn OptconvextrustregionBuffer::get(self : OptconvextrustregionBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvextrustregionBuffer::set(self : OptconvextrustregionBuffer, i : Int, v : Double) -> OptconvextrustregionBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionBuffer::sum(self : OptconvextrustregionBuffer) -> Double { @_common.sum(self.data) }

pub fn OptconvextrustregionBuffer::mean(self : OptconvextrustregionBuffer) -> Double { @_common.mean(self.data) }

pub fn OptconvextrustregionBuffer::scale(self : OptconvextrustregionBuffer, f : Double) -> OptconvextrustregionBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionBuffer::add(self : OptconvextrustregionBuffer, other : OptconvextrustregionBuffer) -> OptconvextrustregionBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvextrustregionBuffer::copy(self : OptconvextrustregionBuffer) -> OptconvextrustregionBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionBuffer::fill(self : OptconvextrustregionBuffer, v : Double) -> OptconvextrustregionBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionBuffer::min(self : OptconvextrustregionBuffer) -> Double { @_common.min(self.data) }

pub fn OptconvextrustregionBuffer::max(self : OptconvextrustregionBuffer) -> Double { @_common.max(self.data) }

pub fn OptconvextrustregionBuffer::to_string(self : OptconvextrustregionBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_cursor_make(size : Int) -> OptconvextrustregionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvextrustregionCursor::len(self : OptconvextrustregionCursor) -> Int { self.size }

pub fn OptconvextrustregionCursor::get(self : OptconvextrustregionCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvextrustregionCursor::set(self : OptconvextrustregionCursor, i : Int, v : Double) -> OptconvextrustregionCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionCursor::sum(self : OptconvextrustregionCursor) -> Double { @_common.sum(self.data) }

pub fn OptconvextrustregionCursor::mean(self : OptconvextrustregionCursor) -> Double { @_common.mean(self.data) }

pub fn OptconvextrustregionCursor::scale(self : OptconvextrustregionCursor, f : Double) -> OptconvextrustregionCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionCursor::add(self : OptconvextrustregionCursor, other : OptconvextrustregionCursor) -> OptconvextrustregionCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvextrustregionCursor::copy(self : OptconvextrustregionCursor) -> OptconvextrustregionCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionCursor::fill(self : OptconvextrustregionCursor, v : Double) -> OptconvextrustregionCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionCursor::min(self : OptconvextrustregionCursor) -> Double { @_common.min(self.data) }

pub fn OptconvextrustregionCursor::max(self : OptconvextrustregionCursor) -> Double { @_common.max(self.data) }

pub fn OptconvextrustregionCursor::to_string(self : OptconvextrustregionCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_view_make(size : Int) -> OptconvextrustregionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvextrustregionView::len(self : OptconvextrustregionView) -> Int { self.size }

pub fn OptconvextrustregionView::get(self : OptconvextrustregionView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvextrustregionView::set(self : OptconvextrustregionView, i : Int, v : Double) -> OptconvextrustregionView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionView::sum(self : OptconvextrustregionView) -> Double { @_common.sum(self.data) }

pub fn OptconvextrustregionView::mean(self : OptconvextrustregionView) -> Double { @_common.mean(self.data) }

pub fn OptconvextrustregionView::scale(self : OptconvextrustregionView, f : Double) -> OptconvextrustregionView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionView::add(self : OptconvextrustregionView, other : OptconvextrustregionView) -> OptconvextrustregionView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvextrustregionView::copy(self : OptconvextrustregionView) -> OptconvextrustregionView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionView::fill(self : OptconvextrustregionView, v : Double) -> OptconvextrustregionView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionView::min(self : OptconvextrustregionView) -> Double { @_common.min(self.data) }

pub fn OptconvextrustregionView::max(self : OptconvextrustregionView) -> Double { @_common.max(self.data) }

pub fn OptconvextrustregionView::to_string(self : OptconvextrustregionView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_range_make(size : Int) -> OptconvextrustregionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvextrustregionRange::len(self : OptconvextrustregionRange) -> Int { self.size }

pub fn OptconvextrustregionRange::get(self : OptconvextrustregionRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvextrustregionRange::set(self : OptconvextrustregionRange, i : Int, v : Double) -> OptconvextrustregionRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionRange::sum(self : OptconvextrustregionRange) -> Double { @_common.sum(self.data) }

pub fn OptconvextrustregionRange::mean(self : OptconvextrustregionRange) -> Double { @_common.mean(self.data) }

pub fn OptconvextrustregionRange::scale(self : OptconvextrustregionRange, f : Double) -> OptconvextrustregionRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionRange::add(self : OptconvextrustregionRange, other : OptconvextrustregionRange) -> OptconvextrustregionRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvextrustregionRange::copy(self : OptconvextrustregionRange) -> OptconvextrustregionRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionRange::fill(self : OptconvextrustregionRange, v : Double) -> OptconvextrustregionRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionRange::min(self : OptconvextrustregionRange) -> Double { @_common.min(self.data) }

pub fn OptconvextrustregionRange::max(self : OptconvextrustregionRange) -> Double { @_common.max(self.data) }

pub fn OptconvextrustregionRange::to_string(self : OptconvextrustregionRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_slice_make(size : Int) -> OptconvextrustregionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptconvextrustregionSlice::len(self : OptconvextrustregionSlice) -> Int { self.size }

pub fn OptconvextrustregionSlice::get(self : OptconvextrustregionSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptconvextrustregionSlice::set(self : OptconvextrustregionSlice, i : Int, v : Double) -> OptconvextrustregionSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionSlice::sum(self : OptconvextrustregionSlice) -> Double { @_common.sum(self.data) }

pub fn OptconvextrustregionSlice::mean(self : OptconvextrustregionSlice) -> Double { @_common.mean(self.data) }

pub fn OptconvextrustregionSlice::scale(self : OptconvextrustregionSlice, f : Double) -> OptconvextrustregionSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionSlice::add(self : OptconvextrustregionSlice, other : OptconvextrustregionSlice) -> OptconvextrustregionSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptconvextrustregionSlice::copy(self : OptconvextrustregionSlice) -> OptconvextrustregionSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionSlice::fill(self : OptconvextrustregionSlice, v : Double) -> OptconvextrustregionSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptconvextrustregionSlice::min(self : OptconvextrustregionSlice) -> Double { @_common.min(self.data) }

pub fn OptconvextrustregionSlice::max(self : OptconvextrustregionSlice) -> Double { @_common.max(self.data) }

pub fn OptconvextrustregionSlice::to_string(self : OptconvextrustregionSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

