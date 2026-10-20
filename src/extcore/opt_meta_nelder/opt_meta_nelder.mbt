///===
/// extcore/opt_meta_nelder

pub(all) struct OptmetanelderPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_nelder_make_point(x : Double, y : Double) -> OptmetanelderPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_nelder_make_point3(x : Double, y : Double, z : Double) -> OptmetanelderPoint {
  { x, y, z, label: 0 }
}

pub fn OptmetanelderPoint::x(self : OptmetanelderPoint) -> Double { self.x }

pub fn OptmetanelderPoint::y(self : OptmetanelderPoint) -> Double { self.y }

pub fn OptmetanelderPoint::z(self : OptmetanelderPoint) -> Double { self.z }

pub fn OptmetanelderPoint::label(self : OptmetanelderPoint) -> Int { self.label }

pub fn OptmetanelderPoint::dist(self : OptmetanelderPoint, other : OptmetanelderPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptmetanelderPoint::add(self : OptmetanelderPoint, other : OptmetanelderPoint) -> OptmetanelderPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptmetanelderPoint::sub(self : OptmetanelderPoint, other : OptmetanelderPoint) -> OptmetanelderPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptmetanelderPoint::scale(self : OptmetanelderPoint, s : Double) -> OptmetanelderPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptmetanelderPoint::dot(self : OptmetanelderPoint, other : OptmetanelderPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptmetanelderPoint::cross(self : OptmetanelderPoint, other : OptmetanelderPoint) -> OptmetanelderPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptmetanelderPoint::norm(self : OptmetanelderPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptmetanelderPoint::normalize(self : OptmetanelderPoint) -> OptmetanelderPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetanelderPoint::negate(self : OptmetanelderPoint) -> OptmetanelderPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptmetanelderPoint::mid(self : OptmetanelderPoint, other : OptmetanelderPoint) -> OptmetanelderPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptmetanelderPoint::lerp(self : OptmetanelderPoint, other : OptmetanelderPoint, t : Double) -> OptmetanelderPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptmetanelderPoint::to_string(self : OptmetanelderPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptmetanelderSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_nelder_make_series(vals : Array[Double], name : String) -> OptmetanelderSeries {
  { vals, name, meta: 0 }
}

pub fn OptmetanelderSeries::len(self : OptmetanelderSeries) -> Int { self.vals.length() }

pub fn OptmetanelderSeries::sum(self : OptmetanelderSeries) -> Double { @_common.sum(self.vals) }

pub fn OptmetanelderSeries::mean(self : OptmetanelderSeries) -> Double { @_common.mean(self.vals) }

pub fn OptmetanelderSeries::min(self : OptmetanelderSeries) -> Double { @_common.min(self.vals) }

pub fn OptmetanelderSeries::max(self : OptmetanelderSeries) -> Double { @_common.max(self.vals) }

pub fn OptmetanelderSeries::range(self : OptmetanelderSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptmetanelderSeries::variance(self : OptmetanelderSeries) -> Double { @_common.variance(self.vals) }

pub fn OptmetanelderSeries::std(self : OptmetanelderSeries) -> Double { @_common.std(self.vals) }

pub fn OptmetanelderSeries::median(self : OptmetanelderSeries) -> Double { @_common.median(self.vals) }

pub fn OptmetanelderSeries::scale(self : OptmetanelderSeries, f : Double) -> OptmetanelderSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptmetanelderSeries::add(self : OptmetanelderSeries, other : OptmetanelderSeries) -> OptmetanelderSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptmetanelderSeries::sub(self : OptmetanelderSeries, other : OptmetanelderSeries) -> OptmetanelderSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptmetanelderSeries::normalize(self : OptmetanelderSeries) -> OptmetanelderSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptmetanelderSeries::cumsum(self : OptmetanelderSeries) -> OptmetanelderSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptmetanelderSeries::to_string(self : OptmetanelderSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetanelderMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_nelder_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetanelderMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_nelder_matrix_identity(n : Int) -> OptmetanelderMatrix {
  let m = opt_meta_nelder_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptmetanelderMatrix::get(self : OptmetanelderMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptmetanelderMatrix::transpose(self : OptmetanelderMatrix) -> OptmetanelderMatrix {
  let result = opt_meta_nelder_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptmetanelderMatrix::add(self : OptmetanelderMatrix, other : OptmetanelderMatrix) -> OptmetanelderMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_meta_nelder_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptmetanelderMatrix::scale(self : OptmetanelderMatrix, s : Double) -> OptmetanelderMatrix {
  let result = opt_meta_nelder_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptmetanelderMatrix::multiply(self : OptmetanelderMatrix, other : OptmetanelderMatrix) -> OptmetanelderMatrix {
  if self.cols != other.rows { return opt_meta_nelder_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_meta_nelder_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptmetanelderMatrix::trace(self : OptmetanelderMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptmetanelderMatrix::det(self : OptmetanelderMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptmetanelderMatrix::norm(self : OptmetanelderMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptmetanelderMatrix::to_string(self : OptmetanelderMatrix) -> String {
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

pub(all) struct OptmetanelderVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_nelder_make_vector(comps : Array[Double]) -> OptmetanelderVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_nelder_vector_zero(dim : Int) -> OptmetanelderVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptmetanelderVector::add(self : OptmetanelderVector, other : OptmetanelderVector) -> OptmetanelderVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetanelderVector::sub(self : OptmetanelderVector, other : OptmetanelderVector) -> OptmetanelderVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetanelderVector::scale(self : OptmetanelderVector, s : Double) -> OptmetanelderVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptmetanelderVector::dot(self : OptmetanelderVector, other : OptmetanelderVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptmetanelderVector::norm(self : OptmetanelderVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptmetanelderVector::normalize(self : OptmetanelderVector) -> OptmetanelderVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetanelderVector::dist(self : OptmetanelderVector, other : OptmetanelderVector) -> Double {
  self.sub(other).norm()
}

pub fn OptmetanelderVector::to_string(self : OptmetanelderVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetanelderFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_frame_make(size : Int) -> OptmetanelderFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetanelderFrame::len(self : OptmetanelderFrame) -> Int { self.size }

pub fn OptmetanelderFrame::get(self : OptmetanelderFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetanelderFrame::set(self : OptmetanelderFrame, i : Int, v : Double) -> OptmetanelderFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetanelderFrame::sum(self : OptmetanelderFrame) -> Double { @_common.sum(self.data) }

pub fn OptmetanelderFrame::mean(self : OptmetanelderFrame) -> Double { @_common.mean(self.data) }

pub fn OptmetanelderFrame::scale(self : OptmetanelderFrame, f : Double) -> OptmetanelderFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetanelderFrame::add(self : OptmetanelderFrame, other : OptmetanelderFrame) -> OptmetanelderFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetanelderFrame::copy(self : OptmetanelderFrame) -> OptmetanelderFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetanelderFrame::fill(self : OptmetanelderFrame, v : Double) -> OptmetanelderFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetanelderFrame::min(self : OptmetanelderFrame) -> Double { @_common.min(self.data) }

pub fn OptmetanelderFrame::max(self : OptmetanelderFrame) -> Double { @_common.max(self.data) }

pub fn OptmetanelderFrame::to_string(self : OptmetanelderFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetanelderTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_table_make(size : Int) -> OptmetanelderTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetanelderTable::len(self : OptmetanelderTable) -> Int { self.size }

pub fn OptmetanelderTable::get(self : OptmetanelderTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetanelderTable::set(self : OptmetanelderTable, i : Int, v : Double) -> OptmetanelderTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetanelderTable::sum(self : OptmetanelderTable) -> Double { @_common.sum(self.data) }

pub fn OptmetanelderTable::mean(self : OptmetanelderTable) -> Double { @_common.mean(self.data) }

pub fn OptmetanelderTable::scale(self : OptmetanelderTable, f : Double) -> OptmetanelderTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetanelderTable::add(self : OptmetanelderTable, other : OptmetanelderTable) -> OptmetanelderTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetanelderTable::copy(self : OptmetanelderTable) -> OptmetanelderTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetanelderTable::fill(self : OptmetanelderTable, v : Double) -> OptmetanelderTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetanelderTable::min(self : OptmetanelderTable) -> Double { @_common.min(self.data) }

pub fn OptmetanelderTable::max(self : OptmetanelderTable) -> Double { @_common.max(self.data) }

pub fn OptmetanelderTable::to_string(self : OptmetanelderTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetanelderGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_graphn_make(size : Int) -> OptmetanelderGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetanelderGraphN::len(self : OptmetanelderGraphN) -> Int { self.size }

pub fn OptmetanelderGraphN::get(self : OptmetanelderGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetanelderGraphN::set(self : OptmetanelderGraphN, i : Int, v : Double) -> OptmetanelderGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetanelderGraphN::sum(self : OptmetanelderGraphN) -> Double { @_common.sum(self.data) }

pub fn OptmetanelderGraphN::mean(self : OptmetanelderGraphN) -> Double { @_common.mean(self.data) }

pub fn OptmetanelderGraphN::scale(self : OptmetanelderGraphN, f : Double) -> OptmetanelderGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetanelderGraphN::add(self : OptmetanelderGraphN, other : OptmetanelderGraphN) -> OptmetanelderGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetanelderGraphN::copy(self : OptmetanelderGraphN) -> OptmetanelderGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetanelderGraphN::fill(self : OptmetanelderGraphN, v : Double) -> OptmetanelderGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetanelderGraphN::min(self : OptmetanelderGraphN) -> Double { @_common.min(self.data) }

pub fn OptmetanelderGraphN::max(self : OptmetanelderGraphN) -> Double { @_common.max(self.data) }

pub fn OptmetanelderGraphN::to_string(self : OptmetanelderGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetanelderNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_node_make(size : Int) -> OptmetanelderNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetanelderNode::len(self : OptmetanelderNode) -> Int { self.size }

pub fn OptmetanelderNode::get(self : OptmetanelderNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetanelderNode::set(self : OptmetanelderNode, i : Int, v : Double) -> OptmetanelderNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetanelderNode::sum(self : OptmetanelderNode) -> Double { @_common.sum(self.data) }

pub fn OptmetanelderNode::mean(self : OptmetanelderNode) -> Double { @_common.mean(self.data) }

pub fn OptmetanelderNode::scale(self : OptmetanelderNode, f : Double) -> OptmetanelderNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetanelderNode::add(self : OptmetanelderNode, other : OptmetanelderNode) -> OptmetanelderNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetanelderNode::copy(self : OptmetanelderNode) -> OptmetanelderNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetanelderNode::fill(self : OptmetanelderNode, v : Double) -> OptmetanelderNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetanelderNode::min(self : OptmetanelderNode) -> Double { @_common.min(self.data) }

pub fn OptmetanelderNode::max(self : OptmetanelderNode) -> Double { @_common.max(self.data) }

pub fn OptmetanelderNode::to_string(self : OptmetanelderNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetanelderEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_edge_make(size : Int) -> OptmetanelderEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetanelderEdge::len(self : OptmetanelderEdge) -> Int { self.size }

pub fn OptmetanelderEdge::get(self : OptmetanelderEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetanelderEdge::set(self : OptmetanelderEdge, i : Int, v : Double) -> OptmetanelderEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetanelderEdge::sum(self : OptmetanelderEdge) -> Double { @_common.sum(self.data) }

pub fn OptmetanelderEdge::mean(self : OptmetanelderEdge) -> Double { @_common.mean(self.data) }

pub fn OptmetanelderEdge::scale(self : OptmetanelderEdge, f : Double) -> OptmetanelderEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetanelderEdge::add(self : OptmetanelderEdge, other : OptmetanelderEdge) -> OptmetanelderEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetanelderEdge::copy(self : OptmetanelderEdge) -> OptmetanelderEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetanelderEdge::fill(self : OptmetanelderEdge, v : Double) -> OptmetanelderEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetanelderEdge::min(self : OptmetanelderEdge) -> Double { @_common.min(self.data) }

pub fn OptmetanelderEdge::max(self : OptmetanelderEdge) -> Double { @_common.max(self.data) }

pub fn OptmetanelderEdge::to_string(self : OptmetanelderEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetanelderPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_path_make(size : Int) -> OptmetanelderPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetanelderPath::len(self : OptmetanelderPath) -> Int { self.size }

pub fn OptmetanelderPath::get(self : OptmetanelderPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetanelderPath::set(self : OptmetanelderPath, i : Int, v : Double) -> OptmetanelderPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetanelderPath::sum(self : OptmetanelderPath) -> Double { @_common.sum(self.data) }

pub fn OptmetanelderPath::mean(self : OptmetanelderPath) -> Double { @_common.mean(self.data) }

pub fn OptmetanelderPath::scale(self : OptmetanelderPath, f : Double) -> OptmetanelderPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetanelderPath::add(self : OptmetanelderPath, other : OptmetanelderPath) -> OptmetanelderPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetanelderPath::copy(self : OptmetanelderPath) -> OptmetanelderPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetanelderPath::fill(self : OptmetanelderPath, v : Double) -> OptmetanelderPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetanelderPath::min(self : OptmetanelderPath) -> Double { @_common.min(self.data) }

pub fn OptmetanelderPath::max(self : OptmetanelderPath) -> Double { @_common.max(self.data) }

pub fn OptmetanelderPath::to_string(self : OptmetanelderPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetanelderCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_cluster_make(size : Int) -> OptmetanelderCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetanelderCluster::len(self : OptmetanelderCluster) -> Int { self.size }

pub fn OptmetanelderCluster::get(self : OptmetanelderCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetanelderCluster::set(self : OptmetanelderCluster, i : Int, v : Double) -> OptmetanelderCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetanelderCluster::sum(self : OptmetanelderCluster) -> Double { @_common.sum(self.data) }

pub fn OptmetanelderCluster::mean(self : OptmetanelderCluster) -> Double { @_common.mean(self.data) }

pub fn OptmetanelderCluster::scale(self : OptmetanelderCluster, f : Double) -> OptmetanelderCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetanelderCluster::add(self : OptmetanelderCluster, other : OptmetanelderCluster) -> OptmetanelderCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetanelderCluster::copy(self : OptmetanelderCluster) -> OptmetanelderCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetanelderCluster::fill(self : OptmetanelderCluster, v : Double) -> OptmetanelderCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetanelderCluster::min(self : OptmetanelderCluster) -> Double { @_common.min(self.data) }

pub fn OptmetanelderCluster::max(self : OptmetanelderCluster) -> Double { @_common.max(self.data) }

pub fn OptmetanelderCluster::to_string(self : OptmetanelderCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetanelderModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_model_make(size : Int) -> OptmetanelderModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetanelderModel::len(self : OptmetanelderModel) -> Int { self.size }

pub fn OptmetanelderModel::get(self : OptmetanelderModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetanelderModel::set(self : OptmetanelderModel, i : Int, v : Double) -> OptmetanelderModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetanelderModel::sum(self : OptmetanelderModel) -> Double { @_common.sum(self.data) }

pub fn OptmetanelderModel::mean(self : OptmetanelderModel) -> Double { @_common.mean(self.data) }

pub fn OptmetanelderModel::scale(self : OptmetanelderModel, f : Double) -> OptmetanelderModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetanelderModel::add(self : OptmetanelderModel, other : OptmetanelderModel) -> OptmetanelderModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetanelderModel::copy(self : OptmetanelderModel) -> OptmetanelderModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetanelderModel::fill(self : OptmetanelderModel, v : Double) -> OptmetanelderModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetanelderModel::min(self : OptmetanelderModel) -> Double { @_common.min(self.data) }

pub fn OptmetanelderModel::max(self : OptmetanelderModel) -> Double { @_common.max(self.data) }

pub fn OptmetanelderModel::to_string(self : OptmetanelderModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetanelderLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_layer_make(size : Int) -> OptmetanelderLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetanelderLayer::len(self : OptmetanelderLayer) -> Int { self.size }

pub fn OptmetanelderLayer::get(self : OptmetanelderLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetanelderLayer::set(self : OptmetanelderLayer, i : Int, v : Double) -> OptmetanelderLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetanelderLayer::sum(self : OptmetanelderLayer) -> Double { @_common.sum(self.data) }

pub fn OptmetanelderLayer::mean(self : OptmetanelderLayer) -> Double { @_common.mean(self.data) }

pub fn OptmetanelderLayer::scale(self : OptmetanelderLayer, f : Double) -> OptmetanelderLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetanelderLayer::add(self : OptmetanelderLayer, other : OptmetanelderLayer) -> OptmetanelderLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetanelderLayer::copy(self : OptmetanelderLayer) -> OptmetanelderLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetanelderLayer::fill(self : OptmetanelderLayer, v : Double) -> OptmetanelderLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetanelderLayer::min(self : OptmetanelderLayer) -> Double { @_common.min(self.data) }

pub fn OptmetanelderLayer::max(self : OptmetanelderLayer) -> Double { @_common.max(self.data) }

pub fn OptmetanelderLayer::to_string(self : OptmetanelderLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetanelderBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_buffer_make(size : Int) -> OptmetanelderBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetanelderBuffer::len(self : OptmetanelderBuffer) -> Int { self.size }

pub fn OptmetanelderBuffer::get(self : OptmetanelderBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetanelderBuffer::set(self : OptmetanelderBuffer, i : Int, v : Double) -> OptmetanelderBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetanelderBuffer::sum(self : OptmetanelderBuffer) -> Double { @_common.sum(self.data) }

pub fn OptmetanelderBuffer::mean(self : OptmetanelderBuffer) -> Double { @_common.mean(self.data) }

pub fn OptmetanelderBuffer::scale(self : OptmetanelderBuffer, f : Double) -> OptmetanelderBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetanelderBuffer::add(self : OptmetanelderBuffer, other : OptmetanelderBuffer) -> OptmetanelderBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetanelderBuffer::copy(self : OptmetanelderBuffer) -> OptmetanelderBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetanelderBuffer::fill(self : OptmetanelderBuffer, v : Double) -> OptmetanelderBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetanelderBuffer::min(self : OptmetanelderBuffer) -> Double { @_common.min(self.data) }

pub fn OptmetanelderBuffer::max(self : OptmetanelderBuffer) -> Double { @_common.max(self.data) }

pub fn OptmetanelderBuffer::to_string(self : OptmetanelderBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetanelderCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_cursor_make(size : Int) -> OptmetanelderCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetanelderCursor::len(self : OptmetanelderCursor) -> Int { self.size }

pub fn OptmetanelderCursor::get(self : OptmetanelderCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetanelderCursor::set(self : OptmetanelderCursor, i : Int, v : Double) -> OptmetanelderCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetanelderCursor::sum(self : OptmetanelderCursor) -> Double { @_common.sum(self.data) }

pub fn OptmetanelderCursor::mean(self : OptmetanelderCursor) -> Double { @_common.mean(self.data) }

pub fn OptmetanelderCursor::scale(self : OptmetanelderCursor, f : Double) -> OptmetanelderCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetanelderCursor::add(self : OptmetanelderCursor, other : OptmetanelderCursor) -> OptmetanelderCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetanelderCursor::copy(self : OptmetanelderCursor) -> OptmetanelderCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetanelderCursor::fill(self : OptmetanelderCursor, v : Double) -> OptmetanelderCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetanelderCursor::min(self : OptmetanelderCursor) -> Double { @_common.min(self.data) }

pub fn OptmetanelderCursor::max(self : OptmetanelderCursor) -> Double { @_common.max(self.data) }

pub fn OptmetanelderCursor::to_string(self : OptmetanelderCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetanelderView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_view_make(size : Int) -> OptmetanelderView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetanelderView::len(self : OptmetanelderView) -> Int { self.size }

pub fn OptmetanelderView::get(self : OptmetanelderView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetanelderView::set(self : OptmetanelderView, i : Int, v : Double) -> OptmetanelderView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetanelderView::sum(self : OptmetanelderView) -> Double { @_common.sum(self.data) }

pub fn OptmetanelderView::mean(self : OptmetanelderView) -> Double { @_common.mean(self.data) }

pub fn OptmetanelderView::scale(self : OptmetanelderView, f : Double) -> OptmetanelderView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetanelderView::add(self : OptmetanelderView, other : OptmetanelderView) -> OptmetanelderView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetanelderView::copy(self : OptmetanelderView) -> OptmetanelderView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetanelderView::fill(self : OptmetanelderView, v : Double) -> OptmetanelderView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetanelderView::min(self : OptmetanelderView) -> Double { @_common.min(self.data) }

pub fn OptmetanelderView::max(self : OptmetanelderView) -> Double { @_common.max(self.data) }

pub fn OptmetanelderView::to_string(self : OptmetanelderView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetanelderRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_range_make(size : Int) -> OptmetanelderRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetanelderRange::len(self : OptmetanelderRange) -> Int { self.size }

pub fn OptmetanelderRange::get(self : OptmetanelderRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetanelderRange::set(self : OptmetanelderRange, i : Int, v : Double) -> OptmetanelderRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetanelderRange::sum(self : OptmetanelderRange) -> Double { @_common.sum(self.data) }

pub fn OptmetanelderRange::mean(self : OptmetanelderRange) -> Double { @_common.mean(self.data) }

pub fn OptmetanelderRange::scale(self : OptmetanelderRange, f : Double) -> OptmetanelderRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetanelderRange::add(self : OptmetanelderRange, other : OptmetanelderRange) -> OptmetanelderRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetanelderRange::copy(self : OptmetanelderRange) -> OptmetanelderRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetanelderRange::fill(self : OptmetanelderRange, v : Double) -> OptmetanelderRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetanelderRange::min(self : OptmetanelderRange) -> Double { @_common.min(self.data) }

pub fn OptmetanelderRange::max(self : OptmetanelderRange) -> Double { @_common.max(self.data) }

pub fn OptmetanelderRange::to_string(self : OptmetanelderRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetanelderSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_slice_make(size : Int) -> OptmetanelderSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetanelderSlice::len(self : OptmetanelderSlice) -> Int { self.size }

pub fn OptmetanelderSlice::get(self : OptmetanelderSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetanelderSlice::set(self : OptmetanelderSlice, i : Int, v : Double) -> OptmetanelderSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetanelderSlice::sum(self : OptmetanelderSlice) -> Double { @_common.sum(self.data) }

pub fn OptmetanelderSlice::mean(self : OptmetanelderSlice) -> Double { @_common.mean(self.data) }

pub fn OptmetanelderSlice::scale(self : OptmetanelderSlice, f : Double) -> OptmetanelderSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetanelderSlice::add(self : OptmetanelderSlice, other : OptmetanelderSlice) -> OptmetanelderSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetanelderSlice::copy(self : OptmetanelderSlice) -> OptmetanelderSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetanelderSlice::fill(self : OptmetanelderSlice, v : Double) -> OptmetanelderSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetanelderSlice::min(self : OptmetanelderSlice) -> Double { @_common.min(self.data) }

pub fn OptmetanelderSlice::max(self : OptmetanelderSlice) -> Double { @_common.max(self.data) }

pub fn OptmetanelderSlice::to_string(self : OptmetanelderSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

