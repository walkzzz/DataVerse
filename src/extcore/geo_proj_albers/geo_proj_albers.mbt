///===
/// extcore/geo_proj_albers

pub(all) struct GeoprojalbersPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_albers_make_point(x : Double, y : Double) -> GeoprojalbersPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_albers_make_point3(x : Double, y : Double, z : Double) -> GeoprojalbersPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojalbersPoint::x(self : GeoprojalbersPoint) -> Double { self.x }

pub fn GeoprojalbersPoint::y(self : GeoprojalbersPoint) -> Double { self.y }

pub fn GeoprojalbersPoint::z(self : GeoprojalbersPoint) -> Double { self.z }

pub fn GeoprojalbersPoint::label(self : GeoprojalbersPoint) -> Int { self.label }

pub fn GeoprojalbersPoint::dist(self : GeoprojalbersPoint, other : GeoprojalbersPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojalbersPoint::add(self : GeoprojalbersPoint, other : GeoprojalbersPoint) -> GeoprojalbersPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojalbersPoint::sub(self : GeoprojalbersPoint, other : GeoprojalbersPoint) -> GeoprojalbersPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojalbersPoint::scale(self : GeoprojalbersPoint, s : Double) -> GeoprojalbersPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojalbersPoint::dot(self : GeoprojalbersPoint, other : GeoprojalbersPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojalbersPoint::cross(self : GeoprojalbersPoint, other : GeoprojalbersPoint) -> GeoprojalbersPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojalbersPoint::norm(self : GeoprojalbersPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojalbersPoint::normalize(self : GeoprojalbersPoint) -> GeoprojalbersPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojalbersPoint::negate(self : GeoprojalbersPoint) -> GeoprojalbersPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojalbersPoint::mid(self : GeoprojalbersPoint, other : GeoprojalbersPoint) -> GeoprojalbersPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojalbersPoint::lerp(self : GeoprojalbersPoint, other : GeoprojalbersPoint, t : Double) -> GeoprojalbersPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojalbersPoint::to_string(self : GeoprojalbersPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojalbersSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_albers_make_series(vals : Array[Double], name : String) -> GeoprojalbersSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojalbersSeries::len(self : GeoprojalbersSeries) -> Int { self.vals.length() }

pub fn GeoprojalbersSeries::sum(self : GeoprojalbersSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojalbersSeries::mean(self : GeoprojalbersSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojalbersSeries::min(self : GeoprojalbersSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojalbersSeries::max(self : GeoprojalbersSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojalbersSeries::range(self : GeoprojalbersSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojalbersSeries::variance(self : GeoprojalbersSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojalbersSeries::std(self : GeoprojalbersSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojalbersSeries::median(self : GeoprojalbersSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojalbersSeries::scale(self : GeoprojalbersSeries, f : Double) -> GeoprojalbersSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojalbersSeries::add(self : GeoprojalbersSeries, other : GeoprojalbersSeries) -> GeoprojalbersSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojalbersSeries::sub(self : GeoprojalbersSeries, other : GeoprojalbersSeries) -> GeoprojalbersSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojalbersSeries::normalize(self : GeoprojalbersSeries) -> GeoprojalbersSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojalbersSeries::cumsum(self : GeoprojalbersSeries) -> GeoprojalbersSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojalbersSeries::to_string(self : GeoprojalbersSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojalbersMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_albers_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojalbersMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_albers_matrix_identity(n : Int) -> GeoprojalbersMatrix {
  let m = geo_proj_albers_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojalbersMatrix::get(self : GeoprojalbersMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojalbersMatrix::transpose(self : GeoprojalbersMatrix) -> GeoprojalbersMatrix {
  let result = geo_proj_albers_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojalbersMatrix::add(self : GeoprojalbersMatrix, other : GeoprojalbersMatrix) -> GeoprojalbersMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_albers_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojalbersMatrix::scale(self : GeoprojalbersMatrix, s : Double) -> GeoprojalbersMatrix {
  let result = geo_proj_albers_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojalbersMatrix::multiply(self : GeoprojalbersMatrix, other : GeoprojalbersMatrix) -> GeoprojalbersMatrix {
  if self.cols != other.rows { return geo_proj_albers_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_albers_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeoprojalbersMatrix::trace(self : GeoprojalbersMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojalbersMatrix::det(self : GeoprojalbersMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojalbersMatrix::norm(self : GeoprojalbersMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojalbersMatrix::to_string(self : GeoprojalbersMatrix) -> String {
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

pub(all) struct GeoprojalbersVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_albers_make_vector(comps : Array[Double]) -> GeoprojalbersVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_albers_vector_zero(dim : Int) -> GeoprojalbersVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojalbersVector::add(self : GeoprojalbersVector, other : GeoprojalbersVector) -> GeoprojalbersVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojalbersVector::sub(self : GeoprojalbersVector, other : GeoprojalbersVector) -> GeoprojalbersVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojalbersVector::scale(self : GeoprojalbersVector, s : Double) -> GeoprojalbersVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojalbersVector::dot(self : GeoprojalbersVector, other : GeoprojalbersVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojalbersVector::norm(self : GeoprojalbersVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojalbersVector::normalize(self : GeoprojalbersVector) -> GeoprojalbersVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojalbersVector::dist(self : GeoprojalbersVector, other : GeoprojalbersVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojalbersVector::to_string(self : GeoprojalbersVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojalbersFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_frame_make(size : Int) -> GeoprojalbersFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojalbersFrame::len(self : GeoprojalbersFrame) -> Int { self.size }

pub fn GeoprojalbersFrame::get(self : GeoprojalbersFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojalbersFrame::set(self : GeoprojalbersFrame, i : Int, v : Double) -> GeoprojalbersFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojalbersFrame::sum(self : GeoprojalbersFrame) -> Double { @_common.sum(self.data) }

pub fn GeoprojalbersFrame::mean(self : GeoprojalbersFrame) -> Double { @_common.mean(self.data) }

pub fn GeoprojalbersFrame::scale(self : GeoprojalbersFrame, f : Double) -> GeoprojalbersFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersFrame::add(self : GeoprojalbersFrame, other : GeoprojalbersFrame) -> GeoprojalbersFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojalbersFrame::copy(self : GeoprojalbersFrame) -> GeoprojalbersFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersFrame::fill(self : GeoprojalbersFrame, v : Double) -> GeoprojalbersFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersFrame::min(self : GeoprojalbersFrame) -> Double { @_common.min(self.data) }

pub fn GeoprojalbersFrame::max(self : GeoprojalbersFrame) -> Double { @_common.max(self.data) }

pub fn GeoprojalbersFrame::to_string(self : GeoprojalbersFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_table_make(size : Int) -> GeoprojalbersTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojalbersTable::len(self : GeoprojalbersTable) -> Int { self.size }

pub fn GeoprojalbersTable::get(self : GeoprojalbersTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojalbersTable::set(self : GeoprojalbersTable, i : Int, v : Double) -> GeoprojalbersTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojalbersTable::sum(self : GeoprojalbersTable) -> Double { @_common.sum(self.data) }

pub fn GeoprojalbersTable::mean(self : GeoprojalbersTable) -> Double { @_common.mean(self.data) }

pub fn GeoprojalbersTable::scale(self : GeoprojalbersTable, f : Double) -> GeoprojalbersTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersTable::add(self : GeoprojalbersTable, other : GeoprojalbersTable) -> GeoprojalbersTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojalbersTable::copy(self : GeoprojalbersTable) -> GeoprojalbersTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersTable::fill(self : GeoprojalbersTable, v : Double) -> GeoprojalbersTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersTable::min(self : GeoprojalbersTable) -> Double { @_common.min(self.data) }

pub fn GeoprojalbersTable::max(self : GeoprojalbersTable) -> Double { @_common.max(self.data) }

pub fn GeoprojalbersTable::to_string(self : GeoprojalbersTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_graphn_make(size : Int) -> GeoprojalbersGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojalbersGraphN::len(self : GeoprojalbersGraphN) -> Int { self.size }

pub fn GeoprojalbersGraphN::get(self : GeoprojalbersGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojalbersGraphN::set(self : GeoprojalbersGraphN, i : Int, v : Double) -> GeoprojalbersGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojalbersGraphN::sum(self : GeoprojalbersGraphN) -> Double { @_common.sum(self.data) }

pub fn GeoprojalbersGraphN::mean(self : GeoprojalbersGraphN) -> Double { @_common.mean(self.data) }

pub fn GeoprojalbersGraphN::scale(self : GeoprojalbersGraphN, f : Double) -> GeoprojalbersGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersGraphN::add(self : GeoprojalbersGraphN, other : GeoprojalbersGraphN) -> GeoprojalbersGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojalbersGraphN::copy(self : GeoprojalbersGraphN) -> GeoprojalbersGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersGraphN::fill(self : GeoprojalbersGraphN, v : Double) -> GeoprojalbersGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersGraphN::min(self : GeoprojalbersGraphN) -> Double { @_common.min(self.data) }

pub fn GeoprojalbersGraphN::max(self : GeoprojalbersGraphN) -> Double { @_common.max(self.data) }

pub fn GeoprojalbersGraphN::to_string(self : GeoprojalbersGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_node_make(size : Int) -> GeoprojalbersNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojalbersNode::len(self : GeoprojalbersNode) -> Int { self.size }

pub fn GeoprojalbersNode::get(self : GeoprojalbersNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojalbersNode::set(self : GeoprojalbersNode, i : Int, v : Double) -> GeoprojalbersNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojalbersNode::sum(self : GeoprojalbersNode) -> Double { @_common.sum(self.data) }

pub fn GeoprojalbersNode::mean(self : GeoprojalbersNode) -> Double { @_common.mean(self.data) }

pub fn GeoprojalbersNode::scale(self : GeoprojalbersNode, f : Double) -> GeoprojalbersNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersNode::add(self : GeoprojalbersNode, other : GeoprojalbersNode) -> GeoprojalbersNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojalbersNode::copy(self : GeoprojalbersNode) -> GeoprojalbersNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersNode::fill(self : GeoprojalbersNode, v : Double) -> GeoprojalbersNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersNode::min(self : GeoprojalbersNode) -> Double { @_common.min(self.data) }

pub fn GeoprojalbersNode::max(self : GeoprojalbersNode) -> Double { @_common.max(self.data) }

pub fn GeoprojalbersNode::to_string(self : GeoprojalbersNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_edge_make(size : Int) -> GeoprojalbersEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojalbersEdge::len(self : GeoprojalbersEdge) -> Int { self.size }

pub fn GeoprojalbersEdge::get(self : GeoprojalbersEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojalbersEdge::set(self : GeoprojalbersEdge, i : Int, v : Double) -> GeoprojalbersEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojalbersEdge::sum(self : GeoprojalbersEdge) -> Double { @_common.sum(self.data) }

pub fn GeoprojalbersEdge::mean(self : GeoprojalbersEdge) -> Double { @_common.mean(self.data) }

pub fn GeoprojalbersEdge::scale(self : GeoprojalbersEdge, f : Double) -> GeoprojalbersEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersEdge::add(self : GeoprojalbersEdge, other : GeoprojalbersEdge) -> GeoprojalbersEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojalbersEdge::copy(self : GeoprojalbersEdge) -> GeoprojalbersEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersEdge::fill(self : GeoprojalbersEdge, v : Double) -> GeoprojalbersEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersEdge::min(self : GeoprojalbersEdge) -> Double { @_common.min(self.data) }

pub fn GeoprojalbersEdge::max(self : GeoprojalbersEdge) -> Double { @_common.max(self.data) }

pub fn GeoprojalbersEdge::to_string(self : GeoprojalbersEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_path_make(size : Int) -> GeoprojalbersPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojalbersPath::len(self : GeoprojalbersPath) -> Int { self.size }

pub fn GeoprojalbersPath::get(self : GeoprojalbersPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojalbersPath::set(self : GeoprojalbersPath, i : Int, v : Double) -> GeoprojalbersPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojalbersPath::sum(self : GeoprojalbersPath) -> Double { @_common.sum(self.data) }

pub fn GeoprojalbersPath::mean(self : GeoprojalbersPath) -> Double { @_common.mean(self.data) }

pub fn GeoprojalbersPath::scale(self : GeoprojalbersPath, f : Double) -> GeoprojalbersPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersPath::add(self : GeoprojalbersPath, other : GeoprojalbersPath) -> GeoprojalbersPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojalbersPath::copy(self : GeoprojalbersPath) -> GeoprojalbersPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersPath::fill(self : GeoprojalbersPath, v : Double) -> GeoprojalbersPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersPath::min(self : GeoprojalbersPath) -> Double { @_common.min(self.data) }

pub fn GeoprojalbersPath::max(self : GeoprojalbersPath) -> Double { @_common.max(self.data) }

pub fn GeoprojalbersPath::to_string(self : GeoprojalbersPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_cluster_make(size : Int) -> GeoprojalbersCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojalbersCluster::len(self : GeoprojalbersCluster) -> Int { self.size }

pub fn GeoprojalbersCluster::get(self : GeoprojalbersCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojalbersCluster::set(self : GeoprojalbersCluster, i : Int, v : Double) -> GeoprojalbersCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojalbersCluster::sum(self : GeoprojalbersCluster) -> Double { @_common.sum(self.data) }

pub fn GeoprojalbersCluster::mean(self : GeoprojalbersCluster) -> Double { @_common.mean(self.data) }

pub fn GeoprojalbersCluster::scale(self : GeoprojalbersCluster, f : Double) -> GeoprojalbersCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersCluster::add(self : GeoprojalbersCluster, other : GeoprojalbersCluster) -> GeoprojalbersCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojalbersCluster::copy(self : GeoprojalbersCluster) -> GeoprojalbersCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersCluster::fill(self : GeoprojalbersCluster, v : Double) -> GeoprojalbersCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersCluster::min(self : GeoprojalbersCluster) -> Double { @_common.min(self.data) }

pub fn GeoprojalbersCluster::max(self : GeoprojalbersCluster) -> Double { @_common.max(self.data) }

pub fn GeoprojalbersCluster::to_string(self : GeoprojalbersCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_model_make(size : Int) -> GeoprojalbersModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojalbersModel::len(self : GeoprojalbersModel) -> Int { self.size }

pub fn GeoprojalbersModel::get(self : GeoprojalbersModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojalbersModel::set(self : GeoprojalbersModel, i : Int, v : Double) -> GeoprojalbersModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojalbersModel::sum(self : GeoprojalbersModel) -> Double { @_common.sum(self.data) }

pub fn GeoprojalbersModel::mean(self : GeoprojalbersModel) -> Double { @_common.mean(self.data) }

pub fn GeoprojalbersModel::scale(self : GeoprojalbersModel, f : Double) -> GeoprojalbersModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersModel::add(self : GeoprojalbersModel, other : GeoprojalbersModel) -> GeoprojalbersModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojalbersModel::copy(self : GeoprojalbersModel) -> GeoprojalbersModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersModel::fill(self : GeoprojalbersModel, v : Double) -> GeoprojalbersModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersModel::min(self : GeoprojalbersModel) -> Double { @_common.min(self.data) }

pub fn GeoprojalbersModel::max(self : GeoprojalbersModel) -> Double { @_common.max(self.data) }

pub fn GeoprojalbersModel::to_string(self : GeoprojalbersModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_layer_make(size : Int) -> GeoprojalbersLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojalbersLayer::len(self : GeoprojalbersLayer) -> Int { self.size }

pub fn GeoprojalbersLayer::get(self : GeoprojalbersLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojalbersLayer::set(self : GeoprojalbersLayer, i : Int, v : Double) -> GeoprojalbersLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojalbersLayer::sum(self : GeoprojalbersLayer) -> Double { @_common.sum(self.data) }

pub fn GeoprojalbersLayer::mean(self : GeoprojalbersLayer) -> Double { @_common.mean(self.data) }

pub fn GeoprojalbersLayer::scale(self : GeoprojalbersLayer, f : Double) -> GeoprojalbersLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersLayer::add(self : GeoprojalbersLayer, other : GeoprojalbersLayer) -> GeoprojalbersLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojalbersLayer::copy(self : GeoprojalbersLayer) -> GeoprojalbersLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersLayer::fill(self : GeoprojalbersLayer, v : Double) -> GeoprojalbersLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersLayer::min(self : GeoprojalbersLayer) -> Double { @_common.min(self.data) }

pub fn GeoprojalbersLayer::max(self : GeoprojalbersLayer) -> Double { @_common.max(self.data) }

pub fn GeoprojalbersLayer::to_string(self : GeoprojalbersLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_buffer_make(size : Int) -> GeoprojalbersBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojalbersBuffer::len(self : GeoprojalbersBuffer) -> Int { self.size }

pub fn GeoprojalbersBuffer::get(self : GeoprojalbersBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojalbersBuffer::set(self : GeoprojalbersBuffer, i : Int, v : Double) -> GeoprojalbersBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojalbersBuffer::sum(self : GeoprojalbersBuffer) -> Double { @_common.sum(self.data) }

pub fn GeoprojalbersBuffer::mean(self : GeoprojalbersBuffer) -> Double { @_common.mean(self.data) }

pub fn GeoprojalbersBuffer::scale(self : GeoprojalbersBuffer, f : Double) -> GeoprojalbersBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersBuffer::add(self : GeoprojalbersBuffer, other : GeoprojalbersBuffer) -> GeoprojalbersBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojalbersBuffer::copy(self : GeoprojalbersBuffer) -> GeoprojalbersBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersBuffer::fill(self : GeoprojalbersBuffer, v : Double) -> GeoprojalbersBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersBuffer::min(self : GeoprojalbersBuffer) -> Double { @_common.min(self.data) }

pub fn GeoprojalbersBuffer::max(self : GeoprojalbersBuffer) -> Double { @_common.max(self.data) }

pub fn GeoprojalbersBuffer::to_string(self : GeoprojalbersBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_cursor_make(size : Int) -> GeoprojalbersCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojalbersCursor::len(self : GeoprojalbersCursor) -> Int { self.size }

pub fn GeoprojalbersCursor::get(self : GeoprojalbersCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojalbersCursor::set(self : GeoprojalbersCursor, i : Int, v : Double) -> GeoprojalbersCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojalbersCursor::sum(self : GeoprojalbersCursor) -> Double { @_common.sum(self.data) }

pub fn GeoprojalbersCursor::mean(self : GeoprojalbersCursor) -> Double { @_common.mean(self.data) }

pub fn GeoprojalbersCursor::scale(self : GeoprojalbersCursor, f : Double) -> GeoprojalbersCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersCursor::add(self : GeoprojalbersCursor, other : GeoprojalbersCursor) -> GeoprojalbersCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojalbersCursor::copy(self : GeoprojalbersCursor) -> GeoprojalbersCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersCursor::fill(self : GeoprojalbersCursor, v : Double) -> GeoprojalbersCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersCursor::min(self : GeoprojalbersCursor) -> Double { @_common.min(self.data) }

pub fn GeoprojalbersCursor::max(self : GeoprojalbersCursor) -> Double { @_common.max(self.data) }

pub fn GeoprojalbersCursor::to_string(self : GeoprojalbersCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_view_make(size : Int) -> GeoprojalbersView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojalbersView::len(self : GeoprojalbersView) -> Int { self.size }

pub fn GeoprojalbersView::get(self : GeoprojalbersView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojalbersView::set(self : GeoprojalbersView, i : Int, v : Double) -> GeoprojalbersView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojalbersView::sum(self : GeoprojalbersView) -> Double { @_common.sum(self.data) }

pub fn GeoprojalbersView::mean(self : GeoprojalbersView) -> Double { @_common.mean(self.data) }

pub fn GeoprojalbersView::scale(self : GeoprojalbersView, f : Double) -> GeoprojalbersView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersView::add(self : GeoprojalbersView, other : GeoprojalbersView) -> GeoprojalbersView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojalbersView::copy(self : GeoprojalbersView) -> GeoprojalbersView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersView::fill(self : GeoprojalbersView, v : Double) -> GeoprojalbersView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersView::min(self : GeoprojalbersView) -> Double { @_common.min(self.data) }

pub fn GeoprojalbersView::max(self : GeoprojalbersView) -> Double { @_common.max(self.data) }

pub fn GeoprojalbersView::to_string(self : GeoprojalbersView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_range_make(size : Int) -> GeoprojalbersRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojalbersRange::len(self : GeoprojalbersRange) -> Int { self.size }

pub fn GeoprojalbersRange::get(self : GeoprojalbersRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojalbersRange::set(self : GeoprojalbersRange, i : Int, v : Double) -> GeoprojalbersRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojalbersRange::sum(self : GeoprojalbersRange) -> Double { @_common.sum(self.data) }

pub fn GeoprojalbersRange::mean(self : GeoprojalbersRange) -> Double { @_common.mean(self.data) }

pub fn GeoprojalbersRange::scale(self : GeoprojalbersRange, f : Double) -> GeoprojalbersRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersRange::add(self : GeoprojalbersRange, other : GeoprojalbersRange) -> GeoprojalbersRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojalbersRange::copy(self : GeoprojalbersRange) -> GeoprojalbersRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersRange::fill(self : GeoprojalbersRange, v : Double) -> GeoprojalbersRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersRange::min(self : GeoprojalbersRange) -> Double { @_common.min(self.data) }

pub fn GeoprojalbersRange::max(self : GeoprojalbersRange) -> Double { @_common.max(self.data) }

pub fn GeoprojalbersRange::to_string(self : GeoprojalbersRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_slice_make(size : Int) -> GeoprojalbersSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojalbersSlice::len(self : GeoprojalbersSlice) -> Int { self.size }

pub fn GeoprojalbersSlice::get(self : GeoprojalbersSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojalbersSlice::set(self : GeoprojalbersSlice, i : Int, v : Double) -> GeoprojalbersSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojalbersSlice::sum(self : GeoprojalbersSlice) -> Double { @_common.sum(self.data) }

pub fn GeoprojalbersSlice::mean(self : GeoprojalbersSlice) -> Double { @_common.mean(self.data) }

pub fn GeoprojalbersSlice::scale(self : GeoprojalbersSlice, f : Double) -> GeoprojalbersSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersSlice::add(self : GeoprojalbersSlice, other : GeoprojalbersSlice) -> GeoprojalbersSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojalbersSlice::copy(self : GeoprojalbersSlice) -> GeoprojalbersSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersSlice::fill(self : GeoprojalbersSlice, v : Double) -> GeoprojalbersSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojalbersSlice::min(self : GeoprojalbersSlice) -> Double { @_common.min(self.data) }

pub fn GeoprojalbersSlice::max(self : GeoprojalbersSlice) -> Double { @_common.max(self.data) }

pub fn GeoprojalbersSlice::to_string(self : GeoprojalbersSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

