///===
/// extcore/physics_em_magnetostatic

pub(all) struct PhysicsemmagnetostaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_magnetostatic_make_point(x : Double, y : Double) -> PhysicsemmagnetostaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_magnetostatic_make_point3(x : Double, y : Double, z : Double) -> PhysicsemmagnetostaticPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsemmagnetostaticPoint::x(self : PhysicsemmagnetostaticPoint) -> Double { self.x }

pub fn PhysicsemmagnetostaticPoint::y(self : PhysicsemmagnetostaticPoint) -> Double { self.y }

pub fn PhysicsemmagnetostaticPoint::z(self : PhysicsemmagnetostaticPoint) -> Double { self.z }

pub fn PhysicsemmagnetostaticPoint::label(self : PhysicsemmagnetostaticPoint) -> Int { self.label }

pub fn PhysicsemmagnetostaticPoint::dist(self : PhysicsemmagnetostaticPoint, other : PhysicsemmagnetostaticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsemmagnetostaticPoint::add(self : PhysicsemmagnetostaticPoint, other : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsemmagnetostaticPoint::sub(self : PhysicsemmagnetostaticPoint, other : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsemmagnetostaticPoint::scale(self : PhysicsemmagnetostaticPoint, s : Double) -> PhysicsemmagnetostaticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsemmagnetostaticPoint::dot(self : PhysicsemmagnetostaticPoint, other : PhysicsemmagnetostaticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsemmagnetostaticPoint::cross(self : PhysicsemmagnetostaticPoint, other : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsemmagnetostaticPoint::norm(self : PhysicsemmagnetostaticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsemmagnetostaticPoint::normalize(self : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemmagnetostaticPoint::negate(self : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsemmagnetostaticPoint::mid(self : PhysicsemmagnetostaticPoint, other : PhysicsemmagnetostaticPoint) -> PhysicsemmagnetostaticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsemmagnetostaticPoint::lerp(self : PhysicsemmagnetostaticPoint, other : PhysicsemmagnetostaticPoint, t : Double) -> PhysicsemmagnetostaticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsemmagnetostaticPoint::to_string(self : PhysicsemmagnetostaticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_magnetostatic_make_series(vals : Array[Double], name : String) -> PhysicsemmagnetostaticSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsemmagnetostaticSeries::len(self : PhysicsemmagnetostaticSeries) -> Int { self.vals.length() }

pub fn PhysicsemmagnetostaticSeries::sum(self : PhysicsemmagnetostaticSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsemmagnetostaticSeries::mean(self : PhysicsemmagnetostaticSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsemmagnetostaticSeries::min(self : PhysicsemmagnetostaticSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsemmagnetostaticSeries::max(self : PhysicsemmagnetostaticSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsemmagnetostaticSeries::range(self : PhysicsemmagnetostaticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsemmagnetostaticSeries::variance(self : PhysicsemmagnetostaticSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsemmagnetostaticSeries::std(self : PhysicsemmagnetostaticSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsemmagnetostaticSeries::median(self : PhysicsemmagnetostaticSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsemmagnetostaticSeries::scale(self : PhysicsemmagnetostaticSeries, f : Double) -> PhysicsemmagnetostaticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsemmagnetostaticSeries::add(self : PhysicsemmagnetostaticSeries, other : PhysicsemmagnetostaticSeries) -> PhysicsemmagnetostaticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsemmagnetostaticSeries::sub(self : PhysicsemmagnetostaticSeries, other : PhysicsemmagnetostaticSeries) -> PhysicsemmagnetostaticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsemmagnetostaticSeries::normalize(self : PhysicsemmagnetostaticSeries) -> PhysicsemmagnetostaticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsemmagnetostaticSeries::cumsum(self : PhysicsemmagnetostaticSeries) -> PhysicsemmagnetostaticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsemmagnetostaticSeries::to_string(self : PhysicsemmagnetostaticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemmagnetostaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_magnetostatic_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemmagnetostaticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_magnetostatic_matrix_identity(n : Int) -> PhysicsemmagnetostaticMatrix {
  let m = physics_em_magnetostatic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsemmagnetostaticMatrix::get(self : PhysicsemmagnetostaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsemmagnetostaticMatrix::transpose(self : PhysicsemmagnetostaticMatrix) -> PhysicsemmagnetostaticMatrix {
  let result = physics_em_magnetostatic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsemmagnetostaticMatrix::add(self : PhysicsemmagnetostaticMatrix, other : PhysicsemmagnetostaticMatrix) -> PhysicsemmagnetostaticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_em_magnetostatic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsemmagnetostaticMatrix::scale(self : PhysicsemmagnetostaticMatrix, s : Double) -> PhysicsemmagnetostaticMatrix {
  let result = physics_em_magnetostatic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsemmagnetostaticMatrix::multiply(self : PhysicsemmagnetostaticMatrix, other : PhysicsemmagnetostaticMatrix) -> PhysicsemmagnetostaticMatrix {
  if self.cols != other.rows { return physics_em_magnetostatic_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_em_magnetostatic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn PhysicsemmagnetostaticMatrix::trace(self : PhysicsemmagnetostaticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsemmagnetostaticMatrix::det(self : PhysicsemmagnetostaticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsemmagnetostaticMatrix::norm(self : PhysicsemmagnetostaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsemmagnetostaticMatrix::to_string(self : PhysicsemmagnetostaticMatrix) -> String {
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

pub(all) struct PhysicsemmagnetostaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_magnetostatic_make_vector(comps : Array[Double]) -> PhysicsemmagnetostaticVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_magnetostatic_vector_zero(dim : Int) -> PhysicsemmagnetostaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsemmagnetostaticVector::add(self : PhysicsemmagnetostaticVector, other : PhysicsemmagnetostaticVector) -> PhysicsemmagnetostaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemmagnetostaticVector::sub(self : PhysicsemmagnetostaticVector, other : PhysicsemmagnetostaticVector) -> PhysicsemmagnetostaticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemmagnetostaticVector::scale(self : PhysicsemmagnetostaticVector, s : Double) -> PhysicsemmagnetostaticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsemmagnetostaticVector::dot(self : PhysicsemmagnetostaticVector, other : PhysicsemmagnetostaticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsemmagnetostaticVector::norm(self : PhysicsemmagnetostaticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsemmagnetostaticVector::normalize(self : PhysicsemmagnetostaticVector) -> PhysicsemmagnetostaticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemmagnetostaticVector::dist(self : PhysicsemmagnetostaticVector, other : PhysicsemmagnetostaticVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsemmagnetostaticVector::to_string(self : PhysicsemmagnetostaticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemmagnetostaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_frame_make(size : Int) -> PhysicsemmagnetostaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmagnetostaticFrame::len(self : PhysicsemmagnetostaticFrame) -> Int { self.size }

pub fn PhysicsemmagnetostaticFrame::get(self : PhysicsemmagnetostaticFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmagnetostaticFrame::set(self : PhysicsemmagnetostaticFrame, i : Int, v : Double) -> PhysicsemmagnetostaticFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticFrame::sum(self : PhysicsemmagnetostaticFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmagnetostaticFrame::mean(self : PhysicsemmagnetostaticFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmagnetostaticFrame::scale(self : PhysicsemmagnetostaticFrame, f : Double) -> PhysicsemmagnetostaticFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticFrame::add(self : PhysicsemmagnetostaticFrame, other : PhysicsemmagnetostaticFrame) -> PhysicsemmagnetostaticFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmagnetostaticFrame::copy(self : PhysicsemmagnetostaticFrame) -> PhysicsemmagnetostaticFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticFrame::fill(self : PhysicsemmagnetostaticFrame, v : Double) -> PhysicsemmagnetostaticFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticFrame::min(self : PhysicsemmagnetostaticFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsemmagnetostaticFrame::max(self : PhysicsemmagnetostaticFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsemmagnetostaticFrame::to_string(self : PhysicsemmagnetostaticFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_table_make(size : Int) -> PhysicsemmagnetostaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmagnetostaticTable::len(self : PhysicsemmagnetostaticTable) -> Int { self.size }

pub fn PhysicsemmagnetostaticTable::get(self : PhysicsemmagnetostaticTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmagnetostaticTable::set(self : PhysicsemmagnetostaticTable, i : Int, v : Double) -> PhysicsemmagnetostaticTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticTable::sum(self : PhysicsemmagnetostaticTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmagnetostaticTable::mean(self : PhysicsemmagnetostaticTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmagnetostaticTable::scale(self : PhysicsemmagnetostaticTable, f : Double) -> PhysicsemmagnetostaticTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticTable::add(self : PhysicsemmagnetostaticTable, other : PhysicsemmagnetostaticTable) -> PhysicsemmagnetostaticTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmagnetostaticTable::copy(self : PhysicsemmagnetostaticTable) -> PhysicsemmagnetostaticTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticTable::fill(self : PhysicsemmagnetostaticTable, v : Double) -> PhysicsemmagnetostaticTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticTable::min(self : PhysicsemmagnetostaticTable) -> Double { @_common.min(self.data) }

pub fn PhysicsemmagnetostaticTable::max(self : PhysicsemmagnetostaticTable) -> Double { @_common.max(self.data) }

pub fn PhysicsemmagnetostaticTable::to_string(self : PhysicsemmagnetostaticTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_graphn_make(size : Int) -> PhysicsemmagnetostaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmagnetostaticGraphN::len(self : PhysicsemmagnetostaticGraphN) -> Int { self.size }

pub fn PhysicsemmagnetostaticGraphN::get(self : PhysicsemmagnetostaticGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmagnetostaticGraphN::set(self : PhysicsemmagnetostaticGraphN, i : Int, v : Double) -> PhysicsemmagnetostaticGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticGraphN::sum(self : PhysicsemmagnetostaticGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmagnetostaticGraphN::mean(self : PhysicsemmagnetostaticGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmagnetostaticGraphN::scale(self : PhysicsemmagnetostaticGraphN, f : Double) -> PhysicsemmagnetostaticGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticGraphN::add(self : PhysicsemmagnetostaticGraphN, other : PhysicsemmagnetostaticGraphN) -> PhysicsemmagnetostaticGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmagnetostaticGraphN::copy(self : PhysicsemmagnetostaticGraphN) -> PhysicsemmagnetostaticGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticGraphN::fill(self : PhysicsemmagnetostaticGraphN, v : Double) -> PhysicsemmagnetostaticGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticGraphN::min(self : PhysicsemmagnetostaticGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsemmagnetostaticGraphN::max(self : PhysicsemmagnetostaticGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsemmagnetostaticGraphN::to_string(self : PhysicsemmagnetostaticGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_node_make(size : Int) -> PhysicsemmagnetostaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmagnetostaticNode::len(self : PhysicsemmagnetostaticNode) -> Int { self.size }

pub fn PhysicsemmagnetostaticNode::get(self : PhysicsemmagnetostaticNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmagnetostaticNode::set(self : PhysicsemmagnetostaticNode, i : Int, v : Double) -> PhysicsemmagnetostaticNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticNode::sum(self : PhysicsemmagnetostaticNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmagnetostaticNode::mean(self : PhysicsemmagnetostaticNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmagnetostaticNode::scale(self : PhysicsemmagnetostaticNode, f : Double) -> PhysicsemmagnetostaticNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticNode::add(self : PhysicsemmagnetostaticNode, other : PhysicsemmagnetostaticNode) -> PhysicsemmagnetostaticNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmagnetostaticNode::copy(self : PhysicsemmagnetostaticNode) -> PhysicsemmagnetostaticNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticNode::fill(self : PhysicsemmagnetostaticNode, v : Double) -> PhysicsemmagnetostaticNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticNode::min(self : PhysicsemmagnetostaticNode) -> Double { @_common.min(self.data) }

pub fn PhysicsemmagnetostaticNode::max(self : PhysicsemmagnetostaticNode) -> Double { @_common.max(self.data) }

pub fn PhysicsemmagnetostaticNode::to_string(self : PhysicsemmagnetostaticNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_edge_make(size : Int) -> PhysicsemmagnetostaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmagnetostaticEdge::len(self : PhysicsemmagnetostaticEdge) -> Int { self.size }

pub fn PhysicsemmagnetostaticEdge::get(self : PhysicsemmagnetostaticEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmagnetostaticEdge::set(self : PhysicsemmagnetostaticEdge, i : Int, v : Double) -> PhysicsemmagnetostaticEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticEdge::sum(self : PhysicsemmagnetostaticEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmagnetostaticEdge::mean(self : PhysicsemmagnetostaticEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmagnetostaticEdge::scale(self : PhysicsemmagnetostaticEdge, f : Double) -> PhysicsemmagnetostaticEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticEdge::add(self : PhysicsemmagnetostaticEdge, other : PhysicsemmagnetostaticEdge) -> PhysicsemmagnetostaticEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmagnetostaticEdge::copy(self : PhysicsemmagnetostaticEdge) -> PhysicsemmagnetostaticEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticEdge::fill(self : PhysicsemmagnetostaticEdge, v : Double) -> PhysicsemmagnetostaticEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticEdge::min(self : PhysicsemmagnetostaticEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsemmagnetostaticEdge::max(self : PhysicsemmagnetostaticEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsemmagnetostaticEdge::to_string(self : PhysicsemmagnetostaticEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_path_make(size : Int) -> PhysicsemmagnetostaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmagnetostaticPath::len(self : PhysicsemmagnetostaticPath) -> Int { self.size }

pub fn PhysicsemmagnetostaticPath::get(self : PhysicsemmagnetostaticPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmagnetostaticPath::set(self : PhysicsemmagnetostaticPath, i : Int, v : Double) -> PhysicsemmagnetostaticPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticPath::sum(self : PhysicsemmagnetostaticPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmagnetostaticPath::mean(self : PhysicsemmagnetostaticPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmagnetostaticPath::scale(self : PhysicsemmagnetostaticPath, f : Double) -> PhysicsemmagnetostaticPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticPath::add(self : PhysicsemmagnetostaticPath, other : PhysicsemmagnetostaticPath) -> PhysicsemmagnetostaticPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmagnetostaticPath::copy(self : PhysicsemmagnetostaticPath) -> PhysicsemmagnetostaticPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticPath::fill(self : PhysicsemmagnetostaticPath, v : Double) -> PhysicsemmagnetostaticPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticPath::min(self : PhysicsemmagnetostaticPath) -> Double { @_common.min(self.data) }

pub fn PhysicsemmagnetostaticPath::max(self : PhysicsemmagnetostaticPath) -> Double { @_common.max(self.data) }

pub fn PhysicsemmagnetostaticPath::to_string(self : PhysicsemmagnetostaticPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_cluster_make(size : Int) -> PhysicsemmagnetostaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmagnetostaticCluster::len(self : PhysicsemmagnetostaticCluster) -> Int { self.size }

pub fn PhysicsemmagnetostaticCluster::get(self : PhysicsemmagnetostaticCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmagnetostaticCluster::set(self : PhysicsemmagnetostaticCluster, i : Int, v : Double) -> PhysicsemmagnetostaticCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticCluster::sum(self : PhysicsemmagnetostaticCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmagnetostaticCluster::mean(self : PhysicsemmagnetostaticCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmagnetostaticCluster::scale(self : PhysicsemmagnetostaticCluster, f : Double) -> PhysicsemmagnetostaticCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticCluster::add(self : PhysicsemmagnetostaticCluster, other : PhysicsemmagnetostaticCluster) -> PhysicsemmagnetostaticCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmagnetostaticCluster::copy(self : PhysicsemmagnetostaticCluster) -> PhysicsemmagnetostaticCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticCluster::fill(self : PhysicsemmagnetostaticCluster, v : Double) -> PhysicsemmagnetostaticCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticCluster::min(self : PhysicsemmagnetostaticCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsemmagnetostaticCluster::max(self : PhysicsemmagnetostaticCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsemmagnetostaticCluster::to_string(self : PhysicsemmagnetostaticCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_model_make(size : Int) -> PhysicsemmagnetostaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmagnetostaticModel::len(self : PhysicsemmagnetostaticModel) -> Int { self.size }

pub fn PhysicsemmagnetostaticModel::get(self : PhysicsemmagnetostaticModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmagnetostaticModel::set(self : PhysicsemmagnetostaticModel, i : Int, v : Double) -> PhysicsemmagnetostaticModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticModel::sum(self : PhysicsemmagnetostaticModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmagnetostaticModel::mean(self : PhysicsemmagnetostaticModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmagnetostaticModel::scale(self : PhysicsemmagnetostaticModel, f : Double) -> PhysicsemmagnetostaticModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticModel::add(self : PhysicsemmagnetostaticModel, other : PhysicsemmagnetostaticModel) -> PhysicsemmagnetostaticModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmagnetostaticModel::copy(self : PhysicsemmagnetostaticModel) -> PhysicsemmagnetostaticModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticModel::fill(self : PhysicsemmagnetostaticModel, v : Double) -> PhysicsemmagnetostaticModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticModel::min(self : PhysicsemmagnetostaticModel) -> Double { @_common.min(self.data) }

pub fn PhysicsemmagnetostaticModel::max(self : PhysicsemmagnetostaticModel) -> Double { @_common.max(self.data) }

pub fn PhysicsemmagnetostaticModel::to_string(self : PhysicsemmagnetostaticModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_layer_make(size : Int) -> PhysicsemmagnetostaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmagnetostaticLayer::len(self : PhysicsemmagnetostaticLayer) -> Int { self.size }

pub fn PhysicsemmagnetostaticLayer::get(self : PhysicsemmagnetostaticLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmagnetostaticLayer::set(self : PhysicsemmagnetostaticLayer, i : Int, v : Double) -> PhysicsemmagnetostaticLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticLayer::sum(self : PhysicsemmagnetostaticLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmagnetostaticLayer::mean(self : PhysicsemmagnetostaticLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmagnetostaticLayer::scale(self : PhysicsemmagnetostaticLayer, f : Double) -> PhysicsemmagnetostaticLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticLayer::add(self : PhysicsemmagnetostaticLayer, other : PhysicsemmagnetostaticLayer) -> PhysicsemmagnetostaticLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmagnetostaticLayer::copy(self : PhysicsemmagnetostaticLayer) -> PhysicsemmagnetostaticLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticLayer::fill(self : PhysicsemmagnetostaticLayer, v : Double) -> PhysicsemmagnetostaticLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticLayer::min(self : PhysicsemmagnetostaticLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsemmagnetostaticLayer::max(self : PhysicsemmagnetostaticLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsemmagnetostaticLayer::to_string(self : PhysicsemmagnetostaticLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_buffer_make(size : Int) -> PhysicsemmagnetostaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmagnetostaticBuffer::len(self : PhysicsemmagnetostaticBuffer) -> Int { self.size }

pub fn PhysicsemmagnetostaticBuffer::get(self : PhysicsemmagnetostaticBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmagnetostaticBuffer::set(self : PhysicsemmagnetostaticBuffer, i : Int, v : Double) -> PhysicsemmagnetostaticBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticBuffer::sum(self : PhysicsemmagnetostaticBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmagnetostaticBuffer::mean(self : PhysicsemmagnetostaticBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmagnetostaticBuffer::scale(self : PhysicsemmagnetostaticBuffer, f : Double) -> PhysicsemmagnetostaticBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticBuffer::add(self : PhysicsemmagnetostaticBuffer, other : PhysicsemmagnetostaticBuffer) -> PhysicsemmagnetostaticBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmagnetostaticBuffer::copy(self : PhysicsemmagnetostaticBuffer) -> PhysicsemmagnetostaticBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticBuffer::fill(self : PhysicsemmagnetostaticBuffer, v : Double) -> PhysicsemmagnetostaticBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticBuffer::min(self : PhysicsemmagnetostaticBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsemmagnetostaticBuffer::max(self : PhysicsemmagnetostaticBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsemmagnetostaticBuffer::to_string(self : PhysicsemmagnetostaticBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_cursor_make(size : Int) -> PhysicsemmagnetostaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmagnetostaticCursor::len(self : PhysicsemmagnetostaticCursor) -> Int { self.size }

pub fn PhysicsemmagnetostaticCursor::get(self : PhysicsemmagnetostaticCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmagnetostaticCursor::set(self : PhysicsemmagnetostaticCursor, i : Int, v : Double) -> PhysicsemmagnetostaticCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticCursor::sum(self : PhysicsemmagnetostaticCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmagnetostaticCursor::mean(self : PhysicsemmagnetostaticCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmagnetostaticCursor::scale(self : PhysicsemmagnetostaticCursor, f : Double) -> PhysicsemmagnetostaticCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticCursor::add(self : PhysicsemmagnetostaticCursor, other : PhysicsemmagnetostaticCursor) -> PhysicsemmagnetostaticCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmagnetostaticCursor::copy(self : PhysicsemmagnetostaticCursor) -> PhysicsemmagnetostaticCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticCursor::fill(self : PhysicsemmagnetostaticCursor, v : Double) -> PhysicsemmagnetostaticCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticCursor::min(self : PhysicsemmagnetostaticCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsemmagnetostaticCursor::max(self : PhysicsemmagnetostaticCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsemmagnetostaticCursor::to_string(self : PhysicsemmagnetostaticCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_view_make(size : Int) -> PhysicsemmagnetostaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmagnetostaticView::len(self : PhysicsemmagnetostaticView) -> Int { self.size }

pub fn PhysicsemmagnetostaticView::get(self : PhysicsemmagnetostaticView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmagnetostaticView::set(self : PhysicsemmagnetostaticView, i : Int, v : Double) -> PhysicsemmagnetostaticView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticView::sum(self : PhysicsemmagnetostaticView) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmagnetostaticView::mean(self : PhysicsemmagnetostaticView) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmagnetostaticView::scale(self : PhysicsemmagnetostaticView, f : Double) -> PhysicsemmagnetostaticView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticView::add(self : PhysicsemmagnetostaticView, other : PhysicsemmagnetostaticView) -> PhysicsemmagnetostaticView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmagnetostaticView::copy(self : PhysicsemmagnetostaticView) -> PhysicsemmagnetostaticView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticView::fill(self : PhysicsemmagnetostaticView, v : Double) -> PhysicsemmagnetostaticView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticView::min(self : PhysicsemmagnetostaticView) -> Double { @_common.min(self.data) }

pub fn PhysicsemmagnetostaticView::max(self : PhysicsemmagnetostaticView) -> Double { @_common.max(self.data) }

pub fn PhysicsemmagnetostaticView::to_string(self : PhysicsemmagnetostaticView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_range_make(size : Int) -> PhysicsemmagnetostaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmagnetostaticRange::len(self : PhysicsemmagnetostaticRange) -> Int { self.size }

pub fn PhysicsemmagnetostaticRange::get(self : PhysicsemmagnetostaticRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmagnetostaticRange::set(self : PhysicsemmagnetostaticRange, i : Int, v : Double) -> PhysicsemmagnetostaticRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticRange::sum(self : PhysicsemmagnetostaticRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmagnetostaticRange::mean(self : PhysicsemmagnetostaticRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmagnetostaticRange::scale(self : PhysicsemmagnetostaticRange, f : Double) -> PhysicsemmagnetostaticRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticRange::add(self : PhysicsemmagnetostaticRange, other : PhysicsemmagnetostaticRange) -> PhysicsemmagnetostaticRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmagnetostaticRange::copy(self : PhysicsemmagnetostaticRange) -> PhysicsemmagnetostaticRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticRange::fill(self : PhysicsemmagnetostaticRange, v : Double) -> PhysicsemmagnetostaticRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticRange::min(self : PhysicsemmagnetostaticRange) -> Double { @_common.min(self.data) }

pub fn PhysicsemmagnetostaticRange::max(self : PhysicsemmagnetostaticRange) -> Double { @_common.max(self.data) }

pub fn PhysicsemmagnetostaticRange::to_string(self : PhysicsemmagnetostaticRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsemmagnetostaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_magnetostatic_slice_make(size : Int) -> PhysicsemmagnetostaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsemmagnetostaticSlice::len(self : PhysicsemmagnetostaticSlice) -> Int { self.size }

pub fn PhysicsemmagnetostaticSlice::get(self : PhysicsemmagnetostaticSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsemmagnetostaticSlice::set(self : PhysicsemmagnetostaticSlice, i : Int, v : Double) -> PhysicsemmagnetostaticSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticSlice::sum(self : PhysicsemmagnetostaticSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsemmagnetostaticSlice::mean(self : PhysicsemmagnetostaticSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsemmagnetostaticSlice::scale(self : PhysicsemmagnetostaticSlice, f : Double) -> PhysicsemmagnetostaticSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticSlice::add(self : PhysicsemmagnetostaticSlice, other : PhysicsemmagnetostaticSlice) -> PhysicsemmagnetostaticSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsemmagnetostaticSlice::copy(self : PhysicsemmagnetostaticSlice) -> PhysicsemmagnetostaticSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticSlice::fill(self : PhysicsemmagnetostaticSlice, v : Double) -> PhysicsemmagnetostaticSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsemmagnetostaticSlice::min(self : PhysicsemmagnetostaticSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsemmagnetostaticSlice::max(self : PhysicsemmagnetostaticSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsemmagnetostaticSlice::to_string(self : PhysicsemmagnetostaticSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

