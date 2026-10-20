///===
/// extcore/db_index_invert

pub(all) struct DbindexinvertPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_invert_make_point(x : Double, y : Double) -> DbindexinvertPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_invert_make_point3(x : Double, y : Double, z : Double) -> DbindexinvertPoint {
  { x, y, z, label: 0 }
}

pub fn DbindexinvertPoint::x(self : DbindexinvertPoint) -> Double { self.x }

pub fn DbindexinvertPoint::y(self : DbindexinvertPoint) -> Double { self.y }

pub fn DbindexinvertPoint::z(self : DbindexinvertPoint) -> Double { self.z }

pub fn DbindexinvertPoint::label(self : DbindexinvertPoint) -> Int { self.label }

pub fn DbindexinvertPoint::dist(self : DbindexinvertPoint, other : DbindexinvertPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbindexinvertPoint::add(self : DbindexinvertPoint, other : DbindexinvertPoint) -> DbindexinvertPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbindexinvertPoint::sub(self : DbindexinvertPoint, other : DbindexinvertPoint) -> DbindexinvertPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbindexinvertPoint::scale(self : DbindexinvertPoint, s : Double) -> DbindexinvertPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbindexinvertPoint::dot(self : DbindexinvertPoint, other : DbindexinvertPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbindexinvertPoint::cross(self : DbindexinvertPoint, other : DbindexinvertPoint) -> DbindexinvertPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbindexinvertPoint::norm(self : DbindexinvertPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbindexinvertPoint::normalize(self : DbindexinvertPoint) -> DbindexinvertPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexinvertPoint::negate(self : DbindexinvertPoint) -> DbindexinvertPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbindexinvertPoint::mid(self : DbindexinvertPoint, other : DbindexinvertPoint) -> DbindexinvertPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbindexinvertPoint::lerp(self : DbindexinvertPoint, other : DbindexinvertPoint, t : Double) -> DbindexinvertPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbindexinvertPoint::to_string(self : DbindexinvertPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbindexinvertSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_invert_make_series(vals : Array[Double], name : String) -> DbindexinvertSeries {
  { vals, name, meta: 0 }
}

pub fn DbindexinvertSeries::len(self : DbindexinvertSeries) -> Int { self.vals.length() }

pub fn DbindexinvertSeries::sum(self : DbindexinvertSeries) -> Double { @_common.sum(self.vals) }

pub fn DbindexinvertSeries::mean(self : DbindexinvertSeries) -> Double { @_common.mean(self.vals) }

pub fn DbindexinvertSeries::min(self : DbindexinvertSeries) -> Double { @_common.min(self.vals) }

pub fn DbindexinvertSeries::max(self : DbindexinvertSeries) -> Double { @_common.max(self.vals) }

pub fn DbindexinvertSeries::range(self : DbindexinvertSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbindexinvertSeries::variance(self : DbindexinvertSeries) -> Double { @_common.variance(self.vals) }

pub fn DbindexinvertSeries::std(self : DbindexinvertSeries) -> Double { @_common.std(self.vals) }

pub fn DbindexinvertSeries::median(self : DbindexinvertSeries) -> Double { @_common.median(self.vals) }

pub fn DbindexinvertSeries::scale(self : DbindexinvertSeries, f : Double) -> DbindexinvertSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbindexinvertSeries::add(self : DbindexinvertSeries, other : DbindexinvertSeries) -> DbindexinvertSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbindexinvertSeries::sub(self : DbindexinvertSeries, other : DbindexinvertSeries) -> DbindexinvertSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbindexinvertSeries::normalize(self : DbindexinvertSeries) -> DbindexinvertSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbindexinvertSeries::cumsum(self : DbindexinvertSeries) -> DbindexinvertSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbindexinvertSeries::to_string(self : DbindexinvertSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexinvertMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_invert_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexinvertMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_invert_matrix_identity(n : Int) -> DbindexinvertMatrix {
  let m = db_index_invert_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbindexinvertMatrix::get(self : DbindexinvertMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbindexinvertMatrix::transpose(self : DbindexinvertMatrix) -> DbindexinvertMatrix {
  let result = db_index_invert_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbindexinvertMatrix::add(self : DbindexinvertMatrix, other : DbindexinvertMatrix) -> DbindexinvertMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_index_invert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbindexinvertMatrix::scale(self : DbindexinvertMatrix, s : Double) -> DbindexinvertMatrix {
  let result = db_index_invert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbindexinvertMatrix::multiply(self : DbindexinvertMatrix, other : DbindexinvertMatrix) -> DbindexinvertMatrix {
  if self.cols != other.rows { return db_index_invert_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_index_invert_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols { result.data[i][j] = result.data[i][j] + v * other.data[k][j] }
    }
  }
  result
}

pub fn DbindexinvertMatrix::trace(self : DbindexinvertMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbindexinvertMatrix::det(self : DbindexinvertMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbindexinvertMatrix::norm(self : DbindexinvertMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbindexinvertMatrix::to_string(self : DbindexinvertMatrix) -> String {
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

pub(all) struct DbindexinvertVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_invert_make_vector(comps : Array[Double]) -> DbindexinvertVector {
  { comps, dim: comps.length() }
}

pub fn db_index_invert_vector_zero(dim : Int) -> DbindexinvertVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbindexinvertVector::add(self : DbindexinvertVector, other : DbindexinvertVector) -> DbindexinvertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexinvertVector::sub(self : DbindexinvertVector, other : DbindexinvertVector) -> DbindexinvertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexinvertVector::scale(self : DbindexinvertVector, s : Double) -> DbindexinvertVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbindexinvertVector::dot(self : DbindexinvertVector, other : DbindexinvertVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbindexinvertVector::norm(self : DbindexinvertVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbindexinvertVector::normalize(self : DbindexinvertVector) -> DbindexinvertVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexinvertVector::dist(self : DbindexinvertVector, other : DbindexinvertVector) -> Double {
  self.sub(other).norm()
}

pub fn DbindexinvertVector::to_string(self : DbindexinvertVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexinvertFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_frame_make(size : Int) -> DbindexinvertFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexinvertFrame::len(self : DbindexinvertFrame) -> Int { self.size }

pub fn DbindexinvertFrame::get(self : DbindexinvertFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexinvertFrame::set(self : DbindexinvertFrame, i : Int, v : Double) -> DbindexinvertFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexinvertFrame::sum(self : DbindexinvertFrame) -> Double { @_common.sum(self.data) }

pub fn DbindexinvertFrame::mean(self : DbindexinvertFrame) -> Double { @_common.mean(self.data) }

pub fn DbindexinvertFrame::scale(self : DbindexinvertFrame, f : Double) -> DbindexinvertFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexinvertFrame::add(self : DbindexinvertFrame, other : DbindexinvertFrame) -> DbindexinvertFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexinvertFrame::copy(self : DbindexinvertFrame) -> DbindexinvertFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexinvertFrame::fill(self : DbindexinvertFrame, v : Double) -> DbindexinvertFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexinvertFrame::min(self : DbindexinvertFrame) -> Double { @_common.min(self.data) }

pub fn DbindexinvertFrame::max(self : DbindexinvertFrame) -> Double { @_common.max(self.data) }

pub fn DbindexinvertFrame::to_string(self : DbindexinvertFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexinvertTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_table_make(size : Int) -> DbindexinvertTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexinvertTable::len(self : DbindexinvertTable) -> Int { self.size }

pub fn DbindexinvertTable::get(self : DbindexinvertTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexinvertTable::set(self : DbindexinvertTable, i : Int, v : Double) -> DbindexinvertTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexinvertTable::sum(self : DbindexinvertTable) -> Double { @_common.sum(self.data) }

pub fn DbindexinvertTable::mean(self : DbindexinvertTable) -> Double { @_common.mean(self.data) }

pub fn DbindexinvertTable::scale(self : DbindexinvertTable, f : Double) -> DbindexinvertTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexinvertTable::add(self : DbindexinvertTable, other : DbindexinvertTable) -> DbindexinvertTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexinvertTable::copy(self : DbindexinvertTable) -> DbindexinvertTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexinvertTable::fill(self : DbindexinvertTable, v : Double) -> DbindexinvertTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexinvertTable::min(self : DbindexinvertTable) -> Double { @_common.min(self.data) }

pub fn DbindexinvertTable::max(self : DbindexinvertTable) -> Double { @_common.max(self.data) }

pub fn DbindexinvertTable::to_string(self : DbindexinvertTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexinvertGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_graphn_make(size : Int) -> DbindexinvertGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexinvertGraphN::len(self : DbindexinvertGraphN) -> Int { self.size }

pub fn DbindexinvertGraphN::get(self : DbindexinvertGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexinvertGraphN::set(self : DbindexinvertGraphN, i : Int, v : Double) -> DbindexinvertGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexinvertGraphN::sum(self : DbindexinvertGraphN) -> Double { @_common.sum(self.data) }

pub fn DbindexinvertGraphN::mean(self : DbindexinvertGraphN) -> Double { @_common.mean(self.data) }

pub fn DbindexinvertGraphN::scale(self : DbindexinvertGraphN, f : Double) -> DbindexinvertGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexinvertGraphN::add(self : DbindexinvertGraphN, other : DbindexinvertGraphN) -> DbindexinvertGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexinvertGraphN::copy(self : DbindexinvertGraphN) -> DbindexinvertGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexinvertGraphN::fill(self : DbindexinvertGraphN, v : Double) -> DbindexinvertGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexinvertGraphN::min(self : DbindexinvertGraphN) -> Double { @_common.min(self.data) }

pub fn DbindexinvertGraphN::max(self : DbindexinvertGraphN) -> Double { @_common.max(self.data) }

pub fn DbindexinvertGraphN::to_string(self : DbindexinvertGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexinvertNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_node_make(size : Int) -> DbindexinvertNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexinvertNode::len(self : DbindexinvertNode) -> Int { self.size }

pub fn DbindexinvertNode::get(self : DbindexinvertNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexinvertNode::set(self : DbindexinvertNode, i : Int, v : Double) -> DbindexinvertNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexinvertNode::sum(self : DbindexinvertNode) -> Double { @_common.sum(self.data) }

pub fn DbindexinvertNode::mean(self : DbindexinvertNode) -> Double { @_common.mean(self.data) }

pub fn DbindexinvertNode::scale(self : DbindexinvertNode, f : Double) -> DbindexinvertNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexinvertNode::add(self : DbindexinvertNode, other : DbindexinvertNode) -> DbindexinvertNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexinvertNode::copy(self : DbindexinvertNode) -> DbindexinvertNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexinvertNode::fill(self : DbindexinvertNode, v : Double) -> DbindexinvertNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexinvertNode::min(self : DbindexinvertNode) -> Double { @_common.min(self.data) }

pub fn DbindexinvertNode::max(self : DbindexinvertNode) -> Double { @_common.max(self.data) }

pub fn DbindexinvertNode::to_string(self : DbindexinvertNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexinvertEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_edge_make(size : Int) -> DbindexinvertEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexinvertEdge::len(self : DbindexinvertEdge) -> Int { self.size }

pub fn DbindexinvertEdge::get(self : DbindexinvertEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexinvertEdge::set(self : DbindexinvertEdge, i : Int, v : Double) -> DbindexinvertEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexinvertEdge::sum(self : DbindexinvertEdge) -> Double { @_common.sum(self.data) }

pub fn DbindexinvertEdge::mean(self : DbindexinvertEdge) -> Double { @_common.mean(self.data) }

pub fn DbindexinvertEdge::scale(self : DbindexinvertEdge, f : Double) -> DbindexinvertEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexinvertEdge::add(self : DbindexinvertEdge, other : DbindexinvertEdge) -> DbindexinvertEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexinvertEdge::copy(self : DbindexinvertEdge) -> DbindexinvertEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexinvertEdge::fill(self : DbindexinvertEdge, v : Double) -> DbindexinvertEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexinvertEdge::min(self : DbindexinvertEdge) -> Double { @_common.min(self.data) }

pub fn DbindexinvertEdge::max(self : DbindexinvertEdge) -> Double { @_common.max(self.data) }

pub fn DbindexinvertEdge::to_string(self : DbindexinvertEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexinvertPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_path_make(size : Int) -> DbindexinvertPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexinvertPath::len(self : DbindexinvertPath) -> Int { self.size }

pub fn DbindexinvertPath::get(self : DbindexinvertPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexinvertPath::set(self : DbindexinvertPath, i : Int, v : Double) -> DbindexinvertPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexinvertPath::sum(self : DbindexinvertPath) -> Double { @_common.sum(self.data) }

pub fn DbindexinvertPath::mean(self : DbindexinvertPath) -> Double { @_common.mean(self.data) }

pub fn DbindexinvertPath::scale(self : DbindexinvertPath, f : Double) -> DbindexinvertPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexinvertPath::add(self : DbindexinvertPath, other : DbindexinvertPath) -> DbindexinvertPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexinvertPath::copy(self : DbindexinvertPath) -> DbindexinvertPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexinvertPath::fill(self : DbindexinvertPath, v : Double) -> DbindexinvertPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexinvertPath::min(self : DbindexinvertPath) -> Double { @_common.min(self.data) }

pub fn DbindexinvertPath::max(self : DbindexinvertPath) -> Double { @_common.max(self.data) }

pub fn DbindexinvertPath::to_string(self : DbindexinvertPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexinvertCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_cluster_make(size : Int) -> DbindexinvertCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexinvertCluster::len(self : DbindexinvertCluster) -> Int { self.size }

pub fn DbindexinvertCluster::get(self : DbindexinvertCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexinvertCluster::set(self : DbindexinvertCluster, i : Int, v : Double) -> DbindexinvertCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexinvertCluster::sum(self : DbindexinvertCluster) -> Double { @_common.sum(self.data) }

pub fn DbindexinvertCluster::mean(self : DbindexinvertCluster) -> Double { @_common.mean(self.data) }

pub fn DbindexinvertCluster::scale(self : DbindexinvertCluster, f : Double) -> DbindexinvertCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexinvertCluster::add(self : DbindexinvertCluster, other : DbindexinvertCluster) -> DbindexinvertCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexinvertCluster::copy(self : DbindexinvertCluster) -> DbindexinvertCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexinvertCluster::fill(self : DbindexinvertCluster, v : Double) -> DbindexinvertCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexinvertCluster::min(self : DbindexinvertCluster) -> Double { @_common.min(self.data) }

pub fn DbindexinvertCluster::max(self : DbindexinvertCluster) -> Double { @_common.max(self.data) }

pub fn DbindexinvertCluster::to_string(self : DbindexinvertCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexinvertModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_model_make(size : Int) -> DbindexinvertModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexinvertModel::len(self : DbindexinvertModel) -> Int { self.size }

pub fn DbindexinvertModel::get(self : DbindexinvertModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexinvertModel::set(self : DbindexinvertModel, i : Int, v : Double) -> DbindexinvertModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexinvertModel::sum(self : DbindexinvertModel) -> Double { @_common.sum(self.data) }

pub fn DbindexinvertModel::mean(self : DbindexinvertModel) -> Double { @_common.mean(self.data) }

pub fn DbindexinvertModel::scale(self : DbindexinvertModel, f : Double) -> DbindexinvertModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexinvertModel::add(self : DbindexinvertModel, other : DbindexinvertModel) -> DbindexinvertModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexinvertModel::copy(self : DbindexinvertModel) -> DbindexinvertModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexinvertModel::fill(self : DbindexinvertModel, v : Double) -> DbindexinvertModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexinvertModel::min(self : DbindexinvertModel) -> Double { @_common.min(self.data) }

pub fn DbindexinvertModel::max(self : DbindexinvertModel) -> Double { @_common.max(self.data) }

pub fn DbindexinvertModel::to_string(self : DbindexinvertModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexinvertLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_layer_make(size : Int) -> DbindexinvertLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexinvertLayer::len(self : DbindexinvertLayer) -> Int { self.size }

pub fn DbindexinvertLayer::get(self : DbindexinvertLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexinvertLayer::set(self : DbindexinvertLayer, i : Int, v : Double) -> DbindexinvertLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexinvertLayer::sum(self : DbindexinvertLayer) -> Double { @_common.sum(self.data) }

pub fn DbindexinvertLayer::mean(self : DbindexinvertLayer) -> Double { @_common.mean(self.data) }

pub fn DbindexinvertLayer::scale(self : DbindexinvertLayer, f : Double) -> DbindexinvertLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexinvertLayer::add(self : DbindexinvertLayer, other : DbindexinvertLayer) -> DbindexinvertLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexinvertLayer::copy(self : DbindexinvertLayer) -> DbindexinvertLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexinvertLayer::fill(self : DbindexinvertLayer, v : Double) -> DbindexinvertLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexinvertLayer::min(self : DbindexinvertLayer) -> Double { @_common.min(self.data) }

pub fn DbindexinvertLayer::max(self : DbindexinvertLayer) -> Double { @_common.max(self.data) }

pub fn DbindexinvertLayer::to_string(self : DbindexinvertLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexinvertBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_buffer_make(size : Int) -> DbindexinvertBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexinvertBuffer::len(self : DbindexinvertBuffer) -> Int { self.size }

pub fn DbindexinvertBuffer::get(self : DbindexinvertBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexinvertBuffer::set(self : DbindexinvertBuffer, i : Int, v : Double) -> DbindexinvertBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexinvertBuffer::sum(self : DbindexinvertBuffer) -> Double { @_common.sum(self.data) }

pub fn DbindexinvertBuffer::mean(self : DbindexinvertBuffer) -> Double { @_common.mean(self.data) }

pub fn DbindexinvertBuffer::scale(self : DbindexinvertBuffer, f : Double) -> DbindexinvertBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexinvertBuffer::add(self : DbindexinvertBuffer, other : DbindexinvertBuffer) -> DbindexinvertBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexinvertBuffer::copy(self : DbindexinvertBuffer) -> DbindexinvertBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexinvertBuffer::fill(self : DbindexinvertBuffer, v : Double) -> DbindexinvertBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexinvertBuffer::min(self : DbindexinvertBuffer) -> Double { @_common.min(self.data) }

pub fn DbindexinvertBuffer::max(self : DbindexinvertBuffer) -> Double { @_common.max(self.data) }

pub fn DbindexinvertBuffer::to_string(self : DbindexinvertBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexinvertCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_cursor_make(size : Int) -> DbindexinvertCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexinvertCursor::len(self : DbindexinvertCursor) -> Int { self.size }

pub fn DbindexinvertCursor::get(self : DbindexinvertCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexinvertCursor::set(self : DbindexinvertCursor, i : Int, v : Double) -> DbindexinvertCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexinvertCursor::sum(self : DbindexinvertCursor) -> Double { @_common.sum(self.data) }

pub fn DbindexinvertCursor::mean(self : DbindexinvertCursor) -> Double { @_common.mean(self.data) }

pub fn DbindexinvertCursor::scale(self : DbindexinvertCursor, f : Double) -> DbindexinvertCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexinvertCursor::add(self : DbindexinvertCursor, other : DbindexinvertCursor) -> DbindexinvertCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexinvertCursor::copy(self : DbindexinvertCursor) -> DbindexinvertCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexinvertCursor::fill(self : DbindexinvertCursor, v : Double) -> DbindexinvertCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexinvertCursor::min(self : DbindexinvertCursor) -> Double { @_common.min(self.data) }

pub fn DbindexinvertCursor::max(self : DbindexinvertCursor) -> Double { @_common.max(self.data) }

pub fn DbindexinvertCursor::to_string(self : DbindexinvertCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexinvertView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_view_make(size : Int) -> DbindexinvertView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexinvertView::len(self : DbindexinvertView) -> Int { self.size }

pub fn DbindexinvertView::get(self : DbindexinvertView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexinvertView::set(self : DbindexinvertView, i : Int, v : Double) -> DbindexinvertView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexinvertView::sum(self : DbindexinvertView) -> Double { @_common.sum(self.data) }

pub fn DbindexinvertView::mean(self : DbindexinvertView) -> Double { @_common.mean(self.data) }

pub fn DbindexinvertView::scale(self : DbindexinvertView, f : Double) -> DbindexinvertView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexinvertView::add(self : DbindexinvertView, other : DbindexinvertView) -> DbindexinvertView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexinvertView::copy(self : DbindexinvertView) -> DbindexinvertView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexinvertView::fill(self : DbindexinvertView, v : Double) -> DbindexinvertView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexinvertView::min(self : DbindexinvertView) -> Double { @_common.min(self.data) }

pub fn DbindexinvertView::max(self : DbindexinvertView) -> Double { @_common.max(self.data) }

pub fn DbindexinvertView::to_string(self : DbindexinvertView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexinvertRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_range_make(size : Int) -> DbindexinvertRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexinvertRange::len(self : DbindexinvertRange) -> Int { self.size }

pub fn DbindexinvertRange::get(self : DbindexinvertRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexinvertRange::set(self : DbindexinvertRange, i : Int, v : Double) -> DbindexinvertRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexinvertRange::sum(self : DbindexinvertRange) -> Double { @_common.sum(self.data) }

pub fn DbindexinvertRange::mean(self : DbindexinvertRange) -> Double { @_common.mean(self.data) }

pub fn DbindexinvertRange::scale(self : DbindexinvertRange, f : Double) -> DbindexinvertRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexinvertRange::add(self : DbindexinvertRange, other : DbindexinvertRange) -> DbindexinvertRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexinvertRange::copy(self : DbindexinvertRange) -> DbindexinvertRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexinvertRange::fill(self : DbindexinvertRange, v : Double) -> DbindexinvertRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexinvertRange::min(self : DbindexinvertRange) -> Double { @_common.min(self.data) }

pub fn DbindexinvertRange::max(self : DbindexinvertRange) -> Double { @_common.max(self.data) }

pub fn DbindexinvertRange::to_string(self : DbindexinvertRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexinvertSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_slice_make(size : Int) -> DbindexinvertSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexinvertSlice::len(self : DbindexinvertSlice) -> Int { self.size }

pub fn DbindexinvertSlice::get(self : DbindexinvertSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexinvertSlice::set(self : DbindexinvertSlice, i : Int, v : Double) -> DbindexinvertSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexinvertSlice::sum(self : DbindexinvertSlice) -> Double { @_common.sum(self.data) }

pub fn DbindexinvertSlice::mean(self : DbindexinvertSlice) -> Double { @_common.mean(self.data) }

pub fn DbindexinvertSlice::scale(self : DbindexinvertSlice, f : Double) -> DbindexinvertSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexinvertSlice::add(self : DbindexinvertSlice, other : DbindexinvertSlice) -> DbindexinvertSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexinvertSlice::copy(self : DbindexinvertSlice) -> DbindexinvertSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexinvertSlice::fill(self : DbindexinvertSlice, v : Double) -> DbindexinvertSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexinvertSlice::min(self : DbindexinvertSlice) -> Double { @_common.min(self.data) }

pub fn DbindexinvertSlice::max(self : DbindexinvertSlice) -> Double { @_common.max(self.data) }

pub fn DbindexinvertSlice::to_string(self : DbindexinvertSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

