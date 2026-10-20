///===
/// extcore/geo_proj_conic

pub(all) struct GeoprojconicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_conic_make_point(x : Double, y : Double) -> GeoprojconicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_conic_make_point3(x : Double, y : Double, z : Double) -> GeoprojconicPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojconicPoint::x(self : GeoprojconicPoint) -> Double { self.x }

pub fn GeoprojconicPoint::y(self : GeoprojconicPoint) -> Double { self.y }

pub fn GeoprojconicPoint::z(self : GeoprojconicPoint) -> Double { self.z }

pub fn GeoprojconicPoint::label(self : GeoprojconicPoint) -> Int { self.label }

pub fn GeoprojconicPoint::dist(self : GeoprojconicPoint, other : GeoprojconicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojconicPoint::add(self : GeoprojconicPoint, other : GeoprojconicPoint) -> GeoprojconicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojconicPoint::sub(self : GeoprojconicPoint, other : GeoprojconicPoint) -> GeoprojconicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojconicPoint::scale(self : GeoprojconicPoint, s : Double) -> GeoprojconicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojconicPoint::dot(self : GeoprojconicPoint, other : GeoprojconicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojconicPoint::cross(self : GeoprojconicPoint, other : GeoprojconicPoint) -> GeoprojconicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojconicPoint::norm(self : GeoprojconicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojconicPoint::normalize(self : GeoprojconicPoint) -> GeoprojconicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojconicPoint::negate(self : GeoprojconicPoint) -> GeoprojconicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojconicPoint::mid(self : GeoprojconicPoint, other : GeoprojconicPoint) -> GeoprojconicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojconicPoint::lerp(self : GeoprojconicPoint, other : GeoprojconicPoint, t : Double) -> GeoprojconicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojconicPoint::to_string(self : GeoprojconicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojconicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_conic_make_series(vals : Array[Double], name : String) -> GeoprojconicSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojconicSeries::len(self : GeoprojconicSeries) -> Int { self.vals.length() }

pub fn GeoprojconicSeries::sum(self : GeoprojconicSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojconicSeries::mean(self : GeoprojconicSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojconicSeries::min(self : GeoprojconicSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojconicSeries::max(self : GeoprojconicSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojconicSeries::range(self : GeoprojconicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojconicSeries::variance(self : GeoprojconicSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojconicSeries::std(self : GeoprojconicSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojconicSeries::median(self : GeoprojconicSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojconicSeries::scale(self : GeoprojconicSeries, f : Double) -> GeoprojconicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojconicSeries::add(self : GeoprojconicSeries, other : GeoprojconicSeries) -> GeoprojconicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojconicSeries::sub(self : GeoprojconicSeries, other : GeoprojconicSeries) -> GeoprojconicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojconicSeries::normalize(self : GeoprojconicSeries) -> GeoprojconicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojconicSeries::cumsum(self : GeoprojconicSeries) -> GeoprojconicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojconicSeries::to_string(self : GeoprojconicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojconicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_conic_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojconicMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn geo_proj_conic_matrix_identity(n : Int) -> GeoprojconicMatrix {
  let m = geo_proj_conic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojconicMatrix::get(self : GeoprojconicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojconicMatrix::transpose(self : GeoprojconicMatrix) -> GeoprojconicMatrix {
  let result = geo_proj_conic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojconicMatrix::add(self : GeoprojconicMatrix, other : GeoprojconicMatrix) -> GeoprojconicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_conic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojconicMatrix::scale(self : GeoprojconicMatrix, s : Double) -> GeoprojconicMatrix {
  let result = geo_proj_conic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojconicMatrix::multiply(self : GeoprojconicMatrix, other : GeoprojconicMatrix) -> GeoprojconicMatrix {
  if self.cols != other.rows { return geo_proj_conic_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_conic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeoprojconicMatrix::trace(self : GeoprojconicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojconicMatrix::det(self : GeoprojconicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojconicMatrix::norm(self : GeoprojconicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojconicMatrix::to_string(self : GeoprojconicMatrix) -> String {
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

pub(all) struct GeoprojconicVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_conic_make_vector(comps : Array[Double]) -> GeoprojconicVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_conic_vector_zero(dim : Int) -> GeoprojconicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojconicVector::add(self : GeoprojconicVector, other : GeoprojconicVector) -> GeoprojconicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojconicVector::sub(self : GeoprojconicVector, other : GeoprojconicVector) -> GeoprojconicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojconicVector::scale(self : GeoprojconicVector, s : Double) -> GeoprojconicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojconicVector::dot(self : GeoprojconicVector, other : GeoprojconicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojconicVector::norm(self : GeoprojconicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojconicVector::normalize(self : GeoprojconicVector) -> GeoprojconicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojconicVector::dist(self : GeoprojconicVector, other : GeoprojconicVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojconicVector::to_string(self : GeoprojconicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojconicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_frame_make(size : Int) -> GeoprojconicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojconicFrame::len(self : GeoprojconicFrame) -> Int { self.size }

pub fn GeoprojconicFrame::get(self : GeoprojconicFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojconicFrame::set(self : GeoprojconicFrame, i : Int, v : Double) -> GeoprojconicFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojconicFrame::sum(self : GeoprojconicFrame) -> Double { @_common.sum(self.data) }

pub fn GeoprojconicFrame::mean(self : GeoprojconicFrame) -> Double { @_common.mean(self.data) }

pub fn GeoprojconicFrame::scale(self : GeoprojconicFrame, f : Double) -> GeoprojconicFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojconicFrame::add(self : GeoprojconicFrame, other : GeoprojconicFrame) -> GeoprojconicFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojconicFrame::copy(self : GeoprojconicFrame) -> GeoprojconicFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojconicFrame::fill(self : GeoprojconicFrame, v : Double) -> GeoprojconicFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojconicFrame::min(self : GeoprojconicFrame) -> Double { @_common.min(self.data) }

pub fn GeoprojconicFrame::max(self : GeoprojconicFrame) -> Double { @_common.max(self.data) }

pub fn GeoprojconicFrame::to_string(self : GeoprojconicFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojconicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_table_make(size : Int) -> GeoprojconicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojconicTable::len(self : GeoprojconicTable) -> Int { self.size }

pub fn GeoprojconicTable::get(self : GeoprojconicTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojconicTable::set(self : GeoprojconicTable, i : Int, v : Double) -> GeoprojconicTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojconicTable::sum(self : GeoprojconicTable) -> Double { @_common.sum(self.data) }

pub fn GeoprojconicTable::mean(self : GeoprojconicTable) -> Double { @_common.mean(self.data) }

pub fn GeoprojconicTable::scale(self : GeoprojconicTable, f : Double) -> GeoprojconicTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojconicTable::add(self : GeoprojconicTable, other : GeoprojconicTable) -> GeoprojconicTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojconicTable::copy(self : GeoprojconicTable) -> GeoprojconicTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojconicTable::fill(self : GeoprojconicTable, v : Double) -> GeoprojconicTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojconicTable::min(self : GeoprojconicTable) -> Double { @_common.min(self.data) }

pub fn GeoprojconicTable::max(self : GeoprojconicTable) -> Double { @_common.max(self.data) }

pub fn GeoprojconicTable::to_string(self : GeoprojconicTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojconicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_graphn_make(size : Int) -> GeoprojconicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojconicGraphN::len(self : GeoprojconicGraphN) -> Int { self.size }

pub fn GeoprojconicGraphN::get(self : GeoprojconicGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojconicGraphN::set(self : GeoprojconicGraphN, i : Int, v : Double) -> GeoprojconicGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojconicGraphN::sum(self : GeoprojconicGraphN) -> Double { @_common.sum(self.data) }

pub fn GeoprojconicGraphN::mean(self : GeoprojconicGraphN) -> Double { @_common.mean(self.data) }

pub fn GeoprojconicGraphN::scale(self : GeoprojconicGraphN, f : Double) -> GeoprojconicGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojconicGraphN::add(self : GeoprojconicGraphN, other : GeoprojconicGraphN) -> GeoprojconicGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojconicGraphN::copy(self : GeoprojconicGraphN) -> GeoprojconicGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojconicGraphN::fill(self : GeoprojconicGraphN, v : Double) -> GeoprojconicGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojconicGraphN::min(self : GeoprojconicGraphN) -> Double { @_common.min(self.data) }

pub fn GeoprojconicGraphN::max(self : GeoprojconicGraphN) -> Double { @_common.max(self.data) }

pub fn GeoprojconicGraphN::to_string(self : GeoprojconicGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojconicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_node_make(size : Int) -> GeoprojconicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojconicNode::len(self : GeoprojconicNode) -> Int { self.size }

pub fn GeoprojconicNode::get(self : GeoprojconicNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojconicNode::set(self : GeoprojconicNode, i : Int, v : Double) -> GeoprojconicNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojconicNode::sum(self : GeoprojconicNode) -> Double { @_common.sum(self.data) }

pub fn GeoprojconicNode::mean(self : GeoprojconicNode) -> Double { @_common.mean(self.data) }

pub fn GeoprojconicNode::scale(self : GeoprojconicNode, f : Double) -> GeoprojconicNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojconicNode::add(self : GeoprojconicNode, other : GeoprojconicNode) -> GeoprojconicNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojconicNode::copy(self : GeoprojconicNode) -> GeoprojconicNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojconicNode::fill(self : GeoprojconicNode, v : Double) -> GeoprojconicNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojconicNode::min(self : GeoprojconicNode) -> Double { @_common.min(self.data) }

pub fn GeoprojconicNode::max(self : GeoprojconicNode) -> Double { @_common.max(self.data) }

pub fn GeoprojconicNode::to_string(self : GeoprojconicNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojconicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_edge_make(size : Int) -> GeoprojconicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojconicEdge::len(self : GeoprojconicEdge) -> Int { self.size }

pub fn GeoprojconicEdge::get(self : GeoprojconicEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojconicEdge::set(self : GeoprojconicEdge, i : Int, v : Double) -> GeoprojconicEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojconicEdge::sum(self : GeoprojconicEdge) -> Double { @_common.sum(self.data) }

pub fn GeoprojconicEdge::mean(self : GeoprojconicEdge) -> Double { @_common.mean(self.data) }

pub fn GeoprojconicEdge::scale(self : GeoprojconicEdge, f : Double) -> GeoprojconicEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojconicEdge::add(self : GeoprojconicEdge, other : GeoprojconicEdge) -> GeoprojconicEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojconicEdge::copy(self : GeoprojconicEdge) -> GeoprojconicEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojconicEdge::fill(self : GeoprojconicEdge, v : Double) -> GeoprojconicEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojconicEdge::min(self : GeoprojconicEdge) -> Double { @_common.min(self.data) }

pub fn GeoprojconicEdge::max(self : GeoprojconicEdge) -> Double { @_common.max(self.data) }

pub fn GeoprojconicEdge::to_string(self : GeoprojconicEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojconicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_path_make(size : Int) -> GeoprojconicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojconicPath::len(self : GeoprojconicPath) -> Int { self.size }

pub fn GeoprojconicPath::get(self : GeoprojconicPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojconicPath::set(self : GeoprojconicPath, i : Int, v : Double) -> GeoprojconicPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojconicPath::sum(self : GeoprojconicPath) -> Double { @_common.sum(self.data) }

pub fn GeoprojconicPath::mean(self : GeoprojconicPath) -> Double { @_common.mean(self.data) }

pub fn GeoprojconicPath::scale(self : GeoprojconicPath, f : Double) -> GeoprojconicPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojconicPath::add(self : GeoprojconicPath, other : GeoprojconicPath) -> GeoprojconicPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojconicPath::copy(self : GeoprojconicPath) -> GeoprojconicPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojconicPath::fill(self : GeoprojconicPath, v : Double) -> GeoprojconicPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojconicPath::min(self : GeoprojconicPath) -> Double { @_common.min(self.data) }

pub fn GeoprojconicPath::max(self : GeoprojconicPath) -> Double { @_common.max(self.data) }

pub fn GeoprojconicPath::to_string(self : GeoprojconicPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojconicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_cluster_make(size : Int) -> GeoprojconicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojconicCluster::len(self : GeoprojconicCluster) -> Int { self.size }

pub fn GeoprojconicCluster::get(self : GeoprojconicCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojconicCluster::set(self : GeoprojconicCluster, i : Int, v : Double) -> GeoprojconicCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojconicCluster::sum(self : GeoprojconicCluster) -> Double { @_common.sum(self.data) }

pub fn GeoprojconicCluster::mean(self : GeoprojconicCluster) -> Double { @_common.mean(self.data) }

pub fn GeoprojconicCluster::scale(self : GeoprojconicCluster, f : Double) -> GeoprojconicCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojconicCluster::add(self : GeoprojconicCluster, other : GeoprojconicCluster) -> GeoprojconicCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojconicCluster::copy(self : GeoprojconicCluster) -> GeoprojconicCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojconicCluster::fill(self : GeoprojconicCluster, v : Double) -> GeoprojconicCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojconicCluster::min(self : GeoprojconicCluster) -> Double { @_common.min(self.data) }

pub fn GeoprojconicCluster::max(self : GeoprojconicCluster) -> Double { @_common.max(self.data) }

pub fn GeoprojconicCluster::to_string(self : GeoprojconicCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojconicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_model_make(size : Int) -> GeoprojconicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojconicModel::len(self : GeoprojconicModel) -> Int { self.size }

pub fn GeoprojconicModel::get(self : GeoprojconicModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojconicModel::set(self : GeoprojconicModel, i : Int, v : Double) -> GeoprojconicModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojconicModel::sum(self : GeoprojconicModel) -> Double { @_common.sum(self.data) }

pub fn GeoprojconicModel::mean(self : GeoprojconicModel) -> Double { @_common.mean(self.data) }

pub fn GeoprojconicModel::scale(self : GeoprojconicModel, f : Double) -> GeoprojconicModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojconicModel::add(self : GeoprojconicModel, other : GeoprojconicModel) -> GeoprojconicModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojconicModel::copy(self : GeoprojconicModel) -> GeoprojconicModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojconicModel::fill(self : GeoprojconicModel, v : Double) -> GeoprojconicModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojconicModel::min(self : GeoprojconicModel) -> Double { @_common.min(self.data) }

pub fn GeoprojconicModel::max(self : GeoprojconicModel) -> Double { @_common.max(self.data) }

pub fn GeoprojconicModel::to_string(self : GeoprojconicModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojconicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_layer_make(size : Int) -> GeoprojconicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojconicLayer::len(self : GeoprojconicLayer) -> Int { self.size }

pub fn GeoprojconicLayer::get(self : GeoprojconicLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojconicLayer::set(self : GeoprojconicLayer, i : Int, v : Double) -> GeoprojconicLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojconicLayer::sum(self : GeoprojconicLayer) -> Double { @_common.sum(self.data) }

pub fn GeoprojconicLayer::mean(self : GeoprojconicLayer) -> Double { @_common.mean(self.data) }

pub fn GeoprojconicLayer::scale(self : GeoprojconicLayer, f : Double) -> GeoprojconicLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojconicLayer::add(self : GeoprojconicLayer, other : GeoprojconicLayer) -> GeoprojconicLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojconicLayer::copy(self : GeoprojconicLayer) -> GeoprojconicLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojconicLayer::fill(self : GeoprojconicLayer, v : Double) -> GeoprojconicLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojconicLayer::min(self : GeoprojconicLayer) -> Double { @_common.min(self.data) }

pub fn GeoprojconicLayer::max(self : GeoprojconicLayer) -> Double { @_common.max(self.data) }

pub fn GeoprojconicLayer::to_string(self : GeoprojconicLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojconicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_buffer_make(size : Int) -> GeoprojconicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojconicBuffer::len(self : GeoprojconicBuffer) -> Int { self.size }

pub fn GeoprojconicBuffer::get(self : GeoprojconicBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojconicBuffer::set(self : GeoprojconicBuffer, i : Int, v : Double) -> GeoprojconicBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojconicBuffer::sum(self : GeoprojconicBuffer) -> Double { @_common.sum(self.data) }

pub fn GeoprojconicBuffer::mean(self : GeoprojconicBuffer) -> Double { @_common.mean(self.data) }

pub fn GeoprojconicBuffer::scale(self : GeoprojconicBuffer, f : Double) -> GeoprojconicBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojconicBuffer::add(self : GeoprojconicBuffer, other : GeoprojconicBuffer) -> GeoprojconicBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojconicBuffer::copy(self : GeoprojconicBuffer) -> GeoprojconicBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojconicBuffer::fill(self : GeoprojconicBuffer, v : Double) -> GeoprojconicBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojconicBuffer::min(self : GeoprojconicBuffer) -> Double { @_common.min(self.data) }

pub fn GeoprojconicBuffer::max(self : GeoprojconicBuffer) -> Double { @_common.max(self.data) }

pub fn GeoprojconicBuffer::to_string(self : GeoprojconicBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojconicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_cursor_make(size : Int) -> GeoprojconicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojconicCursor::len(self : GeoprojconicCursor) -> Int { self.size }

pub fn GeoprojconicCursor::get(self : GeoprojconicCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojconicCursor::set(self : GeoprojconicCursor, i : Int, v : Double) -> GeoprojconicCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojconicCursor::sum(self : GeoprojconicCursor) -> Double { @_common.sum(self.data) }

pub fn GeoprojconicCursor::mean(self : GeoprojconicCursor) -> Double { @_common.mean(self.data) }

pub fn GeoprojconicCursor::scale(self : GeoprojconicCursor, f : Double) -> GeoprojconicCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojconicCursor::add(self : GeoprojconicCursor, other : GeoprojconicCursor) -> GeoprojconicCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojconicCursor::copy(self : GeoprojconicCursor) -> GeoprojconicCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojconicCursor::fill(self : GeoprojconicCursor, v : Double) -> GeoprojconicCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojconicCursor::min(self : GeoprojconicCursor) -> Double { @_common.min(self.data) }

pub fn GeoprojconicCursor::max(self : GeoprojconicCursor) -> Double { @_common.max(self.data) }

pub fn GeoprojconicCursor::to_string(self : GeoprojconicCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojconicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_view_make(size : Int) -> GeoprojconicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojconicView::len(self : GeoprojconicView) -> Int { self.size }

pub fn GeoprojconicView::get(self : GeoprojconicView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojconicView::set(self : GeoprojconicView, i : Int, v : Double) -> GeoprojconicView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojconicView::sum(self : GeoprojconicView) -> Double { @_common.sum(self.data) }

pub fn GeoprojconicView::mean(self : GeoprojconicView) -> Double { @_common.mean(self.data) }

pub fn GeoprojconicView::scale(self : GeoprojconicView, f : Double) -> GeoprojconicView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojconicView::add(self : GeoprojconicView, other : GeoprojconicView) -> GeoprojconicView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojconicView::copy(self : GeoprojconicView) -> GeoprojconicView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojconicView::fill(self : GeoprojconicView, v : Double) -> GeoprojconicView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojconicView::min(self : GeoprojconicView) -> Double { @_common.min(self.data) }

pub fn GeoprojconicView::max(self : GeoprojconicView) -> Double { @_common.max(self.data) }

pub fn GeoprojconicView::to_string(self : GeoprojconicView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojconicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_range_make(size : Int) -> GeoprojconicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojconicRange::len(self : GeoprojconicRange) -> Int { self.size }

pub fn GeoprojconicRange::get(self : GeoprojconicRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojconicRange::set(self : GeoprojconicRange, i : Int, v : Double) -> GeoprojconicRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojconicRange::sum(self : GeoprojconicRange) -> Double { @_common.sum(self.data) }

pub fn GeoprojconicRange::mean(self : GeoprojconicRange) -> Double { @_common.mean(self.data) }

pub fn GeoprojconicRange::scale(self : GeoprojconicRange, f : Double) -> GeoprojconicRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojconicRange::add(self : GeoprojconicRange, other : GeoprojconicRange) -> GeoprojconicRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojconicRange::copy(self : GeoprojconicRange) -> GeoprojconicRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojconicRange::fill(self : GeoprojconicRange, v : Double) -> GeoprojconicRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojconicRange::min(self : GeoprojconicRange) -> Double { @_common.min(self.data) }

pub fn GeoprojconicRange::max(self : GeoprojconicRange) -> Double { @_common.max(self.data) }

pub fn GeoprojconicRange::to_string(self : GeoprojconicRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojconicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_slice_make(size : Int) -> GeoprojconicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojconicSlice::len(self : GeoprojconicSlice) -> Int { self.size }

pub fn GeoprojconicSlice::get(self : GeoprojconicSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojconicSlice::set(self : GeoprojconicSlice, i : Int, v : Double) -> GeoprojconicSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojconicSlice::sum(self : GeoprojconicSlice) -> Double { @_common.sum(self.data) }

pub fn GeoprojconicSlice::mean(self : GeoprojconicSlice) -> Double { @_common.mean(self.data) }

pub fn GeoprojconicSlice::scale(self : GeoprojconicSlice, f : Double) -> GeoprojconicSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojconicSlice::add(self : GeoprojconicSlice, other : GeoprojconicSlice) -> GeoprojconicSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojconicSlice::copy(self : GeoprojconicSlice) -> GeoprojconicSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojconicSlice::fill(self : GeoprojconicSlice, v : Double) -> GeoprojconicSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojconicSlice::min(self : GeoprojconicSlice) -> Double { @_common.min(self.data) }

pub fn GeoprojconicSlice::max(self : GeoprojconicSlice) -> Double { @_common.max(self.data) }

pub fn GeoprojconicSlice::to_string(self : GeoprojconicSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

