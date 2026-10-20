///===
/// extcore/geo_proj_lambert

pub(all) struct GeoprojlambertPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_lambert_make_point(x : Double, y : Double) -> GeoprojlambertPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_lambert_make_point3(x : Double, y : Double, z : Double) -> GeoprojlambertPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojlambertPoint::x(self : GeoprojlambertPoint) -> Double { self.x }

pub fn GeoprojlambertPoint::y(self : GeoprojlambertPoint) -> Double { self.y }

pub fn GeoprojlambertPoint::z(self : GeoprojlambertPoint) -> Double { self.z }

pub fn GeoprojlambertPoint::label(self : GeoprojlambertPoint) -> Int { self.label }

pub fn GeoprojlambertPoint::dist(self : GeoprojlambertPoint, other : GeoprojlambertPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojlambertPoint::add(self : GeoprojlambertPoint, other : GeoprojlambertPoint) -> GeoprojlambertPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojlambertPoint::sub(self : GeoprojlambertPoint, other : GeoprojlambertPoint) -> GeoprojlambertPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojlambertPoint::scale(self : GeoprojlambertPoint, s : Double) -> GeoprojlambertPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojlambertPoint::dot(self : GeoprojlambertPoint, other : GeoprojlambertPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojlambertPoint::cross(self : GeoprojlambertPoint, other : GeoprojlambertPoint) -> GeoprojlambertPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojlambertPoint::norm(self : GeoprojlambertPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojlambertPoint::normalize(self : GeoprojlambertPoint) -> GeoprojlambertPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojlambertPoint::negate(self : GeoprojlambertPoint) -> GeoprojlambertPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojlambertPoint::mid(self : GeoprojlambertPoint, other : GeoprojlambertPoint) -> GeoprojlambertPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojlambertPoint::lerp(self : GeoprojlambertPoint, other : GeoprojlambertPoint, t : Double) -> GeoprojlambertPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojlambertPoint::to_string(self : GeoprojlambertPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojlambertSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_lambert_make_series(vals : Array[Double], name : String) -> GeoprojlambertSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojlambertSeries::len(self : GeoprojlambertSeries) -> Int { self.vals.length() }

pub fn GeoprojlambertSeries::sum(self : GeoprojlambertSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojlambertSeries::mean(self : GeoprojlambertSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojlambertSeries::min(self : GeoprojlambertSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojlambertSeries::max(self : GeoprojlambertSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojlambertSeries::range(self : GeoprojlambertSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojlambertSeries::variance(self : GeoprojlambertSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojlambertSeries::std(self : GeoprojlambertSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojlambertSeries::median(self : GeoprojlambertSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojlambertSeries::scale(self : GeoprojlambertSeries, f : Double) -> GeoprojlambertSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojlambertSeries::add(self : GeoprojlambertSeries, other : GeoprojlambertSeries) -> GeoprojlambertSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojlambertSeries::sub(self : GeoprojlambertSeries, other : GeoprojlambertSeries) -> GeoprojlambertSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojlambertSeries::normalize(self : GeoprojlambertSeries) -> GeoprojlambertSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojlambertSeries::cumsum(self : GeoprojlambertSeries) -> GeoprojlambertSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojlambertSeries::to_string(self : GeoprojlambertSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojlambertMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_lambert_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojlambertMatrix {
  let data = []
  for _ in 0..<rows { data.push(Array::make(cols, val)) }
  { data, rows, cols }
}

pub fn geo_proj_lambert_matrix_identity(n : Int) -> GeoprojlambertMatrix {
  let m = geo_proj_lambert_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojlambertMatrix::get(self : GeoprojlambertMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojlambertMatrix::transpose(self : GeoprojlambertMatrix) -> GeoprojlambertMatrix {
  let result = geo_proj_lambert_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojlambertMatrix::add(self : GeoprojlambertMatrix, other : GeoprojlambertMatrix) -> GeoprojlambertMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_lambert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojlambertMatrix::scale(self : GeoprojlambertMatrix, s : Double) -> GeoprojlambertMatrix {
  let result = geo_proj_lambert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojlambertMatrix::multiply(self : GeoprojlambertMatrix, other : GeoprojlambertMatrix) -> GeoprojlambertMatrix {
  if self.cols != other.rows { return geo_proj_lambert_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_lambert_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeoprojlambertMatrix::trace(self : GeoprojlambertMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojlambertMatrix::det(self : GeoprojlambertMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojlambertMatrix::norm(self : GeoprojlambertMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojlambertMatrix::to_string(self : GeoprojlambertMatrix) -> String {
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

pub(all) struct GeoprojlambertVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_lambert_make_vector(comps : Array[Double]) -> GeoprojlambertVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_lambert_vector_zero(dim : Int) -> GeoprojlambertVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojlambertVector::add(self : GeoprojlambertVector, other : GeoprojlambertVector) -> GeoprojlambertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojlambertVector::sub(self : GeoprojlambertVector, other : GeoprojlambertVector) -> GeoprojlambertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojlambertVector::scale(self : GeoprojlambertVector, s : Double) -> GeoprojlambertVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojlambertVector::dot(self : GeoprojlambertVector, other : GeoprojlambertVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojlambertVector::norm(self : GeoprojlambertVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojlambertVector::normalize(self : GeoprojlambertVector) -> GeoprojlambertVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojlambertVector::dist(self : GeoprojlambertVector, other : GeoprojlambertVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojlambertVector::to_string(self : GeoprojlambertVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojlambertFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_frame_make(size : Int) -> GeoprojlambertFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojlambertFrame::len(self : GeoprojlambertFrame) -> Int { self.size }

pub fn GeoprojlambertFrame::get(self : GeoprojlambertFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojlambertFrame::set(self : GeoprojlambertFrame, i : Int, v : Double) -> GeoprojlambertFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojlambertFrame::sum(self : GeoprojlambertFrame) -> Double { @_common.sum(self.data) }

pub fn GeoprojlambertFrame::mean(self : GeoprojlambertFrame) -> Double { @_common.mean(self.data) }

pub fn GeoprojlambertFrame::scale(self : GeoprojlambertFrame, f : Double) -> GeoprojlambertFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertFrame::add(self : GeoprojlambertFrame, other : GeoprojlambertFrame) -> GeoprojlambertFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojlambertFrame::copy(self : GeoprojlambertFrame) -> GeoprojlambertFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertFrame::fill(self : GeoprojlambertFrame, v : Double) -> GeoprojlambertFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertFrame::min(self : GeoprojlambertFrame) -> Double { @_common.min(self.data) }

pub fn GeoprojlambertFrame::max(self : GeoprojlambertFrame) -> Double { @_common.max(self.data) }

pub fn GeoprojlambertFrame::to_string(self : GeoprojlambertFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_table_make(size : Int) -> GeoprojlambertTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojlambertTable::len(self : GeoprojlambertTable) -> Int { self.size }

pub fn GeoprojlambertTable::get(self : GeoprojlambertTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojlambertTable::set(self : GeoprojlambertTable, i : Int, v : Double) -> GeoprojlambertTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojlambertTable::sum(self : GeoprojlambertTable) -> Double { @_common.sum(self.data) }

pub fn GeoprojlambertTable::mean(self : GeoprojlambertTable) -> Double { @_common.mean(self.data) }

pub fn GeoprojlambertTable::scale(self : GeoprojlambertTable, f : Double) -> GeoprojlambertTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertTable::add(self : GeoprojlambertTable, other : GeoprojlambertTable) -> GeoprojlambertTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojlambertTable::copy(self : GeoprojlambertTable) -> GeoprojlambertTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertTable::fill(self : GeoprojlambertTable, v : Double) -> GeoprojlambertTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertTable::min(self : GeoprojlambertTable) -> Double { @_common.min(self.data) }

pub fn GeoprojlambertTable::max(self : GeoprojlambertTable) -> Double { @_common.max(self.data) }

pub fn GeoprojlambertTable::to_string(self : GeoprojlambertTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_graphn_make(size : Int) -> GeoprojlambertGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojlambertGraphN::len(self : GeoprojlambertGraphN) -> Int { self.size }

pub fn GeoprojlambertGraphN::get(self : GeoprojlambertGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojlambertGraphN::set(self : GeoprojlambertGraphN, i : Int, v : Double) -> GeoprojlambertGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojlambertGraphN::sum(self : GeoprojlambertGraphN) -> Double { @_common.sum(self.data) }

pub fn GeoprojlambertGraphN::mean(self : GeoprojlambertGraphN) -> Double { @_common.mean(self.data) }

pub fn GeoprojlambertGraphN::scale(self : GeoprojlambertGraphN, f : Double) -> GeoprojlambertGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertGraphN::add(self : GeoprojlambertGraphN, other : GeoprojlambertGraphN) -> GeoprojlambertGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojlambertGraphN::copy(self : GeoprojlambertGraphN) -> GeoprojlambertGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertGraphN::fill(self : GeoprojlambertGraphN, v : Double) -> GeoprojlambertGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertGraphN::min(self : GeoprojlambertGraphN) -> Double { @_common.min(self.data) }

pub fn GeoprojlambertGraphN::max(self : GeoprojlambertGraphN) -> Double { @_common.max(self.data) }

pub fn GeoprojlambertGraphN::to_string(self : GeoprojlambertGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_node_make(size : Int) -> GeoprojlambertNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojlambertNode::len(self : GeoprojlambertNode) -> Int { self.size }

pub fn GeoprojlambertNode::get(self : GeoprojlambertNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojlambertNode::set(self : GeoprojlambertNode, i : Int, v : Double) -> GeoprojlambertNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojlambertNode::sum(self : GeoprojlambertNode) -> Double { @_common.sum(self.data) }

pub fn GeoprojlambertNode::mean(self : GeoprojlambertNode) -> Double { @_common.mean(self.data) }

pub fn GeoprojlambertNode::scale(self : GeoprojlambertNode, f : Double) -> GeoprojlambertNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertNode::add(self : GeoprojlambertNode, other : GeoprojlambertNode) -> GeoprojlambertNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojlambertNode::copy(self : GeoprojlambertNode) -> GeoprojlambertNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertNode::fill(self : GeoprojlambertNode, v : Double) -> GeoprojlambertNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertNode::min(self : GeoprojlambertNode) -> Double { @_common.min(self.data) }

pub fn GeoprojlambertNode::max(self : GeoprojlambertNode) -> Double { @_common.max(self.data) }

pub fn GeoprojlambertNode::to_string(self : GeoprojlambertNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_edge_make(size : Int) -> GeoprojlambertEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojlambertEdge::len(self : GeoprojlambertEdge) -> Int { self.size }

pub fn GeoprojlambertEdge::get(self : GeoprojlambertEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojlambertEdge::set(self : GeoprojlambertEdge, i : Int, v : Double) -> GeoprojlambertEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojlambertEdge::sum(self : GeoprojlambertEdge) -> Double { @_common.sum(self.data) }

pub fn GeoprojlambertEdge::mean(self : GeoprojlambertEdge) -> Double { @_common.mean(self.data) }

pub fn GeoprojlambertEdge::scale(self : GeoprojlambertEdge, f : Double) -> GeoprojlambertEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertEdge::add(self : GeoprojlambertEdge, other : GeoprojlambertEdge) -> GeoprojlambertEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojlambertEdge::copy(self : GeoprojlambertEdge) -> GeoprojlambertEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertEdge::fill(self : GeoprojlambertEdge, v : Double) -> GeoprojlambertEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertEdge::min(self : GeoprojlambertEdge) -> Double { @_common.min(self.data) }

pub fn GeoprojlambertEdge::max(self : GeoprojlambertEdge) -> Double { @_common.max(self.data) }

pub fn GeoprojlambertEdge::to_string(self : GeoprojlambertEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_path_make(size : Int) -> GeoprojlambertPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojlambertPath::len(self : GeoprojlambertPath) -> Int { self.size }

pub fn GeoprojlambertPath::get(self : GeoprojlambertPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojlambertPath::set(self : GeoprojlambertPath, i : Int, v : Double) -> GeoprojlambertPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojlambertPath::sum(self : GeoprojlambertPath) -> Double { @_common.sum(self.data) }

pub fn GeoprojlambertPath::mean(self : GeoprojlambertPath) -> Double { @_common.mean(self.data) }

pub fn GeoprojlambertPath::scale(self : GeoprojlambertPath, f : Double) -> GeoprojlambertPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertPath::add(self : GeoprojlambertPath, other : GeoprojlambertPath) -> GeoprojlambertPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojlambertPath::copy(self : GeoprojlambertPath) -> GeoprojlambertPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertPath::fill(self : GeoprojlambertPath, v : Double) -> GeoprojlambertPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertPath::min(self : GeoprojlambertPath) -> Double { @_common.min(self.data) }

pub fn GeoprojlambertPath::max(self : GeoprojlambertPath) -> Double { @_common.max(self.data) }

pub fn GeoprojlambertPath::to_string(self : GeoprojlambertPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_cluster_make(size : Int) -> GeoprojlambertCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojlambertCluster::len(self : GeoprojlambertCluster) -> Int { self.size }

pub fn GeoprojlambertCluster::get(self : GeoprojlambertCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojlambertCluster::set(self : GeoprojlambertCluster, i : Int, v : Double) -> GeoprojlambertCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojlambertCluster::sum(self : GeoprojlambertCluster) -> Double { @_common.sum(self.data) }

pub fn GeoprojlambertCluster::mean(self : GeoprojlambertCluster) -> Double { @_common.mean(self.data) }

pub fn GeoprojlambertCluster::scale(self : GeoprojlambertCluster, f : Double) -> GeoprojlambertCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertCluster::add(self : GeoprojlambertCluster, other : GeoprojlambertCluster) -> GeoprojlambertCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojlambertCluster::copy(self : GeoprojlambertCluster) -> GeoprojlambertCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertCluster::fill(self : GeoprojlambertCluster, v : Double) -> GeoprojlambertCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertCluster::min(self : GeoprojlambertCluster) -> Double { @_common.min(self.data) }

pub fn GeoprojlambertCluster::max(self : GeoprojlambertCluster) -> Double { @_common.max(self.data) }

pub fn GeoprojlambertCluster::to_string(self : GeoprojlambertCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_model_make(size : Int) -> GeoprojlambertModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojlambertModel::len(self : GeoprojlambertModel) -> Int { self.size }

pub fn GeoprojlambertModel::get(self : GeoprojlambertModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojlambertModel::set(self : GeoprojlambertModel, i : Int, v : Double) -> GeoprojlambertModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojlambertModel::sum(self : GeoprojlambertModel) -> Double { @_common.sum(self.data) }

pub fn GeoprojlambertModel::mean(self : GeoprojlambertModel) -> Double { @_common.mean(self.data) }

pub fn GeoprojlambertModel::scale(self : GeoprojlambertModel, f : Double) -> GeoprojlambertModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertModel::add(self : GeoprojlambertModel, other : GeoprojlambertModel) -> GeoprojlambertModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojlambertModel::copy(self : GeoprojlambertModel) -> GeoprojlambertModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertModel::fill(self : GeoprojlambertModel, v : Double) -> GeoprojlambertModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertModel::min(self : GeoprojlambertModel) -> Double { @_common.min(self.data) }

pub fn GeoprojlambertModel::max(self : GeoprojlambertModel) -> Double { @_common.max(self.data) }

pub fn GeoprojlambertModel::to_string(self : GeoprojlambertModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_layer_make(size : Int) -> GeoprojlambertLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojlambertLayer::len(self : GeoprojlambertLayer) -> Int { self.size }

pub fn GeoprojlambertLayer::get(self : GeoprojlambertLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojlambertLayer::set(self : GeoprojlambertLayer, i : Int, v : Double) -> GeoprojlambertLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojlambertLayer::sum(self : GeoprojlambertLayer) -> Double { @_common.sum(self.data) }

pub fn GeoprojlambertLayer::mean(self : GeoprojlambertLayer) -> Double { @_common.mean(self.data) }

pub fn GeoprojlambertLayer::scale(self : GeoprojlambertLayer, f : Double) -> GeoprojlambertLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertLayer::add(self : GeoprojlambertLayer, other : GeoprojlambertLayer) -> GeoprojlambertLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojlambertLayer::copy(self : GeoprojlambertLayer) -> GeoprojlambertLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertLayer::fill(self : GeoprojlambertLayer, v : Double) -> GeoprojlambertLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertLayer::min(self : GeoprojlambertLayer) -> Double { @_common.min(self.data) }

pub fn GeoprojlambertLayer::max(self : GeoprojlambertLayer) -> Double { @_common.max(self.data) }

pub fn GeoprojlambertLayer::to_string(self : GeoprojlambertLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_buffer_make(size : Int) -> GeoprojlambertBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojlambertBuffer::len(self : GeoprojlambertBuffer) -> Int { self.size }

pub fn GeoprojlambertBuffer::get(self : GeoprojlambertBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojlambertBuffer::set(self : GeoprojlambertBuffer, i : Int, v : Double) -> GeoprojlambertBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojlambertBuffer::sum(self : GeoprojlambertBuffer) -> Double { @_common.sum(self.data) }

pub fn GeoprojlambertBuffer::mean(self : GeoprojlambertBuffer) -> Double { @_common.mean(self.data) }

pub fn GeoprojlambertBuffer::scale(self : GeoprojlambertBuffer, f : Double) -> GeoprojlambertBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertBuffer::add(self : GeoprojlambertBuffer, other : GeoprojlambertBuffer) -> GeoprojlambertBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojlambertBuffer::copy(self : GeoprojlambertBuffer) -> GeoprojlambertBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertBuffer::fill(self : GeoprojlambertBuffer, v : Double) -> GeoprojlambertBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertBuffer::min(self : GeoprojlambertBuffer) -> Double { @_common.min(self.data) }

pub fn GeoprojlambertBuffer::max(self : GeoprojlambertBuffer) -> Double { @_common.max(self.data) }

pub fn GeoprojlambertBuffer::to_string(self : GeoprojlambertBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_cursor_make(size : Int) -> GeoprojlambertCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojlambertCursor::len(self : GeoprojlambertCursor) -> Int { self.size }

pub fn GeoprojlambertCursor::get(self : GeoprojlambertCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojlambertCursor::set(self : GeoprojlambertCursor, i : Int, v : Double) -> GeoprojlambertCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojlambertCursor::sum(self : GeoprojlambertCursor) -> Double { @_common.sum(self.data) }

pub fn GeoprojlambertCursor::mean(self : GeoprojlambertCursor) -> Double { @_common.mean(self.data) }

pub fn GeoprojlambertCursor::scale(self : GeoprojlambertCursor, f : Double) -> GeoprojlambertCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertCursor::add(self : GeoprojlambertCursor, other : GeoprojlambertCursor) -> GeoprojlambertCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojlambertCursor::copy(self : GeoprojlambertCursor) -> GeoprojlambertCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertCursor::fill(self : GeoprojlambertCursor, v : Double) -> GeoprojlambertCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertCursor::min(self : GeoprojlambertCursor) -> Double { @_common.min(self.data) }

pub fn GeoprojlambertCursor::max(self : GeoprojlambertCursor) -> Double { @_common.max(self.data) }

pub fn GeoprojlambertCursor::to_string(self : GeoprojlambertCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_view_make(size : Int) -> GeoprojlambertView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojlambertView::len(self : GeoprojlambertView) -> Int { self.size }

pub fn GeoprojlambertView::get(self : GeoprojlambertView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojlambertView::set(self : GeoprojlambertView, i : Int, v : Double) -> GeoprojlambertView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojlambertView::sum(self : GeoprojlambertView) -> Double { @_common.sum(self.data) }

pub fn GeoprojlambertView::mean(self : GeoprojlambertView) -> Double { @_common.mean(self.data) }

pub fn GeoprojlambertView::scale(self : GeoprojlambertView, f : Double) -> GeoprojlambertView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertView::add(self : GeoprojlambertView, other : GeoprojlambertView) -> GeoprojlambertView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojlambertView::copy(self : GeoprojlambertView) -> GeoprojlambertView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertView::fill(self : GeoprojlambertView, v : Double) -> GeoprojlambertView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertView::min(self : GeoprojlambertView) -> Double { @_common.min(self.data) }

pub fn GeoprojlambertView::max(self : GeoprojlambertView) -> Double { @_common.max(self.data) }

pub fn GeoprojlambertView::to_string(self : GeoprojlambertView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_range_make(size : Int) -> GeoprojlambertRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojlambertRange::len(self : GeoprojlambertRange) -> Int { self.size }

pub fn GeoprojlambertRange::get(self : GeoprojlambertRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojlambertRange::set(self : GeoprojlambertRange, i : Int, v : Double) -> GeoprojlambertRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojlambertRange::sum(self : GeoprojlambertRange) -> Double { @_common.sum(self.data) }

pub fn GeoprojlambertRange::mean(self : GeoprojlambertRange) -> Double { @_common.mean(self.data) }

pub fn GeoprojlambertRange::scale(self : GeoprojlambertRange, f : Double) -> GeoprojlambertRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertRange::add(self : GeoprojlambertRange, other : GeoprojlambertRange) -> GeoprojlambertRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojlambertRange::copy(self : GeoprojlambertRange) -> GeoprojlambertRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertRange::fill(self : GeoprojlambertRange, v : Double) -> GeoprojlambertRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertRange::min(self : GeoprojlambertRange) -> Double { @_common.min(self.data) }

pub fn GeoprojlambertRange::max(self : GeoprojlambertRange) -> Double { @_common.max(self.data) }

pub fn GeoprojlambertRange::to_string(self : GeoprojlambertRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_slice_make(size : Int) -> GeoprojlambertSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojlambertSlice::len(self : GeoprojlambertSlice) -> Int { self.size }

pub fn GeoprojlambertSlice::get(self : GeoprojlambertSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojlambertSlice::set(self : GeoprojlambertSlice, i : Int, v : Double) -> GeoprojlambertSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojlambertSlice::sum(self : GeoprojlambertSlice) -> Double { @_common.sum(self.data) }

pub fn GeoprojlambertSlice::mean(self : GeoprojlambertSlice) -> Double { @_common.mean(self.data) }

pub fn GeoprojlambertSlice::scale(self : GeoprojlambertSlice, f : Double) -> GeoprojlambertSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertSlice::add(self : GeoprojlambertSlice, other : GeoprojlambertSlice) -> GeoprojlambertSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojlambertSlice::copy(self : GeoprojlambertSlice) -> GeoprojlambertSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertSlice::fill(self : GeoprojlambertSlice, v : Double) -> GeoprojlambertSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojlambertSlice::min(self : GeoprojlambertSlice) -> Double { @_common.min(self.data) }

pub fn GeoprojlambertSlice::max(self : GeoprojlambertSlice) -> Double { @_common.max(self.data) }

pub fn GeoprojlambertSlice::to_string(self : GeoprojlambertSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

