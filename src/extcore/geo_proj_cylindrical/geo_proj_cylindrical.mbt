///===
/// extcore/geo_proj_cylindrical

pub(all) struct GeoprojcylindricalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_cylindrical_make_point(x : Double, y : Double) -> GeoprojcylindricalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_cylindrical_make_point3(x : Double, y : Double, z : Double) -> GeoprojcylindricalPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojcylindricalPoint::x(self : GeoprojcylindricalPoint) -> Double { self.x }

pub fn GeoprojcylindricalPoint::y(self : GeoprojcylindricalPoint) -> Double { self.y }

pub fn GeoprojcylindricalPoint::z(self : GeoprojcylindricalPoint) -> Double { self.z }

pub fn GeoprojcylindricalPoint::label(self : GeoprojcylindricalPoint) -> Int { self.label }

pub fn GeoprojcylindricalPoint::dist(self : GeoprojcylindricalPoint, other : GeoprojcylindricalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojcylindricalPoint::add(self : GeoprojcylindricalPoint, other : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojcylindricalPoint::sub(self : GeoprojcylindricalPoint, other : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojcylindricalPoint::scale(self : GeoprojcylindricalPoint, s : Double) -> GeoprojcylindricalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojcylindricalPoint::dot(self : GeoprojcylindricalPoint, other : GeoprojcylindricalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojcylindricalPoint::cross(self : GeoprojcylindricalPoint, other : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojcylindricalPoint::norm(self : GeoprojcylindricalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojcylindricalPoint::normalize(self : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojcylindricalPoint::negate(self : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojcylindricalPoint::mid(self : GeoprojcylindricalPoint, other : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojcylindricalPoint::lerp(self : GeoprojcylindricalPoint, other : GeoprojcylindricalPoint, t : Double) -> GeoprojcylindricalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojcylindricalPoint::to_string(self : GeoprojcylindricalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojcylindricalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_cylindrical_make_series(vals : Array[Double], name : String) -> GeoprojcylindricalSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojcylindricalSeries::len(self : GeoprojcylindricalSeries) -> Int { self.vals.length() }

pub fn GeoprojcylindricalSeries::sum(self : GeoprojcylindricalSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojcylindricalSeries::mean(self : GeoprojcylindricalSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojcylindricalSeries::min(self : GeoprojcylindricalSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojcylindricalSeries::max(self : GeoprojcylindricalSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojcylindricalSeries::range(self : GeoprojcylindricalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojcylindricalSeries::variance(self : GeoprojcylindricalSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojcylindricalSeries::std(self : GeoprojcylindricalSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojcylindricalSeries::median(self : GeoprojcylindricalSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojcylindricalSeries::scale(self : GeoprojcylindricalSeries, f : Double) -> GeoprojcylindricalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojcylindricalSeries::add(self : GeoprojcylindricalSeries, other : GeoprojcylindricalSeries) -> GeoprojcylindricalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojcylindricalSeries::sub(self : GeoprojcylindricalSeries, other : GeoprojcylindricalSeries) -> GeoprojcylindricalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojcylindricalSeries::normalize(self : GeoprojcylindricalSeries) -> GeoprojcylindricalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojcylindricalSeries::cumsum(self : GeoprojcylindricalSeries) -> GeoprojcylindricalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojcylindricalSeries::to_string(self : GeoprojcylindricalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojcylindricalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_cylindrical_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojcylindricalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_cylindrical_matrix_identity(n : Int) -> GeoprojcylindricalMatrix {
  let m = geo_proj_cylindrical_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojcylindricalMatrix::get(self : GeoprojcylindricalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojcylindricalMatrix::transpose(self : GeoprojcylindricalMatrix) -> GeoprojcylindricalMatrix {
  let result = geo_proj_cylindrical_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojcylindricalMatrix::add(self : GeoprojcylindricalMatrix, other : GeoprojcylindricalMatrix) -> GeoprojcylindricalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_cylindrical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojcylindricalMatrix::scale(self : GeoprojcylindricalMatrix, s : Double) -> GeoprojcylindricalMatrix {
  let result = geo_proj_cylindrical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojcylindricalMatrix::multiply(self : GeoprojcylindricalMatrix, other : GeoprojcylindricalMatrix) -> GeoprojcylindricalMatrix {
  if self.cols != other.rows { return geo_proj_cylindrical_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_cylindrical_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn GeoprojcylindricalMatrix::trace(self : GeoprojcylindricalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojcylindricalMatrix::det(self : GeoprojcylindricalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojcylindricalMatrix::norm(self : GeoprojcylindricalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojcylindricalMatrix::to_string(self : GeoprojcylindricalMatrix) -> String {
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

pub(all) struct GeoprojcylindricalVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_cylindrical_make_vector(comps : Array[Double]) -> GeoprojcylindricalVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_cylindrical_vector_zero(dim : Int) -> GeoprojcylindricalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojcylindricalVector::add(self : GeoprojcylindricalVector, other : GeoprojcylindricalVector) -> GeoprojcylindricalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojcylindricalVector::sub(self : GeoprojcylindricalVector, other : GeoprojcylindricalVector) -> GeoprojcylindricalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojcylindricalVector::scale(self : GeoprojcylindricalVector, s : Double) -> GeoprojcylindricalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojcylindricalVector::dot(self : GeoprojcylindricalVector, other : GeoprojcylindricalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojcylindricalVector::norm(self : GeoprojcylindricalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojcylindricalVector::normalize(self : GeoprojcylindricalVector) -> GeoprojcylindricalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojcylindricalVector::dist(self : GeoprojcylindricalVector, other : GeoprojcylindricalVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojcylindricalVector::to_string(self : GeoprojcylindricalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojcylindricalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_frame_make(size : Int) -> GeoprojcylindricalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojcylindricalFrame::len(self : GeoprojcylindricalFrame) -> Int { self.size }

pub fn GeoprojcylindricalFrame::get(self : GeoprojcylindricalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojcylindricalFrame::set(self : GeoprojcylindricalFrame, i : Int, v : Double) -> GeoprojcylindricalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalFrame::sum(self : GeoprojcylindricalFrame) -> Double { @_common.sum(self.data) }

pub fn GeoprojcylindricalFrame::mean(self : GeoprojcylindricalFrame) -> Double { @_common.mean(self.data) }

pub fn GeoprojcylindricalFrame::scale(self : GeoprojcylindricalFrame, f : Double) -> GeoprojcylindricalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalFrame::add(self : GeoprojcylindricalFrame, other : GeoprojcylindricalFrame) -> GeoprojcylindricalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojcylindricalFrame::copy(self : GeoprojcylindricalFrame) -> GeoprojcylindricalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalFrame::fill(self : GeoprojcylindricalFrame, v : Double) -> GeoprojcylindricalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalFrame::min(self : GeoprojcylindricalFrame) -> Double { @_common.min(self.data) }

pub fn GeoprojcylindricalFrame::max(self : GeoprojcylindricalFrame) -> Double { @_common.max(self.data) }

pub fn GeoprojcylindricalFrame::to_string(self : GeoprojcylindricalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_table_make(size : Int) -> GeoprojcylindricalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojcylindricalTable::len(self : GeoprojcylindricalTable) -> Int { self.size }

pub fn GeoprojcylindricalTable::get(self : GeoprojcylindricalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojcylindricalTable::set(self : GeoprojcylindricalTable, i : Int, v : Double) -> GeoprojcylindricalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalTable::sum(self : GeoprojcylindricalTable) -> Double { @_common.sum(self.data) }

pub fn GeoprojcylindricalTable::mean(self : GeoprojcylindricalTable) -> Double { @_common.mean(self.data) }

pub fn GeoprojcylindricalTable::scale(self : GeoprojcylindricalTable, f : Double) -> GeoprojcylindricalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalTable::add(self : GeoprojcylindricalTable, other : GeoprojcylindricalTable) -> GeoprojcylindricalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojcylindricalTable::copy(self : GeoprojcylindricalTable) -> GeoprojcylindricalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalTable::fill(self : GeoprojcylindricalTable, v : Double) -> GeoprojcylindricalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalTable::min(self : GeoprojcylindricalTable) -> Double { @_common.min(self.data) }

pub fn GeoprojcylindricalTable::max(self : GeoprojcylindricalTable) -> Double { @_common.max(self.data) }

pub fn GeoprojcylindricalTable::to_string(self : GeoprojcylindricalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_graphn_make(size : Int) -> GeoprojcylindricalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojcylindricalGraphN::len(self : GeoprojcylindricalGraphN) -> Int { self.size }

pub fn GeoprojcylindricalGraphN::get(self : GeoprojcylindricalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojcylindricalGraphN::set(self : GeoprojcylindricalGraphN, i : Int, v : Double) -> GeoprojcylindricalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalGraphN::sum(self : GeoprojcylindricalGraphN) -> Double { @_common.sum(self.data) }

pub fn GeoprojcylindricalGraphN::mean(self : GeoprojcylindricalGraphN) -> Double { @_common.mean(self.data) }

pub fn GeoprojcylindricalGraphN::scale(self : GeoprojcylindricalGraphN, f : Double) -> GeoprojcylindricalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalGraphN::add(self : GeoprojcylindricalGraphN, other : GeoprojcylindricalGraphN) -> GeoprojcylindricalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojcylindricalGraphN::copy(self : GeoprojcylindricalGraphN) -> GeoprojcylindricalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalGraphN::fill(self : GeoprojcylindricalGraphN, v : Double) -> GeoprojcylindricalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalGraphN::min(self : GeoprojcylindricalGraphN) -> Double { @_common.min(self.data) }

pub fn GeoprojcylindricalGraphN::max(self : GeoprojcylindricalGraphN) -> Double { @_common.max(self.data) }

pub fn GeoprojcylindricalGraphN::to_string(self : GeoprojcylindricalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_node_make(size : Int) -> GeoprojcylindricalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojcylindricalNode::len(self : GeoprojcylindricalNode) -> Int { self.size }

pub fn GeoprojcylindricalNode::get(self : GeoprojcylindricalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojcylindricalNode::set(self : GeoprojcylindricalNode, i : Int, v : Double) -> GeoprojcylindricalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalNode::sum(self : GeoprojcylindricalNode) -> Double { @_common.sum(self.data) }

pub fn GeoprojcylindricalNode::mean(self : GeoprojcylindricalNode) -> Double { @_common.mean(self.data) }

pub fn GeoprojcylindricalNode::scale(self : GeoprojcylindricalNode, f : Double) -> GeoprojcylindricalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalNode::add(self : GeoprojcylindricalNode, other : GeoprojcylindricalNode) -> GeoprojcylindricalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojcylindricalNode::copy(self : GeoprojcylindricalNode) -> GeoprojcylindricalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalNode::fill(self : GeoprojcylindricalNode, v : Double) -> GeoprojcylindricalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalNode::min(self : GeoprojcylindricalNode) -> Double { @_common.min(self.data) }

pub fn GeoprojcylindricalNode::max(self : GeoprojcylindricalNode) -> Double { @_common.max(self.data) }

pub fn GeoprojcylindricalNode::to_string(self : GeoprojcylindricalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_edge_make(size : Int) -> GeoprojcylindricalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojcylindricalEdge::len(self : GeoprojcylindricalEdge) -> Int { self.size }

pub fn GeoprojcylindricalEdge::get(self : GeoprojcylindricalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojcylindricalEdge::set(self : GeoprojcylindricalEdge, i : Int, v : Double) -> GeoprojcylindricalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalEdge::sum(self : GeoprojcylindricalEdge) -> Double { @_common.sum(self.data) }

pub fn GeoprojcylindricalEdge::mean(self : GeoprojcylindricalEdge) -> Double { @_common.mean(self.data) }

pub fn GeoprojcylindricalEdge::scale(self : GeoprojcylindricalEdge, f : Double) -> GeoprojcylindricalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalEdge::add(self : GeoprojcylindricalEdge, other : GeoprojcylindricalEdge) -> GeoprojcylindricalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojcylindricalEdge::copy(self : GeoprojcylindricalEdge) -> GeoprojcylindricalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalEdge::fill(self : GeoprojcylindricalEdge, v : Double) -> GeoprojcylindricalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalEdge::min(self : GeoprojcylindricalEdge) -> Double { @_common.min(self.data) }

pub fn GeoprojcylindricalEdge::max(self : GeoprojcylindricalEdge) -> Double { @_common.max(self.data) }

pub fn GeoprojcylindricalEdge::to_string(self : GeoprojcylindricalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_path_make(size : Int) -> GeoprojcylindricalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojcylindricalPath::len(self : GeoprojcylindricalPath) -> Int { self.size }

pub fn GeoprojcylindricalPath::get(self : GeoprojcylindricalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojcylindricalPath::set(self : GeoprojcylindricalPath, i : Int, v : Double) -> GeoprojcylindricalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalPath::sum(self : GeoprojcylindricalPath) -> Double { @_common.sum(self.data) }

pub fn GeoprojcylindricalPath::mean(self : GeoprojcylindricalPath) -> Double { @_common.mean(self.data) }

pub fn GeoprojcylindricalPath::scale(self : GeoprojcylindricalPath, f : Double) -> GeoprojcylindricalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalPath::add(self : GeoprojcylindricalPath, other : GeoprojcylindricalPath) -> GeoprojcylindricalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojcylindricalPath::copy(self : GeoprojcylindricalPath) -> GeoprojcylindricalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalPath::fill(self : GeoprojcylindricalPath, v : Double) -> GeoprojcylindricalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalPath::min(self : GeoprojcylindricalPath) -> Double { @_common.min(self.data) }

pub fn GeoprojcylindricalPath::max(self : GeoprojcylindricalPath) -> Double { @_common.max(self.data) }

pub fn GeoprojcylindricalPath::to_string(self : GeoprojcylindricalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_cluster_make(size : Int) -> GeoprojcylindricalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojcylindricalCluster::len(self : GeoprojcylindricalCluster) -> Int { self.size }

pub fn GeoprojcylindricalCluster::get(self : GeoprojcylindricalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojcylindricalCluster::set(self : GeoprojcylindricalCluster, i : Int, v : Double) -> GeoprojcylindricalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalCluster::sum(self : GeoprojcylindricalCluster) -> Double { @_common.sum(self.data) }

pub fn GeoprojcylindricalCluster::mean(self : GeoprojcylindricalCluster) -> Double { @_common.mean(self.data) }

pub fn GeoprojcylindricalCluster::scale(self : GeoprojcylindricalCluster, f : Double) -> GeoprojcylindricalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalCluster::add(self : GeoprojcylindricalCluster, other : GeoprojcylindricalCluster) -> GeoprojcylindricalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojcylindricalCluster::copy(self : GeoprojcylindricalCluster) -> GeoprojcylindricalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalCluster::fill(self : GeoprojcylindricalCluster, v : Double) -> GeoprojcylindricalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalCluster::min(self : GeoprojcylindricalCluster) -> Double { @_common.min(self.data) }

pub fn GeoprojcylindricalCluster::max(self : GeoprojcylindricalCluster) -> Double { @_common.max(self.data) }

pub fn GeoprojcylindricalCluster::to_string(self : GeoprojcylindricalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_model_make(size : Int) -> GeoprojcylindricalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojcylindricalModel::len(self : GeoprojcylindricalModel) -> Int { self.size }

pub fn GeoprojcylindricalModel::get(self : GeoprojcylindricalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojcylindricalModel::set(self : GeoprojcylindricalModel, i : Int, v : Double) -> GeoprojcylindricalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalModel::sum(self : GeoprojcylindricalModel) -> Double { @_common.sum(self.data) }

pub fn GeoprojcylindricalModel::mean(self : GeoprojcylindricalModel) -> Double { @_common.mean(self.data) }

pub fn GeoprojcylindricalModel::scale(self : GeoprojcylindricalModel, f : Double) -> GeoprojcylindricalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalModel::add(self : GeoprojcylindricalModel, other : GeoprojcylindricalModel) -> GeoprojcylindricalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojcylindricalModel::copy(self : GeoprojcylindricalModel) -> GeoprojcylindricalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalModel::fill(self : GeoprojcylindricalModel, v : Double) -> GeoprojcylindricalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalModel::min(self : GeoprojcylindricalModel) -> Double { @_common.min(self.data) }

pub fn GeoprojcylindricalModel::max(self : GeoprojcylindricalModel) -> Double { @_common.max(self.data) }

pub fn GeoprojcylindricalModel::to_string(self : GeoprojcylindricalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_layer_make(size : Int) -> GeoprojcylindricalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojcylindricalLayer::len(self : GeoprojcylindricalLayer) -> Int { self.size }

pub fn GeoprojcylindricalLayer::get(self : GeoprojcylindricalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojcylindricalLayer::set(self : GeoprojcylindricalLayer, i : Int, v : Double) -> GeoprojcylindricalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalLayer::sum(self : GeoprojcylindricalLayer) -> Double { @_common.sum(self.data) }

pub fn GeoprojcylindricalLayer::mean(self : GeoprojcylindricalLayer) -> Double { @_common.mean(self.data) }

pub fn GeoprojcylindricalLayer::scale(self : GeoprojcylindricalLayer, f : Double) -> GeoprojcylindricalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalLayer::add(self : GeoprojcylindricalLayer, other : GeoprojcylindricalLayer) -> GeoprojcylindricalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojcylindricalLayer::copy(self : GeoprojcylindricalLayer) -> GeoprojcylindricalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalLayer::fill(self : GeoprojcylindricalLayer, v : Double) -> GeoprojcylindricalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalLayer::min(self : GeoprojcylindricalLayer) -> Double { @_common.min(self.data) }

pub fn GeoprojcylindricalLayer::max(self : GeoprojcylindricalLayer) -> Double { @_common.max(self.data) }

pub fn GeoprojcylindricalLayer::to_string(self : GeoprojcylindricalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_buffer_make(size : Int) -> GeoprojcylindricalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojcylindricalBuffer::len(self : GeoprojcylindricalBuffer) -> Int { self.size }

pub fn GeoprojcylindricalBuffer::get(self : GeoprojcylindricalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojcylindricalBuffer::set(self : GeoprojcylindricalBuffer, i : Int, v : Double) -> GeoprojcylindricalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalBuffer::sum(self : GeoprojcylindricalBuffer) -> Double { @_common.sum(self.data) }

pub fn GeoprojcylindricalBuffer::mean(self : GeoprojcylindricalBuffer) -> Double { @_common.mean(self.data) }

pub fn GeoprojcylindricalBuffer::scale(self : GeoprojcylindricalBuffer, f : Double) -> GeoprojcylindricalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalBuffer::add(self : GeoprojcylindricalBuffer, other : GeoprojcylindricalBuffer) -> GeoprojcylindricalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojcylindricalBuffer::copy(self : GeoprojcylindricalBuffer) -> GeoprojcylindricalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalBuffer::fill(self : GeoprojcylindricalBuffer, v : Double) -> GeoprojcylindricalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalBuffer::min(self : GeoprojcylindricalBuffer) -> Double { @_common.min(self.data) }

pub fn GeoprojcylindricalBuffer::max(self : GeoprojcylindricalBuffer) -> Double { @_common.max(self.data) }

pub fn GeoprojcylindricalBuffer::to_string(self : GeoprojcylindricalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_cursor_make(size : Int) -> GeoprojcylindricalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojcylindricalCursor::len(self : GeoprojcylindricalCursor) -> Int { self.size }

pub fn GeoprojcylindricalCursor::get(self : GeoprojcylindricalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojcylindricalCursor::set(self : GeoprojcylindricalCursor, i : Int, v : Double) -> GeoprojcylindricalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalCursor::sum(self : GeoprojcylindricalCursor) -> Double { @_common.sum(self.data) }

pub fn GeoprojcylindricalCursor::mean(self : GeoprojcylindricalCursor) -> Double { @_common.mean(self.data) }

pub fn GeoprojcylindricalCursor::scale(self : GeoprojcylindricalCursor, f : Double) -> GeoprojcylindricalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalCursor::add(self : GeoprojcylindricalCursor, other : GeoprojcylindricalCursor) -> GeoprojcylindricalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojcylindricalCursor::copy(self : GeoprojcylindricalCursor) -> GeoprojcylindricalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalCursor::fill(self : GeoprojcylindricalCursor, v : Double) -> GeoprojcylindricalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalCursor::min(self : GeoprojcylindricalCursor) -> Double { @_common.min(self.data) }

pub fn GeoprojcylindricalCursor::max(self : GeoprojcylindricalCursor) -> Double { @_common.max(self.data) }

pub fn GeoprojcylindricalCursor::to_string(self : GeoprojcylindricalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_view_make(size : Int) -> GeoprojcylindricalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojcylindricalView::len(self : GeoprojcylindricalView) -> Int { self.size }

pub fn GeoprojcylindricalView::get(self : GeoprojcylindricalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojcylindricalView::set(self : GeoprojcylindricalView, i : Int, v : Double) -> GeoprojcylindricalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalView::sum(self : GeoprojcylindricalView) -> Double { @_common.sum(self.data) }

pub fn GeoprojcylindricalView::mean(self : GeoprojcylindricalView) -> Double { @_common.mean(self.data) }

pub fn GeoprojcylindricalView::scale(self : GeoprojcylindricalView, f : Double) -> GeoprojcylindricalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalView::add(self : GeoprojcylindricalView, other : GeoprojcylindricalView) -> GeoprojcylindricalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojcylindricalView::copy(self : GeoprojcylindricalView) -> GeoprojcylindricalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalView::fill(self : GeoprojcylindricalView, v : Double) -> GeoprojcylindricalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalView::min(self : GeoprojcylindricalView) -> Double { @_common.min(self.data) }

pub fn GeoprojcylindricalView::max(self : GeoprojcylindricalView) -> Double { @_common.max(self.data) }

pub fn GeoprojcylindricalView::to_string(self : GeoprojcylindricalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_range_make(size : Int) -> GeoprojcylindricalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojcylindricalRange::len(self : GeoprojcylindricalRange) -> Int { self.size }

pub fn GeoprojcylindricalRange::get(self : GeoprojcylindricalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojcylindricalRange::set(self : GeoprojcylindricalRange, i : Int, v : Double) -> GeoprojcylindricalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalRange::sum(self : GeoprojcylindricalRange) -> Double { @_common.sum(self.data) }

pub fn GeoprojcylindricalRange::mean(self : GeoprojcylindricalRange) -> Double { @_common.mean(self.data) }

pub fn GeoprojcylindricalRange::scale(self : GeoprojcylindricalRange, f : Double) -> GeoprojcylindricalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalRange::add(self : GeoprojcylindricalRange, other : GeoprojcylindricalRange) -> GeoprojcylindricalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojcylindricalRange::copy(self : GeoprojcylindricalRange) -> GeoprojcylindricalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalRange::fill(self : GeoprojcylindricalRange, v : Double) -> GeoprojcylindricalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalRange::min(self : GeoprojcylindricalRange) -> Double { @_common.min(self.data) }

pub fn GeoprojcylindricalRange::max(self : GeoprojcylindricalRange) -> Double { @_common.max(self.data) }

pub fn GeoprojcylindricalRange::to_string(self : GeoprojcylindricalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_slice_make(size : Int) -> GeoprojcylindricalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojcylindricalSlice::len(self : GeoprojcylindricalSlice) -> Int { self.size }

pub fn GeoprojcylindricalSlice::get(self : GeoprojcylindricalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojcylindricalSlice::set(self : GeoprojcylindricalSlice, i : Int, v : Double) -> GeoprojcylindricalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalSlice::sum(self : GeoprojcylindricalSlice) -> Double { @_common.sum(self.data) }

pub fn GeoprojcylindricalSlice::mean(self : GeoprojcylindricalSlice) -> Double { @_common.mean(self.data) }

pub fn GeoprojcylindricalSlice::scale(self : GeoprojcylindricalSlice, f : Double) -> GeoprojcylindricalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalSlice::add(self : GeoprojcylindricalSlice, other : GeoprojcylindricalSlice) -> GeoprojcylindricalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojcylindricalSlice::copy(self : GeoprojcylindricalSlice) -> GeoprojcylindricalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalSlice::fill(self : GeoprojcylindricalSlice, v : Double) -> GeoprojcylindricalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojcylindricalSlice::min(self : GeoprojcylindricalSlice) -> Double { @_common.min(self.data) }

pub fn GeoprojcylindricalSlice::max(self : GeoprojcylindricalSlice) -> Double { @_common.max(self.data) }

pub fn GeoprojcylindricalSlice::to_string(self : GeoprojcylindricalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

