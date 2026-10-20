///===
/// extcore/db_index_brin

pub(all) struct DbindexbrinPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_brin_make_point(x : Double, y : Double) -> DbindexbrinPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_brin_make_point3(x : Double, y : Double, z : Double) -> DbindexbrinPoint {
  { x, y, z, label: 0 }
}

pub fn DbindexbrinPoint::x(self : DbindexbrinPoint) -> Double { self.x }

pub fn DbindexbrinPoint::y(self : DbindexbrinPoint) -> Double { self.y }

pub fn DbindexbrinPoint::z(self : DbindexbrinPoint) -> Double { self.z }

pub fn DbindexbrinPoint::label(self : DbindexbrinPoint) -> Int { self.label }

pub fn DbindexbrinPoint::dist(self : DbindexbrinPoint, other : DbindexbrinPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbindexbrinPoint::add(self : DbindexbrinPoint, other : DbindexbrinPoint) -> DbindexbrinPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbindexbrinPoint::sub(self : DbindexbrinPoint, other : DbindexbrinPoint) -> DbindexbrinPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbindexbrinPoint::scale(self : DbindexbrinPoint, s : Double) -> DbindexbrinPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbindexbrinPoint::dot(self : DbindexbrinPoint, other : DbindexbrinPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbindexbrinPoint::cross(self : DbindexbrinPoint, other : DbindexbrinPoint) -> DbindexbrinPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbindexbrinPoint::norm(self : DbindexbrinPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbindexbrinPoint::normalize(self : DbindexbrinPoint) -> DbindexbrinPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexbrinPoint::negate(self : DbindexbrinPoint) -> DbindexbrinPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbindexbrinPoint::mid(self : DbindexbrinPoint, other : DbindexbrinPoint) -> DbindexbrinPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbindexbrinPoint::lerp(self : DbindexbrinPoint, other : DbindexbrinPoint, t : Double) -> DbindexbrinPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbindexbrinPoint::to_string(self : DbindexbrinPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbindexbrinSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_brin_make_series(vals : Array[Double], name : String) -> DbindexbrinSeries {
  { vals, name, meta: 0 }
}

pub fn DbindexbrinSeries::len(self : DbindexbrinSeries) -> Int { self.vals.length() }

pub fn DbindexbrinSeries::sum(self : DbindexbrinSeries) -> Double { @_common.sum(self.vals) }

pub fn DbindexbrinSeries::mean(self : DbindexbrinSeries) -> Double { @_common.mean(self.vals) }

pub fn DbindexbrinSeries::min(self : DbindexbrinSeries) -> Double { @_common.min(self.vals) }

pub fn DbindexbrinSeries::max(self : DbindexbrinSeries) -> Double { @_common.max(self.vals) }

pub fn DbindexbrinSeries::range(self : DbindexbrinSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbindexbrinSeries::variance(self : DbindexbrinSeries) -> Double { @_common.variance(self.vals) }

pub fn DbindexbrinSeries::std(self : DbindexbrinSeries) -> Double { @_common.std(self.vals) }

pub fn DbindexbrinSeries::median(self : DbindexbrinSeries) -> Double { @_common.median(self.vals) }

pub fn DbindexbrinSeries::scale(self : DbindexbrinSeries, f : Double) -> DbindexbrinSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbindexbrinSeries::add(self : DbindexbrinSeries, other : DbindexbrinSeries) -> DbindexbrinSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbindexbrinSeries::sub(self : DbindexbrinSeries, other : DbindexbrinSeries) -> DbindexbrinSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbindexbrinSeries::normalize(self : DbindexbrinSeries) -> DbindexbrinSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbindexbrinSeries::cumsum(self : DbindexbrinSeries) -> DbindexbrinSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbindexbrinSeries::to_string(self : DbindexbrinSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexbrinMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_brin_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexbrinMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_brin_matrix_identity(n : Int) -> DbindexbrinMatrix {
  let m = db_index_brin_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbindexbrinMatrix::get(self : DbindexbrinMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbindexbrinMatrix::transpose(self : DbindexbrinMatrix) -> DbindexbrinMatrix {
  let result = db_index_brin_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbindexbrinMatrix::add(self : DbindexbrinMatrix, other : DbindexbrinMatrix) -> DbindexbrinMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_index_brin_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbindexbrinMatrix::scale(self : DbindexbrinMatrix, s : Double) -> DbindexbrinMatrix {
  let result = db_index_brin_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbindexbrinMatrix::multiply(self : DbindexbrinMatrix, other : DbindexbrinMatrix) -> DbindexbrinMatrix {
  if self.cols != other.rows { return db_index_brin_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_index_brin_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DbindexbrinMatrix::trace(self : DbindexbrinMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbindexbrinMatrix::det(self : DbindexbrinMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbindexbrinMatrix::norm(self : DbindexbrinMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbindexbrinMatrix::to_string(self : DbindexbrinMatrix) -> String {
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

pub(all) struct DbindexbrinVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_brin_make_vector(comps : Array[Double]) -> DbindexbrinVector {
  { comps, dim: comps.length() }
}

pub fn db_index_brin_vector_zero(dim : Int) -> DbindexbrinVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbindexbrinVector::add(self : DbindexbrinVector, other : DbindexbrinVector) -> DbindexbrinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexbrinVector::sub(self : DbindexbrinVector, other : DbindexbrinVector) -> DbindexbrinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexbrinVector::scale(self : DbindexbrinVector, s : Double) -> DbindexbrinVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbindexbrinVector::dot(self : DbindexbrinVector, other : DbindexbrinVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbindexbrinVector::norm(self : DbindexbrinVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbindexbrinVector::normalize(self : DbindexbrinVector) -> DbindexbrinVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexbrinVector::dist(self : DbindexbrinVector, other : DbindexbrinVector) -> Double {
  self.sub(other).norm()
}

pub fn DbindexbrinVector::to_string(self : DbindexbrinVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexbrinFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_frame_make(size : Int) -> DbindexbrinFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbrinFrame::len(self : DbindexbrinFrame) -> Int { self.size }

pub fn DbindexbrinFrame::get(self : DbindexbrinFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbrinFrame::set(self : DbindexbrinFrame, i : Int, v : Double) -> DbindexbrinFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbrinFrame::sum(self : DbindexbrinFrame) -> Double { @_common.sum(self.data) }

pub fn DbindexbrinFrame::mean(self : DbindexbrinFrame) -> Double { @_common.mean(self.data) }

pub fn DbindexbrinFrame::scale(self : DbindexbrinFrame, f : Double) -> DbindexbrinFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbrinFrame::add(self : DbindexbrinFrame, other : DbindexbrinFrame) -> DbindexbrinFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbrinFrame::copy(self : DbindexbrinFrame) -> DbindexbrinFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbrinFrame::fill(self : DbindexbrinFrame, v : Double) -> DbindexbrinFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbrinFrame::min(self : DbindexbrinFrame) -> Double { @_common.min(self.data) }

pub fn DbindexbrinFrame::max(self : DbindexbrinFrame) -> Double { @_common.max(self.data) }

pub fn DbindexbrinFrame::to_string(self : DbindexbrinFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbrinTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_table_make(size : Int) -> DbindexbrinTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbrinTable::len(self : DbindexbrinTable) -> Int { self.size }

pub fn DbindexbrinTable::get(self : DbindexbrinTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbrinTable::set(self : DbindexbrinTable, i : Int, v : Double) -> DbindexbrinTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbrinTable::sum(self : DbindexbrinTable) -> Double { @_common.sum(self.data) }

pub fn DbindexbrinTable::mean(self : DbindexbrinTable) -> Double { @_common.mean(self.data) }

pub fn DbindexbrinTable::scale(self : DbindexbrinTable, f : Double) -> DbindexbrinTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbrinTable::add(self : DbindexbrinTable, other : DbindexbrinTable) -> DbindexbrinTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbrinTable::copy(self : DbindexbrinTable) -> DbindexbrinTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbrinTable::fill(self : DbindexbrinTable, v : Double) -> DbindexbrinTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbrinTable::min(self : DbindexbrinTable) -> Double { @_common.min(self.data) }

pub fn DbindexbrinTable::max(self : DbindexbrinTable) -> Double { @_common.max(self.data) }

pub fn DbindexbrinTable::to_string(self : DbindexbrinTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbrinGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_graphn_make(size : Int) -> DbindexbrinGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbrinGraphN::len(self : DbindexbrinGraphN) -> Int { self.size }

pub fn DbindexbrinGraphN::get(self : DbindexbrinGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbrinGraphN::set(self : DbindexbrinGraphN, i : Int, v : Double) -> DbindexbrinGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbrinGraphN::sum(self : DbindexbrinGraphN) -> Double { @_common.sum(self.data) }

pub fn DbindexbrinGraphN::mean(self : DbindexbrinGraphN) -> Double { @_common.mean(self.data) }

pub fn DbindexbrinGraphN::scale(self : DbindexbrinGraphN, f : Double) -> DbindexbrinGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbrinGraphN::add(self : DbindexbrinGraphN, other : DbindexbrinGraphN) -> DbindexbrinGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbrinGraphN::copy(self : DbindexbrinGraphN) -> DbindexbrinGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbrinGraphN::fill(self : DbindexbrinGraphN, v : Double) -> DbindexbrinGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbrinGraphN::min(self : DbindexbrinGraphN) -> Double { @_common.min(self.data) }

pub fn DbindexbrinGraphN::max(self : DbindexbrinGraphN) -> Double { @_common.max(self.data) }

pub fn DbindexbrinGraphN::to_string(self : DbindexbrinGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbrinNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_node_make(size : Int) -> DbindexbrinNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbrinNode::len(self : DbindexbrinNode) -> Int { self.size }

pub fn DbindexbrinNode::get(self : DbindexbrinNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbrinNode::set(self : DbindexbrinNode, i : Int, v : Double) -> DbindexbrinNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbrinNode::sum(self : DbindexbrinNode) -> Double { @_common.sum(self.data) }

pub fn DbindexbrinNode::mean(self : DbindexbrinNode) -> Double { @_common.mean(self.data) }

pub fn DbindexbrinNode::scale(self : DbindexbrinNode, f : Double) -> DbindexbrinNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbrinNode::add(self : DbindexbrinNode, other : DbindexbrinNode) -> DbindexbrinNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbrinNode::copy(self : DbindexbrinNode) -> DbindexbrinNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbrinNode::fill(self : DbindexbrinNode, v : Double) -> DbindexbrinNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbrinNode::min(self : DbindexbrinNode) -> Double { @_common.min(self.data) }

pub fn DbindexbrinNode::max(self : DbindexbrinNode) -> Double { @_common.max(self.data) }

pub fn DbindexbrinNode::to_string(self : DbindexbrinNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbrinEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_edge_make(size : Int) -> DbindexbrinEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbrinEdge::len(self : DbindexbrinEdge) -> Int { self.size }

pub fn DbindexbrinEdge::get(self : DbindexbrinEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbrinEdge::set(self : DbindexbrinEdge, i : Int, v : Double) -> DbindexbrinEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbrinEdge::sum(self : DbindexbrinEdge) -> Double { @_common.sum(self.data) }

pub fn DbindexbrinEdge::mean(self : DbindexbrinEdge) -> Double { @_common.mean(self.data) }

pub fn DbindexbrinEdge::scale(self : DbindexbrinEdge, f : Double) -> DbindexbrinEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbrinEdge::add(self : DbindexbrinEdge, other : DbindexbrinEdge) -> DbindexbrinEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbrinEdge::copy(self : DbindexbrinEdge) -> DbindexbrinEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbrinEdge::fill(self : DbindexbrinEdge, v : Double) -> DbindexbrinEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbrinEdge::min(self : DbindexbrinEdge) -> Double { @_common.min(self.data) }

pub fn DbindexbrinEdge::max(self : DbindexbrinEdge) -> Double { @_common.max(self.data) }

pub fn DbindexbrinEdge::to_string(self : DbindexbrinEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbrinPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_path_make(size : Int) -> DbindexbrinPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbrinPath::len(self : DbindexbrinPath) -> Int { self.size }

pub fn DbindexbrinPath::get(self : DbindexbrinPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbrinPath::set(self : DbindexbrinPath, i : Int, v : Double) -> DbindexbrinPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbrinPath::sum(self : DbindexbrinPath) -> Double { @_common.sum(self.data) }

pub fn DbindexbrinPath::mean(self : DbindexbrinPath) -> Double { @_common.mean(self.data) }

pub fn DbindexbrinPath::scale(self : DbindexbrinPath, f : Double) -> DbindexbrinPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbrinPath::add(self : DbindexbrinPath, other : DbindexbrinPath) -> DbindexbrinPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbrinPath::copy(self : DbindexbrinPath) -> DbindexbrinPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbrinPath::fill(self : DbindexbrinPath, v : Double) -> DbindexbrinPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbrinPath::min(self : DbindexbrinPath) -> Double { @_common.min(self.data) }

pub fn DbindexbrinPath::max(self : DbindexbrinPath) -> Double { @_common.max(self.data) }

pub fn DbindexbrinPath::to_string(self : DbindexbrinPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbrinCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_cluster_make(size : Int) -> DbindexbrinCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbrinCluster::len(self : DbindexbrinCluster) -> Int { self.size }

pub fn DbindexbrinCluster::get(self : DbindexbrinCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbrinCluster::set(self : DbindexbrinCluster, i : Int, v : Double) -> DbindexbrinCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbrinCluster::sum(self : DbindexbrinCluster) -> Double { @_common.sum(self.data) }

pub fn DbindexbrinCluster::mean(self : DbindexbrinCluster) -> Double { @_common.mean(self.data) }

pub fn DbindexbrinCluster::scale(self : DbindexbrinCluster, f : Double) -> DbindexbrinCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbrinCluster::add(self : DbindexbrinCluster, other : DbindexbrinCluster) -> DbindexbrinCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbrinCluster::copy(self : DbindexbrinCluster) -> DbindexbrinCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbrinCluster::fill(self : DbindexbrinCluster, v : Double) -> DbindexbrinCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbrinCluster::min(self : DbindexbrinCluster) -> Double { @_common.min(self.data) }

pub fn DbindexbrinCluster::max(self : DbindexbrinCluster) -> Double { @_common.max(self.data) }

pub fn DbindexbrinCluster::to_string(self : DbindexbrinCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbrinModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_model_make(size : Int) -> DbindexbrinModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbrinModel::len(self : DbindexbrinModel) -> Int { self.size }

pub fn DbindexbrinModel::get(self : DbindexbrinModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbrinModel::set(self : DbindexbrinModel, i : Int, v : Double) -> DbindexbrinModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbrinModel::sum(self : DbindexbrinModel) -> Double { @_common.sum(self.data) }

pub fn DbindexbrinModel::mean(self : DbindexbrinModel) -> Double { @_common.mean(self.data) }

pub fn DbindexbrinModel::scale(self : DbindexbrinModel, f : Double) -> DbindexbrinModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbrinModel::add(self : DbindexbrinModel, other : DbindexbrinModel) -> DbindexbrinModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbrinModel::copy(self : DbindexbrinModel) -> DbindexbrinModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbrinModel::fill(self : DbindexbrinModel, v : Double) -> DbindexbrinModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbrinModel::min(self : DbindexbrinModel) -> Double { @_common.min(self.data) }

pub fn DbindexbrinModel::max(self : DbindexbrinModel) -> Double { @_common.max(self.data) }

pub fn DbindexbrinModel::to_string(self : DbindexbrinModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbrinLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_layer_make(size : Int) -> DbindexbrinLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbrinLayer::len(self : DbindexbrinLayer) -> Int { self.size }

pub fn DbindexbrinLayer::get(self : DbindexbrinLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbrinLayer::set(self : DbindexbrinLayer, i : Int, v : Double) -> DbindexbrinLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbrinLayer::sum(self : DbindexbrinLayer) -> Double { @_common.sum(self.data) }

pub fn DbindexbrinLayer::mean(self : DbindexbrinLayer) -> Double { @_common.mean(self.data) }

pub fn DbindexbrinLayer::scale(self : DbindexbrinLayer, f : Double) -> DbindexbrinLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbrinLayer::add(self : DbindexbrinLayer, other : DbindexbrinLayer) -> DbindexbrinLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbrinLayer::copy(self : DbindexbrinLayer) -> DbindexbrinLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbrinLayer::fill(self : DbindexbrinLayer, v : Double) -> DbindexbrinLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbrinLayer::min(self : DbindexbrinLayer) -> Double { @_common.min(self.data) }

pub fn DbindexbrinLayer::max(self : DbindexbrinLayer) -> Double { @_common.max(self.data) }

pub fn DbindexbrinLayer::to_string(self : DbindexbrinLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbrinBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_buffer_make(size : Int) -> DbindexbrinBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbrinBuffer::len(self : DbindexbrinBuffer) -> Int { self.size }

pub fn DbindexbrinBuffer::get(self : DbindexbrinBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbrinBuffer::set(self : DbindexbrinBuffer, i : Int, v : Double) -> DbindexbrinBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbrinBuffer::sum(self : DbindexbrinBuffer) -> Double { @_common.sum(self.data) }

pub fn DbindexbrinBuffer::mean(self : DbindexbrinBuffer) -> Double { @_common.mean(self.data) }

pub fn DbindexbrinBuffer::scale(self : DbindexbrinBuffer, f : Double) -> DbindexbrinBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbrinBuffer::add(self : DbindexbrinBuffer, other : DbindexbrinBuffer) -> DbindexbrinBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbrinBuffer::copy(self : DbindexbrinBuffer) -> DbindexbrinBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbrinBuffer::fill(self : DbindexbrinBuffer, v : Double) -> DbindexbrinBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbrinBuffer::min(self : DbindexbrinBuffer) -> Double { @_common.min(self.data) }

pub fn DbindexbrinBuffer::max(self : DbindexbrinBuffer) -> Double { @_common.max(self.data) }

pub fn DbindexbrinBuffer::to_string(self : DbindexbrinBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbrinCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_cursor_make(size : Int) -> DbindexbrinCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbrinCursor::len(self : DbindexbrinCursor) -> Int { self.size }

pub fn DbindexbrinCursor::get(self : DbindexbrinCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbrinCursor::set(self : DbindexbrinCursor, i : Int, v : Double) -> DbindexbrinCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbrinCursor::sum(self : DbindexbrinCursor) -> Double { @_common.sum(self.data) }

pub fn DbindexbrinCursor::mean(self : DbindexbrinCursor) -> Double { @_common.mean(self.data) }

pub fn DbindexbrinCursor::scale(self : DbindexbrinCursor, f : Double) -> DbindexbrinCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbrinCursor::add(self : DbindexbrinCursor, other : DbindexbrinCursor) -> DbindexbrinCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbrinCursor::copy(self : DbindexbrinCursor) -> DbindexbrinCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbrinCursor::fill(self : DbindexbrinCursor, v : Double) -> DbindexbrinCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbrinCursor::min(self : DbindexbrinCursor) -> Double { @_common.min(self.data) }

pub fn DbindexbrinCursor::max(self : DbindexbrinCursor) -> Double { @_common.max(self.data) }

pub fn DbindexbrinCursor::to_string(self : DbindexbrinCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbrinView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_view_make(size : Int) -> DbindexbrinView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbrinView::len(self : DbindexbrinView) -> Int { self.size }

pub fn DbindexbrinView::get(self : DbindexbrinView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbrinView::set(self : DbindexbrinView, i : Int, v : Double) -> DbindexbrinView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbrinView::sum(self : DbindexbrinView) -> Double { @_common.sum(self.data) }

pub fn DbindexbrinView::mean(self : DbindexbrinView) -> Double { @_common.mean(self.data) }

pub fn DbindexbrinView::scale(self : DbindexbrinView, f : Double) -> DbindexbrinView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbrinView::add(self : DbindexbrinView, other : DbindexbrinView) -> DbindexbrinView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbrinView::copy(self : DbindexbrinView) -> DbindexbrinView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbrinView::fill(self : DbindexbrinView, v : Double) -> DbindexbrinView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbrinView::min(self : DbindexbrinView) -> Double { @_common.min(self.data) }

pub fn DbindexbrinView::max(self : DbindexbrinView) -> Double { @_common.max(self.data) }

pub fn DbindexbrinView::to_string(self : DbindexbrinView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbrinRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_range_make(size : Int) -> DbindexbrinRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbrinRange::len(self : DbindexbrinRange) -> Int { self.size }

pub fn DbindexbrinRange::get(self : DbindexbrinRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbrinRange::set(self : DbindexbrinRange, i : Int, v : Double) -> DbindexbrinRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbrinRange::sum(self : DbindexbrinRange) -> Double { @_common.sum(self.data) }

pub fn DbindexbrinRange::mean(self : DbindexbrinRange) -> Double { @_common.mean(self.data) }

pub fn DbindexbrinRange::scale(self : DbindexbrinRange, f : Double) -> DbindexbrinRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbrinRange::add(self : DbindexbrinRange, other : DbindexbrinRange) -> DbindexbrinRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbrinRange::copy(self : DbindexbrinRange) -> DbindexbrinRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbrinRange::fill(self : DbindexbrinRange, v : Double) -> DbindexbrinRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbrinRange::min(self : DbindexbrinRange) -> Double { @_common.min(self.data) }

pub fn DbindexbrinRange::max(self : DbindexbrinRange) -> Double { @_common.max(self.data) }

pub fn DbindexbrinRange::to_string(self : DbindexbrinRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbrinSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_slice_make(size : Int) -> DbindexbrinSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbrinSlice::len(self : DbindexbrinSlice) -> Int { self.size }

pub fn DbindexbrinSlice::get(self : DbindexbrinSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbrinSlice::set(self : DbindexbrinSlice, i : Int, v : Double) -> DbindexbrinSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbrinSlice::sum(self : DbindexbrinSlice) -> Double { @_common.sum(self.data) }

pub fn DbindexbrinSlice::mean(self : DbindexbrinSlice) -> Double { @_common.mean(self.data) }

pub fn DbindexbrinSlice::scale(self : DbindexbrinSlice, f : Double) -> DbindexbrinSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbrinSlice::add(self : DbindexbrinSlice, other : DbindexbrinSlice) -> DbindexbrinSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbrinSlice::copy(self : DbindexbrinSlice) -> DbindexbrinSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbrinSlice::fill(self : DbindexbrinSlice, v : Double) -> DbindexbrinSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbrinSlice::min(self : DbindexbrinSlice) -> Double { @_common.min(self.data) }

pub fn DbindexbrinSlice::max(self : DbindexbrinSlice) -> Double { @_common.max(self.data) }

pub fn DbindexbrinSlice::to_string(self : DbindexbrinSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

